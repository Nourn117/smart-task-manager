import 'dart:async';
import 'dart:developer';

import 'package:smart_task_manager/core/database/app_database.dart';
import 'package:smart_task_manager/core/database/tables/sync_queue_table.dart';
import 'package:smart_task_manager/core/errors/exceptions.dart';
import 'package:smart_task_manager/core/network/network_info.dart';
import 'package:smart_task_manager/core/utils/typedefs.dart';
import 'package:smart_task_manager/data/datasources/task_local_data_source.dart';
import 'package:smart_task_manager/data/datasources/task_remote_data_source.dart';
import 'package:smart_task_manager/data/models/task_dto_mapper.dart';
import 'package:smart_task_manager/domain/entities/sync_overview.dart';
import 'package:smart_task_manager/domain/repositories/sync_repository.dart';

/// Sends queued local changes to the server, then fetches remote tasks.
///
/// The local database stays the source of truth: the UI always reads from it,
/// and a change is only marked as synced after the server accepts it.
class SyncRepositoryImpl implements SyncRepository {
  SyncRepositoryImpl({
    required this._localDataSource,
    required this._remoteDataSource,
    required this._networkInfo,
    required this._generateId,
    Clock? now,
  }) : _now = now ?? DateTime.now;

  final TaskLocalDataSource _localDataSource;
  final TaskRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final IdGenerator _generateId;
  final Clock _now;

  final _overviewController = StreamController<SyncOverview>.broadcast();
  final _subscriptions = <StreamSubscription<Object?>>[];

  SyncOverview _overview = const SyncOverview();
  Future<void>? _currentRun;
  bool _rerunRequested = false;
  bool _hasSeenQueue = false;
  DateTime? _latestQueuedChange;

  @override
  Stream<SyncOverview> watchOverview() async* {
    yield _overview;
    yield* _overviewController.stream;
  }

  /// Syncs automatically from now on: once at startup, whenever a local
  /// change is queued and whenever connectivity returns.
  void start() {
    _subscriptions
      ..add(_localDataSource.watchPendingOperations().listen(_onQueueChanged))
      ..add(_networkInfo.onStatusChanged.listen(_onConnectivityChanged));
  }

  @override
  Future<void> syncNow() {
    final currentRun = _currentRun;
    if (currentRun != null) {
      // Never overlap runs; changes made meanwhile get one more pass.
      _rerunRequested = true;
      return currentRun;
    }

    final run = _runUntilIdle().whenComplete(() => _currentRun = null);
    _currentRun = run;
    return run;
  }

  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _overviewController.close();
  }

  void _onQueueChanged(List<SyncQueueEntry> entries) {
    _update(
      _overview.copyWith(
        pendingChanges: entries.length,
        failedChanges: entries.where((entry) => entry.attempts > 0).length,
      ),
    );

    // Bookkeeping such as retry counts also changes the queue; only a newer
    // local change (or the first snapshot at startup) triggers a sync.
    final latest = _latestEnqueuedAt(entries);
    final previous = _latestQueuedChange;
    final hasNewChange =
        latest != null && (previous == null || latest.isAfter(previous));
    if (hasNewChange) _latestQueuedChange = latest;

    final isStartup = !_hasSeenQueue;
    _hasSeenQueue = true;
    if (isStartup || hasNewChange) unawaited(syncNow());
  }

  void _onConnectivityChanged(bool isConnected) {
    _update(_overview.copyWith(isOnline: isConnected));
    if (isConnected) unawaited(syncNow());
  }

  Future<void> _runUntilIdle() async {
    do {
      _rerunRequested = false;
      await _runOnce();
    } while (_rerunRequested && _overview.isOnline);
  }

  Future<void> _runOnce() async {
    if (!await _networkInfo.isConnected()) {
      _update(_overview.copyWith(isOnline: false, isSyncing: false));
      return;
    }

    _update(_overview.copyWith(isSyncing: true));
    try {
      await _pushPendingOperations();
      await _pullRemoteTasks();
      _update(
        _overview.copyWith(
          isOnline: true,
          isSyncing: false,
          lastSyncedAt: _now(),
          lastError: null,
        ),
      );
    } on NetworkException {
      // Connected to a network but the API isn't reachable. Changes stay
      // queued and are retried when connectivity changes or on demand.
      _update(_overview.copyWith(isOnline: false, isSyncing: false));
    } on RemoteException catch (error) {
      _update(
        _overview.copyWith(
          isOnline: true,
          isSyncing: false,
          lastError: error.message,
        ),
      );
    } on Exception catch (error, stackTrace) {
      log(
        'Sync failed',
        name: 'SyncRepository',
        error: error,
        stackTrace: stackTrace,
      );
      _update(
        _overview.copyWith(
          isSyncing: false,
          lastError: 'Sync failed. It will be retried.',
        ),
      );
    }
  }

  Future<void> _pushPendingOperations() async {
    for (final entry in await _localDataSource.getPendingOperations()) {
      try {
        final remoteId = await _push(entry);
        await _localDataSource.completeOperation(entry, remoteId: remoteId);
      } on NetworkException {
        rethrow;
      } on RemoteException catch (error) {
        // Stays queued and is retried on the next run.
        await _localDataSource.failOperation(entry, error.message);
      }
    }
  }

  /// Sends one queued operation and returns the task's remote id, if any.
  Future<int?> _push(SyncQueueEntry entry) async {
    final task = await _localDataSource.getTaskForSync(entry.taskId);
    // Deleted locally before it ever reached the server.
    if (task == null) return null;

    final remoteId = task.remoteId;
    switch (entry.operation) {
      case SyncOperation.create:
        return _createRemote(task);
      case SyncOperation.update:
        if (remoteId == null) return _createRemote(task);
        try {
          await _remoteDataSource.updateTask(
            remoteId,
            title: task.title,
            completed: task.isCompleted,
          );
          return remoteId;
        } on NotFoundException {
          // The server no longer has this task, so upload it again.
          return _createRemote(task);
        }
      case SyncOperation.delete:
        if (remoteId == null) return null;
        try {
          await _remoteDataSource.deleteTask(remoteId);
        } on NotFoundException {
          // Already gone from the server, which is what we wanted.
        }
        return remoteId;
    }
  }

  Future<int> _createRemote(TaskRow task) async {
    final created = await _remoteDataSource.createTask(
      title: task.title,
      completed: task.isCompleted,
    );
    return created.id;
  }

  /// Adds remote tasks the device doesn't have yet. DummyJSON returns no
  /// `updatedAt`, so tasks that already exist locally keep their local values.
  Future<void> _pullRemoteTasks() async {
    final remoteTasks = await _remoteDataSource.fetchTasks();
    final now = _now();
    await _localDataSource.insertMissingRemoteTasks([
      for (final task in remoteTasks)
        task.toCompanion(localId: _generateId(), now: now),
    ]);
  }

  void _update(SyncOverview overview) {
    if (overview == _overview || _overviewController.isClosed) return;
    _overview = overview;
    _overviewController.add(overview);
  }

  static DateTime? _latestEnqueuedAt(List<SyncQueueEntry> entries) {
    DateTime? latest;
    for (final entry in entries) {
      if (latest == null || entry.enqueuedAt.isAfter(latest)) {
        latest = entry.enqueuedAt;
      }
    }
    return latest;
  }
}
