import 'dart:async';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/database/app_database.dart';
import 'package:smart_task_manager/core/database/tables/sync_queue_table.dart';
import 'package:smart_task_manager/core/errors/exceptions.dart';
import 'package:smart_task_manager/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:smart_task_manager/features/tasks/data/models/task_dto.dart';
import 'package:smart_task_manager/features/tasks/data/models/task_row_mapper.dart';
import 'package:smart_task_manager/features/tasks/data/repositories/sync_repository_impl.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/sync_overview.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/sync_status.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/task_builder.dart';
import '../../../../helpers/ticking_clock.dart';

void main() {
  late AppDatabase database;
  late TaskLocalDataSource localDataSource;
  late MockTaskRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;
  late SyncRepositoryImpl repository;
  var importedIds = 0;

  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    final clock = tickingClock();
    localDataSource = TaskLocalDataSource(database, now: clock);
    remoteDataSource = MockTaskRemoteDataSource();
    networkInfo = MockNetworkInfo();
    importedIds = 0;
    repository = SyncRepositoryImpl(
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
      generateId: () => 'imported-${importedIds++}',
      now: clock,
    );

    when(() => networkInfo.isConnected()).thenAnswer((_) async => true);
    when(() => networkInfo.onStatusChanged)
        .thenAnswer((_) => const Stream.empty());
    when(() => remoteDataSource.fetchTasks()).thenAnswer((_) async => []);
  });

  tearDown(() async {
    await repository.dispose();
    await database.close();
  });

  Future<TaskDto> anyCreate() => remoteDataSource.createTask(
    title: any(named: 'title'),
    completed: any(named: 'completed'),
  );

  void stubCreate(int remoteId) {
    when(
      () => remoteDataSource.createTask(
        title: any(named: 'title'),
        completed: any(named: 'completed'),
      ),
    ).thenAnswer(
      (invocation) async => TaskDto(
        id: remoteId,
        title: invocation.namedArguments[#title] as String,
        completed: invocation.namedArguments[#completed] as bool,
      ),
    );
  }

  Future<void> insertSyncedTask(Task task) => database
      .into(database.tasks)
      .insert(task.copyWith(syncStatus: SyncStatus.synced).toCompanion());

  Future<TaskRow?> storedTask([String id = 'task-1']) =>
      localDataSource.getTaskForSync(id);

  group('pushing local changes', () {
    test('uploads a new task and marks it as synced', () async {
      stubCreate(99);
      await localDataSource.insertTask(buildTask().toCompanion());

      await repository.syncNow();

      final task = await storedTask();
      expect(task?.remoteId, 99);
      expect(task?.syncStatus, SyncStatus.synced);
      expect(await localDataSource.getPendingOperations(), isEmpty);
    });

    test('updates a synced task on the server', () async {
      await insertSyncedTask(buildTask(remoteId: 7));
      await localDataSource.updateTask(
        buildTask(remoteId: 7, title: 'Renamed').toCompanion(),
      );
      when(
        () => remoteDataSource.updateTask(
          7,
          title: any(named: 'title'),
          completed: any(named: 'completed'),
        ),
      ).thenAnswer(
        (_) async => const TaskDto(id: 7, title: 'Renamed', completed: false),
      );

      await repository.syncNow();

      verify(
        () =>
            remoteDataSource.updateTask(7, title: 'Renamed', completed: false),
      ).called(1);
      expect((await storedTask())?.syncStatus, SyncStatus.synced);
    });

    test('uploads the task again when the server no longer has it', () async {
      await insertSyncedTask(buildTask(remoteId: 7));
      await localDataSource.updateTask(buildTask(remoteId: 7).toCompanion());
      when(
        () => remoteDataSource.updateTask(
          7,
          title: any(named: 'title'),
          completed: any(named: 'completed'),
        ),
      ).thenThrow(const NotFoundException());
      stubCreate(12);

      await repository.syncNow();

      final task = await storedTask();
      expect(task?.remoteId, 12);
      expect(task?.syncStatus, SyncStatus.synced);
    });

    test(
      'treats deleting a task already gone from the server as done',
      () async {
        await insertSyncedTask(buildTask(remoteId: 7));
        await localDataSource.deleteTask('task-1');
        when(() => remoteDataSource.deleteTask(7))
            .thenThrow(const NotFoundException());

        await repository.syncNow();

        final task = await storedTask();
        expect(task?.isDeleted, isTrue);
        expect(task?.syncStatus, SyncStatus.synced);
        expect(await localDataSource.getPendingOperations(), isEmpty);
      },
    );
  });

  group('failures', () {
    test('does nothing while offline', () async {
      when(() => networkInfo.isConnected()).thenAnswer((_) async => false);
      await localDataSource.insertTask(buildTask().toCompanion());

      await repository.syncNow();

      verifyNever(anyCreate);
      expect(await localDataSource.getPendingOperations(), hasLength(1));
      expect((await repository.watchOverview().first).isOnline, isFalse);
    });

    test('keeps changes pending when the API is unreachable', () async {
      when(anyCreate).thenThrow(const NetworkException());
      await localDataSource.insertTask(buildTask().toCompanion());

      await repository.syncNow();

      final pending = await localDataSource.getPendingOperations();
      expect(pending.single.attempts, 0);
      expect((await storedTask())?.syncStatus, SyncStatus.pending);
      expect((await repository.watchOverview().first).isOnline, isFalse);
    });

    test('marks the task as failed and retries it on the next run', () async {
      when(anyCreate).thenThrow(ServerException(500));
      await localDataSource.insertTask(buildTask().toCompanion());

      await repository.syncNow();

      expect((await storedTask())?.syncStatus, SyncStatus.failed);
      expect((await localDataSource.getPendingOperations()).single.attempts, 1);

      stubCreate(42);
      await repository.syncNow();

      expect((await storedTask())?.syncStatus, SyncStatus.synced);
      expect(await localDataSource.getPendingOperations(), isEmpty);
    });
  });

  group('concurrency', () {
    test('never runs two syncs at the same time', () async {
      final upload = Completer<TaskDto>();
      when(anyCreate).thenAnswer((_) => upload.future);
      await localDataSource.insertTask(buildTask().toCompanion());

      final firstRun = repository.syncNow();
      final secondRun = repository.syncNow();
      await untilCalled(anyCreate);
      upload.complete(const TaskDto(id: 5, title: 'Task', completed: false));
      await Future.wait([firstRun, secondRun]);

      verify(anyCreate).called(1);
    });

    test('sends edits made during an upload as an update', () async {
      final upload = Completer<TaskDto>();
      when(anyCreate).thenAnswer((_) => upload.future);
      when(
        () => remoteDataSource.updateTask(
          5,
          title: any(named: 'title'),
          completed: any(named: 'completed'),
        ),
      ).thenAnswer(
        (_) async => const TaskDto(id: 5, title: 'Renamed', completed: false),
      );
      await localDataSource.insertTask(buildTask().toCompanion());

      final run = repository.syncNow();
      await untilCalled(anyCreate);
      await localDataSource.updateTask(
        buildTask(title: 'Renamed').toCompanion(),
      );
      upload.complete(const TaskDto(id: 5, title: 'Task', completed: false));
      await run;

      final pending = await localDataSource.getPendingOperations();
      expect(pending.single.operation, SyncOperation.update);

      await repository.syncNow();

      verify(anyCreate).called(1);
      verify(
        () =>
            remoteDataSource.updateTask(5, title: 'Renamed', completed: false),
      ).called(1);
      expect((await storedTask())?.syncStatus, SyncStatus.synced);
    });
  });

  group('fetching remote tasks', () {
    test('adds new remote tasks without touching local ones', () async {
      await insertSyncedTask(buildTask(id: 'mine', remoteId: 1, title: 'Mine'));
      await insertSyncedTask(buildTask(id: 'gone', remoteId: 2));
      await localDataSource.deleteTask('gone');
      when(() => remoteDataSource.deleteTask(2)).thenAnswer((_) async {});
      when(() => remoteDataSource.fetchTasks()).thenAnswer(
        (_) async => const [
          TaskDto(id: 1, title: 'Server version', completed: true),
          TaskDto(id: 2, title: 'Deleted locally', completed: false),
          TaskDto(id: 3, title: 'New', completed: false),
        ],
      );

      await repository.syncNow();

      final rows = await database.select(database.tasks).get();
      expect(rows, hasLength(3));
      expect(rows.firstWhere((row) => row.remoteId == 1).title, 'Mine');
      expect(rows.firstWhere((row) => row.remoteId == 2).isDeleted, isTrue);
      final imported = rows.firstWhere((row) => row.remoteId == 3);
      expect(imported.title, 'New');
      expect(imported.syncStatus, SyncStatus.synced);
    });
  });

  group('automatic sync', () {
    test('uploads a change as soon as it is queued', () async {
      stubCreate(8);
      repository.start();

      await localDataSource.insertTask(buildTask().toCompanion());
      await untilCalled(anyCreate);
      await repository.syncNow();

      expect((await storedTask())?.syncStatus, SyncStatus.synced);
    });

    test('syncs when connectivity returns', () async {
      var isConnected = false;
      final connectivity = StreamController<bool>();
      addTearDown(connectivity.close);
      when(() => networkInfo.isConnected())
          .thenAnswer((_) async => isConnected);
      when(() => networkInfo.onStatusChanged)
          .thenAnswer((_) => connectivity.stream);
      repository.start();
      await repository.syncNow();
      verifyNever(() => remoteDataSource.fetchTasks());

      isConnected = true;
      connectivity.add(true);
      await untilCalled(() => remoteDataSource.fetchTasks());

      expect((await repository.watchOverview().first).isOnline, isTrue);
    });

    test('reports pending and failed changes', () async {
      when(() => networkInfo.isConnected()).thenAnswer((_) async => false);
      repository.start();

      await localDataSource.insertTask(buildTask().toCompanion());

      await expectLater(
        repository.watchOverview(),
        emitsThrough(
          isA<SyncOverview>().having(
            (overview) => overview.pendingChanges,
            'pendingChanges',
            1,
          ),
        ),
      );
    });
  });
}
