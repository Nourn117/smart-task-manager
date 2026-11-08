import 'package:drift/drift.dart';
import 'package:smart_task_manager/core/database/app_database.dart';
import 'package:smart_task_manager/core/database/tables/sync_queue_table.dart';
import 'package:smart_task_manager/core/utils/typedefs.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/sync_status.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_query.dart';

class TaskLocalDataSource {
  TaskLocalDataSource(this._db, {Clock? now}) : _now = now ?? DateTime.now;

  final AppDatabase _db;
  final Clock _now;

  Stream<List<TaskRow>> watchTasks(TaskQuery query) {
    final searchTerm = query.searchTerm.trim().toLowerCase();

    final statement = _db.select(_db.tasks)
      ..where((task) {
        final statusFilter = switch (query.status) {
          TaskStatusFilter.all => null,
          TaskStatusFilter.pending => task.isCompleted.equals(false),
          TaskStatusFilter.completed => task.isCompleted.equals(true),
        };

        return Expression.and([
          task.isDeleted.equals(false),
          if (searchTerm.isNotEmpty) task.title.lower().like('%$searchTerm%'),
          ?statusFilter,
          if (query.priority case final priority?)
            task.priority.equalsValue(priority),
          if (query.category case final category?)
            task.category.equalsValue(category),
        ]);
      })
      ..orderBy(_orderBy(query.sortBy))
      ..limit(query.limit);

    return statement.watch();
  }

  Stream<({int total, int completed})> watchSummary() {
    final total = _db.tasks.id.count();
    final completed = _db.tasks.id.count(
      filter: _db.tasks.isCompleted.equals(true),
    );

    final statement = _db.selectOnly(_db.tasks)
      ..addColumns([total, completed])
      ..where(_db.tasks.isDeleted.equals(false));

    return statement.watchSingle().map(
      (row) =>
          (total: row.read(total) ?? 0, completed: row.read(completed) ?? 0),
    );
  }

  Stream<TaskRow?> watchTaskById(String id) =>
      _selectById(id).watchSingleOrNull();

  Future<TaskRow?> getTaskById(String id) => _selectById(id).getSingleOrNull();

  Future<void> insertTask(TasksCompanion task) => _db.transaction(() async {
    await _db.into(_db.tasks).insert(task);
    await _enqueue(task.id.value, SyncOperation.create);
  });

  /// Returns false when the task does not exist.
  Future<bool> updateTask(TasksCompanion task) => _db.transaction(() async {
    final statement = _db.update(_db.tasks)
      ..where(
        (row) => row.id.equals(task.id.value) & row.isDeleted.equals(false),
      );
    final updatedRows = await statement.write(task);
    if (updatedRows == 0) return false;

    await _enqueue(task.id.value, SyncOperation.update);
    return true;
  });

  /// Returns false when the task does not exist.
  Future<bool> deleteTask(String id) => _db.transaction(() async {
    if (await _pendingOperation(id) == SyncOperation.create) {
      // Never reached the server: remove it completely.
      // The queued create is removed by the foreign key cascade.
      final statement = _db.delete(_db.tasks)
        ..where((task) => task.id.equals(id));
      return await statement.go() > 0;
    }

    // Keep a tombstone so the remote delete can be sent later.
    final statement = _db.update(_db.tasks)
      ..where((task) => task.id.equals(id) & task.isDeleted.equals(false));
    final updatedRows = await statement.write(
      const TasksCompanion(
        isDeleted: Value(true),
        syncStatus: Value(SyncStatus.pending),
      ),
    );
    if (updatedRows == 0) return false;

    await _enqueue(id, SyncOperation.delete);
    return true;
  });

  // ---------------------------------------------------------------------------
  // Sync support
  // ---------------------------------------------------------------------------

  /// Pending operations, oldest first.
  Future<List<SyncQueueEntry>> getPendingOperations() =>
      _pendingOperationsStatement().get();

  /// Emits the queue whenever it changes.
  Stream<List<SyncQueueEntry>> watchPendingOperations() =>
      _pendingOperationsStatement().watch();

  /// Unlike [getTaskById], this includes deleted tasks (tombstones), which
  /// still need their delete sent to the server.
  Future<TaskRow?> getTaskForSync(String id) {
    final statement = _db.select(_db.tasks)
      ..where((task) => task.id.equals(id));
    return statement.getSingleOrNull();
  }

  /// Records that [entry] reached the server.
  ///
  /// The task only becomes synced when nothing changed while it was uploading;
  /// otherwise the newer change stays queued.
  Future<void> completeOperation(SyncQueueEntry entry, {int? remoteId}) {
    return _db.transaction(() async {
      if (remoteId != null) {
        await _updateTaskRow(
          entry.taskId,
          TasksCompanion(remoteId: Value(remoteId)),
        );
      }

      final current = await _queueEntry(entry.taskId);
      if (current == null) return;

      if (current.enqueuedAt == entry.enqueuedAt) {
        await _deleteQueueEntry(entry.taskId);
        await _updateTaskRow(
          entry.taskId,
          const TasksCompanion(syncStatus: Value(SyncStatus.synced)),
        );
      } else if (current.operation == SyncOperation.create) {
        // Edited while its create was uploading: the task now exists on the
        // server, so send those edits as an update instead of a second create.
        await _updateQueueEntry(
          entry.taskId,
          const SyncQueueCompanion(operation: Value(SyncOperation.update)),
        );
      }
    });
  }

