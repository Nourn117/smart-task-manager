import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/errors/failure.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_category.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_priority.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_form/cubit/task_form_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_form/cubit/task_form_state.dart';

import '../../../../../helpers/cubit_helpers.dart';
import '../../../../../helpers/mocks.dart';
import '../../../../../helpers/task_builder.dart';

void main() {
  late MockGetTaskById getTaskById;
  late MockCreateTask createTask;
  late MockUpdateTask updateTask;
  late TaskFormCubit cubit;
  final task = buildTask();

  setUpAll(() {
    registerFallbackValue(buildTask());
    registerFallbackValue(TaskPriority.medium);
    registerFallbackValue(TaskCategory.work);
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    getTaskById = MockGetTaskById();
    createTask = MockCreateTask();
    updateTask = MockUpdateTask();
    cubit = TaskFormCubit(
      getTaskById: getTaskById,
      createTask: createTask,
      updateTask: updateTask,
    );
  });

  tearDown(() => cubit.close());

  Future<Result<Task>> anyCreateTask() => createTask(
    title: any(named: 'title'),
    description: any(named: 'description'),
    priority: any(named: 'priority'),
    category: any(named: 'category'),
    dueDate: any(named: 'dueDate'),
  );

  Future<void> submitNewTask({String title = 'Buy milk'}) => cubit.submit(
    title: title,
    description: '',
    priority: TaskPriority.high,
    category: TaskCategory.shopping,
  );

  group('load', () {
    test('is ready immediately when creating a task', () async {
      expect(await collectStates(cubit, cubit.load), [
        const TaskFormState(status: TaskFormStatus.ready),
      ]);
    });

    test('loads the task when editing', () async {
      when(() => getTaskById('task-1')).thenAnswer((_) async => Ok(task));

      expect(await collectStates(cubit, () => cubit.load(taskId: 'task-1')), [
        TaskFormState(status: TaskFormStatus.ready, initialTask: task),
      ]);
    });

    test('emits loadFailure when the task cannot be found', () async {
      when(() => getTaskById('task-1'))
          .thenAnswer((_) async => const Err(NotFoundFailure()));

      expect(await collectStates(cubit, () => cubit.load(taskId: 'task-1')), [
        const TaskFormState(
          status: TaskFormStatus.loadFailure,
          errorMessage: 'Task not found.',
        ),
      ]);
    });
  });

  group('submit', () {
    test('creates a new task and emits saved', () async {
      when(anyCreateTask).thenAnswer((_) async => Ok(task));
      await cubit.load();

      expect(await collectStates(cubit, submitNewTask), [
        const TaskFormState(status: TaskFormStatus.submitting),
        const TaskFormState(status: TaskFormStatus.saved),
      ]);
      verify(
        () => createTask(
          title: 'Buy milk',
          description: '',
          priority: TaskPriority.high,
          category: TaskCategory.shopping,
          dueDate: null,
        ),
      ).called(1);
    });

    test('updates the existing task when editing', () async {
      when(() => getTaskById('task-1')).thenAnswer((_) async => Ok(task));
      when(() => updateTask(any())).thenAnswer((_) async => Ok(task));
      await cubit.load(taskId: 'task-1');

      await cubit.submit(
        title: 'Renamed',
        description: 'Notes',
        priority: TaskPriority.low,
        category: TaskCategory.health,
        dueDate: DateTime(2026, 3),
      );

      verify(
        () => updateTask(
          task.copyWith(
            title: 'Renamed',
            description: 'Notes',
            priority: TaskPriority.low,
            category: TaskCategory.health,
            dueDate: DateTime(2026, 3),
          ),
        ),
      ).called(1);
    });

    test('returns to ready with the error message when saving fails', () async {
      when(anyCreateTask)
          .thenAnswer((_) async => const Err(ValidationFailure.emptyTitle()));
      await cubit.load();

      expect(await collectStates(cubit, () => submitNewTask(title: ' ')), [
        const TaskFormState(status: TaskFormStatus.submitting),
        const TaskFormState(
          status: TaskFormStatus.ready,
          errorMessage: 'Title is required.',
        ),
      ]);
    });

    test('ignores a second submit while the first is saving', () async {
      when(anyCreateTask).thenAnswer((_) async => Ok(task));
      await cubit.load();

      await Future.wait([submitNewTask(), submitNewTask()]);

      verify(anyCreateTask).called(1);
    });
  });
}
