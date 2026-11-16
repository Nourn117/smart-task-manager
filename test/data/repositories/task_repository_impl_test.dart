import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/database/app_database.dart';
import 'package:smart_task_manager/core/errors/failure.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/data/repositories/task_repository_impl.dart';
import 'package:smart_task_manager/domain/entities/sync_status.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';

import '../../helpers/mocks.dart';
import '../../helpers/task_builder.dart';

void main() {
  late MockTaskLocalDataSource localDataSource;
  late TaskRepositoryImpl repository;

  setUpAll(() => registerFallbackValue(const TasksCompanion()));

  setUp(() {
    localDataSource = MockTaskLocalDataSource();
    repository = TaskRepositoryImpl(localDataSource);
  });

  Matcher isFailure<T, F extends Failure>() =>
      isA<Err<T>>().having((err) => err.failure, 'failure', isA<F>());

  group('createTask', () {
    test('saves the task locally marked as pending sync', () async {
      when(() => localDataSource.insertTask(any())).thenAnswer((_) async {});

      final result = await repository.createTask(
        buildTask(syncStatus: SyncStatus.synced),
      );

      final saved =
          verify(() => localDataSource.insertTask(captureAny())).captured.single
              as TasksCompanion;
      expect(saved.syncStatus.value, SyncStatus.pending);
      expect(
        result,
        isA<Ok<Task>>().having(
          (ok) => ok.value.syncStatus,
          'syncStatus',
          SyncStatus.pending,
        ),
      );
    });

    test('returns CacheFailure when local storage throws', () async {
      when(() => localDataSource.insertTask(any()))
          .thenThrow(Exception('disk full'));

      final result = await repository.createTask(buildTask());

      expect(result, isFailure<Task, CacheFailure>());
    });
  });

  group('updateTask', () {
    test('returns the task marked as pending sync', () async {
      when(() => localDataSource.updateTask(any()))
          .thenAnswer((_) async => true);

      final result = await repository.updateTask(
        buildTask(syncStatus: SyncStatus.synced),
      );

      expect(
        result,
        isA<Ok<Task>>().having(
          (ok) => ok.value.syncStatus,
          'syncStatus',
          SyncStatus.pending,
        ),
      );
    });

    test('returns NotFoundFailure when the task does not exist', () async {
      when(() => localDataSource.updateTask(any()))
          .thenAnswer((_) async => false);

      final result = await repository.updateTask(buildTask());

      expect(result, isFailure<Task, NotFoundFailure>());
    });
  });

  group('deleteTask', () {
    test('succeeds when the task is deleted', () async {
      when(() => localDataSource.deleteTask('task-1'))
          .thenAnswer((_) async => true);

      expect(await repository.deleteTask('task-1'), isA<Ok<void>>());
    });

    test('returns NotFoundFailure when the task does not exist', () async {
      when(() => localDataSource.deleteTask('task-1'))
          .thenAnswer((_) async => false);

      final result = await repository.deleteTask('task-1');

      expect(result, isFailure<void, NotFoundFailure>());
    });
  });

  group('getTaskById', () {
    test('maps the stored row to a task', () async {
      when(() => localDataSource.getTaskById('task-1')).thenAnswer(
        (_) async => TaskRow(
          id: 'task-1',
          title: 'Task',
          priority: TaskPriority.medium,
          category: TaskCategory.work,
          isCompleted: false,
          createdAt: DateTime(2026),
          updatedAt: DateTime(2026),
          syncStatus: SyncStatus.pending,
          isDeleted: false,
        ),
      );

      final result = await repository.getTaskById('task-1');

      expect(
        result,
        isA<Ok<Task>>().having((ok) => ok.value, 'task', buildTask()),
      );
    });

    test('returns NotFoundFailure when the task does not exist', () async {
      when(() => localDataSource.getTaskById('task-1'))
          .thenAnswer((_) async => null);

      final result = await repository.getTaskById('task-1');

      expect(result, isFailure<Task, NotFoundFailure>());
    });
  });
}
