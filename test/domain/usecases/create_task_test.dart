import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/errors/failure.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/domain/entities/sync_status.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';
import 'package:smart_task_manager/domain/usecases/create_task.dart';

import '../../helpers/mocks.dart';
import '../../helpers/task_builder.dart';

void main() {
  final now = DateTime(2026, 1, 1, 10);
  late MockTaskRepository repository;
  late CreateTask createTask;

  setUpAll(() => registerFallbackValue(buildTask()));

  setUp(() {
    repository = MockTaskRepository();
    createTask = CreateTask(
      repository,
      generateId: () => 'generated-id',
      now: () => now,
    );
    when(() => repository.createTask(any())).thenAnswer(
      (invocation) async => Ok(invocation.positionalArguments.first as Task),
    );
  });

  test(
    'saves a pending task with generated id, timestamps and trimmed fields',
    () async {
      final result = await createTask(
        title: '  Buy milk  ',
        description: '   ',
        priority: TaskPriority.high,
        category: TaskCategory.shopping,
      );

      final saved =
          verify(() => repository.createTask(captureAny())).captured.single
              as Task;
      expect(
        saved,
        Task(
          id: 'generated-id',
          title: 'Buy milk',
          priority: TaskPriority.high,
          category: TaskCategory.shopping,
          createdAt: now,
          updatedAt: now,
        ),
      );
      expect(saved.syncStatus, SyncStatus.pending);
      expect(result, isA<Ok<Task>>());
    },
  );

  test(
    'returns ValidationFailure and does not save when title is blank',
    () async {
      final result = await createTask(
        title: '   ',
        priority: TaskPriority.low,
        category: TaskCategory.other,
      );

      expect(
        result,
        isA<Err<Task>>().having(
          (err) => err.failure,
          'failure',
          isA<ValidationFailure>(),
        ),
      );
      verifyNever(() => repository.createTask(any()));
    },
  );

  test('returns the repository failure when saving fails', () async {
    when(() => repository.createTask(any()))
        .thenAnswer((_) async => const Err(CacheFailure()));

    final result = await createTask(
      title: 'Task',
      priority: TaskPriority.medium,
      category: TaskCategory.work,
    );

    expect(
      result,
      isA<Err<Task>>().having(
        (err) => err.failure,
        'failure',
        isA<CacheFailure>(),
      ),
    );
  });
}
