import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_task_manager/core/database/app_database.dart';
import 'package:smart_task_manager/core/database/tables/sync_queue_table.dart';
import 'package:smart_task_manager/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:smart_task_manager/features/tasks/data/models/task_row_mapper.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/sync_status.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_category.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_priority.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_query.dart';

import '../../../../helpers/task_builder.dart';
import '../../../../helpers/ticking_clock.dart';

void main() {
  late AppDatabase database;
  late TaskLocalDataSource dataSource;

  setUpAll(() => driftRuntimeOptions.dontWarnAboutMultipleDatabases = true);

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dataSource = TaskLocalDataSource(database, now: () => DateTime(2026, 5));
  });

  tearDown(() => database.close());

  Future<List<SyncOperation>> queuedOperations() async {
    final entries = await database.select(database.syncQueue).get();
    return entries.map((entry) => entry.operation).toList();
  }

  Future<void> insertSyncedTask(Task task) => database
      .into(database.tasks)
      .insert(task.copyWith(syncStatus: SyncStatus.synced).toCompanion());

  group('watchTasks', () {
    setUp(() async {
      final tasks = [
        buildTask(
          id: 'a',
          title: 'Buy milk',
          priority: TaskPriority.high,
          category: TaskCategory.shopping,
          dueDate: DateTime(2026, 2, 10),
          createdAt: DateTime(2026, 1, 1),
        ),
        buildTask(
          id: 'b',
          title: 'Write report',
          isCompleted: true,
          createdAt: DateTime(2026, 1, 2),
        ),
        buildTask(
          id: 'c',
          title: 'Buy flowers',
          priority: TaskPriority.low,
          category: TaskCategory.personal,
          dueDate: DateTime(2026, 2, 1),
          createdAt: DateTime(2026, 1, 3),
        ),
      ];
      for (final task in tasks) {
        await dataSource.insertTask(task.toCompanion());
      }
    });

    Future<List<String>> ids(TaskQuery query) async {
      final rows = await dataSource.watchTasks(query).first;
      return rows.map((row) => row.id).toList();
    }

    test('sorts newest first by default', () async {
      expect(await ids(const TaskQuery()), ['c', 'b', 'a']);
    });

    test('sorts oldest first', () async {
      expect(await ids(const TaskQuery(sortBy: TaskSortOption.oldestFirst)), [
        'a',
        'b',
        'c',
      ]);
    });

    test('sorts by due date with undated tasks last', () async {
      expect(
        await ids(const TaskQuery(sortBy: TaskSortOption.dueDateSoonest)),
        ['c', 'a', 'b'],
      );
      expect(await ids(const TaskQuery(sortBy: TaskSortOption.dueDateLatest)), [
        'a',
        'c',
        'b',
      ]);
    });

    test('searches titles case-insensitively and ignores spaces', () async {
      expect(await ids(const TaskQuery(searchTerm: '  BUY ')), ['c', 'a']);
    });

    test('filters by status', () async {
      expect(await ids(const TaskQuery(status: TaskStatusFilter.pending)), [
        'c',
        'a',
      ]);
      expect(await ids(const TaskQuery(status: TaskStatusFilter.completed)), [
        'b',
      ]);
    });

    test('filters by priority and category', () async {
      expect(await ids(const TaskQuery(priority: TaskPriority.high)), ['a']);
      expect(await ids(const TaskQuery(category: TaskCategory.work)), ['b']);
    });

    test('applies the page limit', () async {
      expect(await ids(const TaskQuery(limit: 2)), ['c', 'b']);
    });

    test('hides deleted tasks', () async {
      await insertSyncedTask(buildTask(id: 'd', remoteId: 4));
      await dataSource.deleteTask('d');

      expect(await ids(const TaskQuery()), isNot(contains('d')));
    });
  });

  group('insertTask', () {
    test('stores the task and queues a create operation', () async {
      await dataSource.insertTask(buildTask().toCompanion());

      expect(await dataSource.getTaskById('task-1'), isNotNull);
      expect(await queuedOperations(), [SyncOperation.create]);
    });
  });

  group('updateTask', () {
    test('keeps a single create operation for a never-synced task', () async {
      await dataSource.insertTask(buildTask().toCompanion());

      final updated = await dataSource.updateTask(
        buildTask(title: 'Renamed').toCompanion(),
      );

      expect(updated, isTrue);
      expect((await dataSource.getTaskById('task-1'))?.title, 'Renamed');
      expect(await queuedOperations(), [SyncOperation.create]);
    });

    test('queues an update for a synced task', () async {
      await insertSyncedTask(buildTask(remoteId: 7));

      await dataSource.updateTask(buildTask(remoteId: 7).toCompanion());

      expect(await queuedOperations(), [SyncOperation.update]);
    });

    test('returns false when the task does not exist', () async {
      final updated = await dataSource.updateTask(buildTask().toCompanion());

      expect(updated, isFalse);
      expect(await queuedOperations(), isEmpty);
    });
  });

  group('deleteTask', () {
    test(
      'removes a never-synced task together with its queued create',
      () async {
        await dataSource.insertTask(buildTask().toCompanion());

        final deleted = await dataSource.deleteTask('task-1');

        expect(deleted, isTrue);
        expect(await database.select(database.tasks).get(), isEmpty);
        expect(await queuedOperations(), isEmpty);
      },
    );

    test('keeps a tombstone and queues a delete for a synced task', () async {
      await insertSyncedTask(buildTask(remoteId: 7));

      final deleted = await dataSource.deleteTask('task-1');

      final row = await database.select(database.tasks).getSingle();
      expect(deleted, isTrue);
      expect(row.isDeleted, isTrue);
      expect(await dataSource.getTaskById('task-1'), isNull);
      expect(await queuedOperations(), [SyncOperation.delete]);
    });

    test('returns false when the task does not exist', () async {
      expect(await dataSource.deleteTask('missing'), isFalse);
    });
  });

  test('watchTaskById emits null once the task is deleted', () async {
    await insertSyncedTask(buildTask(remoteId: 7));
    expect(await dataSource.watchTaskById('task-1').first, isNotNull);

    final emitsNull = expectLater(
      dataSource.watchTaskById('task-1'),
      emitsThrough(isNull),
    );
    await dataSource.deleteTask('task-1');
    await emitsNull;
  });

  group('sync queue', () {
    late TaskLocalDataSource syncDataSource;

    setUp(() {
      // Distinct timestamps, so changes made during an upload are detected.
      syncDataSource = TaskLocalDataSource(database, now: tickingClock());
    });

    test('returns pending operations oldest first', () async {
      await syncDataSource.insertTask(buildTask(id: 'a').toCompanion());
      await syncDataSource.insertTask(buildTask(id: 'b').toCompanion());

      final pending = await syncDataSource.getPendingOperations();

      expect(pending.map((entry) => entry.taskId), ['a', 'b']);
    });

    test(
      'completing an operation removes it and marks the task synced',
      () async {
        await syncDataSource.insertTask(buildTask().toCompanion());
        final entry = (await syncDataSource.getPendingOperations()).single;

        await syncDataSource.completeOperation(entry, remoteId: 9);

        final task = await syncDataSource.getTaskForSync('task-1');
        expect(task?.remoteId, 9);
        expect(task?.syncStatus, SyncStatus.synced);
        expect(await syncDataSource.getPendingOperations(), isEmpty);
      },
    );

    test('an edit made during an upload is kept as an update', () async {
      await syncDataSource.insertTask(buildTask().toCompanion());
      final uploading = (await syncDataSource.getPendingOperations()).single;
      await syncDataSource.updateTask(buildTask(title: 'New').toCompanion());

      await syncDataSource.completeOperation(uploading, remoteId: 9);

      final pending = (await syncDataSource.getPendingOperations()).single;
      expect(pending.operation, SyncOperation.update);
      expect(
        (await syncDataSource.getTaskForSync('task-1'))?.syncStatus,
        SyncStatus.pending,
      );
    });

    test(
      'failing an operation keeps it queued and marks the task failed',
      () async {
        await syncDataSource.insertTask(buildTask().toCompanion());
        final entry = (await syncDataSource.getPendingOperations()).single;

        await syncDataSource.failOperation(entry, 'Server error');

        final pending = (await syncDataSource.getPendingOperations()).single;
        expect(pending.attempts, 1);
        expect(pending.lastError, 'Server error');
        expect(
          (await syncDataSource.getTaskForSync('task-1'))?.syncStatus,
          SyncStatus.failed,
        );
      },
    );

    test('inserts only remote tasks that are not stored yet', () async {
      await insertSyncedTask(buildTask(id: 'mine', remoteId: 1));

      final inserted = await syncDataSource.insertMissingRemoteTasks([
        buildTask(id: 'dup', remoteId: 1).toCompanion(),
        buildTask(id: 'new', remoteId: 2).toCompanion(),
      ]);

      expect(inserted, 1);
      expect(await syncDataSource.getTaskForSync('dup'), isNull);
      expect(await syncDataSource.getTaskForSync('new'), isNotNull);
    });
  });

  test('watchSummary counts visible tasks only', () async {
    await dataSource.insertTask(buildTask(id: 'a').toCompanion());
    await dataSource.insertTask(
      buildTask(id: 'b', isCompleted: true).toCompanion(),
    );
    await insertSyncedTask(buildTask(id: 'c', remoteId: 3));
    await dataSource.deleteTask('c');

    final summary = await dataSource.watchSummary().first;

    expect(summary.total, 2);
    expect(summary.completed, 1);
  });

  test('keeps tasks and queued operations after the app restarts', () async {
    final directory = await Directory.systemTemp.createTemp('task_db_test');
    final file = File('${directory.path}/tasks.sqlite');

    final firstSession = AppDatabase(NativeDatabase(file));
    await TaskLocalDataSource(firstSession)
        .insertTask(buildTask().toCompanion());
    await firstSession.close();

    final secondSession = AppDatabase(NativeDatabase(file));
    addTearDown(() async {
      await secondSession.close();
      await directory.delete(recursive: true);
    });

    final row = await TaskLocalDataSource(secondSession).getTaskById('task-1');
    final queue = await secondSession.select(secondSession.syncQueue).get();
    expect(row, isNotNull);
    expect(queue.single.operation, SyncOperation.create);
  });
}