  /// Keeps [entry] queued for a retry and marks its task as failed.
  Future<void> failOperation(SyncQueueEntry entry, String error) {
    return _db.transaction(() async {
      final current = await _queueEntry(entry.taskId);
      // A newer change replaced this entry; it gets its own attempt.
      if (current == null || current.enqueuedAt != entry.enqueuedAt) return;

      await _updateQueueEntry(
        entry.taskId,
        SyncQueueCompanion(
          attempts: Value(current.attempts + 1),
          lastError: Value(error),
        ),
      );
      await _updateTaskRow(
        entry.taskId,
        const TasksCompanion(syncStatus: Value(SyncStatus.failed)),
      );
    });
  }

  /// Stores remote tasks the device doesn't have yet and returns how many
  /// were added. Tasks already stored, including deleted ones, are left
  /// untouched so local changes are never overwritten.
  Future<int> insertMissingRemoteTasks(List<TasksCompanion> tasks) {
    return _db.transaction(() async {
      var inserted = 0;
      for (final task in tasks) {
        final remoteId = task.remoteId.value;
        if (remoteId == null) continue;

        final existing = _db.select(_db.tasks)
          ..where((row) => row.remoteId.equals(remoteId))
          ..limit(1);
        if (await existing.getSingleOrNull() != null) continue;

        await _db.into(_db.tasks).insert(task);
        inserted++;
      }
      return inserted;
    });
  }

  Future<void> _enqueue(String taskId, SyncOperation operation) async {
    // A pending create uploads the latest saved state, so later edits fold
    // into it. Its timestamp still moves so an in-flight upload notices them.
    if (operation == SyncOperation.update &&
        await _pendingOperation(taskId) == SyncOperation.create) {
      await _updateQueueEntry(
        taskId,
        SyncQueueCompanion(enqueuedAt: Value(_now())),
      );
      return;
    }

    await _db
        .into(_db.syncQueue)
        .insertOnConflictUpdate(
          SyncQueueCompanion.insert(
            taskId: taskId,
            operation: operation,
            enqueuedAt: _now(),
            attempts: const Value(0),
            lastError: const Value(null),
          ),
        );
  }

  SimpleSelectStatement<$TasksTable, TaskRow> _selectById(String id) {
    return _db.select(_db.tasks)
      ..where((task) => task.id.equals(id) & task.isDeleted.equals(false));
  }

  Future<SyncOperation?> _pendingOperation(String taskId) async =>
      (await _queueEntry(taskId))?.operation;

  Future<SyncQueueEntry?> _queueEntry(String taskId) {
    final statement = _db.select(_db.syncQueue)
      ..where((entry) => entry.taskId.equals(taskId));
    return statement.getSingleOrNull();
  }

  SimpleSelectStatement<$SyncQueueTable, SyncQueueEntry>
  _pendingOperationsStatement() {
    return _db.select(_db.syncQueue)
      ..orderBy([(entry) => OrderingTerm.asc(entry.enqueuedAt)]);
  }

  Future<void> _updateQueueEntry(String taskId, SyncQueueCompanion changes) {
    final statement = _db.update(_db.syncQueue)
      ..where((entry) => entry.taskId.equals(taskId));
    return statement.write(changes);
  }

  Future<void> _deleteQueueEntry(String taskId) {
    final statement = _db.delete(_db.syncQueue)
      ..where((entry) => entry.taskId.equals(taskId));
    return statement.go();
  }

  Future<void> _updateTaskRow(String taskId, TasksCompanion changes) {
    final statement = _db.update(_db.tasks)
      ..where((task) => task.id.equals(taskId));
    return statement.write(changes);
  }

  List<OrderClauseGenerator<$TasksTable>> _orderBy(TaskSortOption sortBy) {
    return switch (sortBy) {
      TaskSortOption.newestFirst => [
        (task) => OrderingTerm.desc(task.createdAt),
      ],
      TaskSortOption.oldestFirst => [
        (task) => OrderingTerm.asc(task.createdAt),
      ],
      TaskSortOption.dueDateSoonest => [
        (task) => OrderingTerm.asc(task.dueDate, nulls: NullsOrder.last),
        (task) => OrderingTerm.desc(task.createdAt),
      ],
      TaskSortOption.dueDateLatest => [
        (task) => OrderingTerm.desc(task.dueDate, nulls: NullsOrder.last),
        (task) => OrderingTerm.desc(task.createdAt),
      ],
    };
  }
}
