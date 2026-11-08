import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/errors/failure.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_details/cubit/task_details_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_details/cubit/task_details_state.dart';

import '../../../../../helpers/cubit_helpers.dart';
import '../../../../../helpers/mocks.dart';
import '../../../../../helpers/task_builder.dart';

void main() {
  late MockWatchTask watchTask;
  late MockToggleTaskCompletion toggleTaskCompletion;
  late MockDeleteTask deleteTask;
  late TaskDetailsCubit cubit;
  final task = buildTask();

  setUpAll(() => registerFallbackValue(buildTask()));

  setUp(() {
    watchTask = MockWatchTask();
    toggleTaskCompletion = MockToggleTaskCompletion();
    deleteTask = MockDeleteTask();
    when(() => watchTask('task-1')).thenAnswer((_) => Stream.value(task));
    cubit = TaskDetailsCubit(
      watchTask: watchTask,
      toggleTaskCompletion: toggleTaskCompletion,
      deleteTask: deleteTask,
    );
  });

  tearDown(() => cubit.close());

  Future<List<TaskDetailsState>> watchTask1() =>
      collectStates(cubit, () => cubit.watch('task-1'));

  test('emits the task when it exists', () async {
    expect(await watchTask1(), [TaskDetailsState.loaded(task)]);
  });

  test('emits notFound when the task does not exist', () async {
    when(() => watchTask('task-1'))
        .thenAnswer((_) => Stream<Task?>.value(null));

    expect(await watchTask1(), [const TaskDetailsState.notFound()]);
  });

  test('emits failure when the task cannot be loaded', () async {
    when(() => watchTask('task-1'))
        .thenAnswer((_) => Stream.error(Exception('database closed')));

    expect(await watchTask1(), [
      const TaskDetailsState.failure('Could not load this task.'),
    ]);
  });

  test('toggles completion and closes the screen', () async {
    final completedTask = task.copyWith(isCompleted: true);
    when(() => toggleTaskCompletion(task))
        .thenAnswer((_) async => Ok(completedTask));
    await watchTask1();

    expect(await collectStates(cubit, cubit.toggleCompletion), [
      TaskDetailsState.loaded(task, isBusy: true),
      const TaskDetailsState.completionToggled(isCompleted: true),
    ]);
  });

  test('emits deleted after a successful delete', () async {
    when(() => deleteTask('task-1')).thenAnswer((_) async => const Ok(null));
    await watchTask1();

    expect(await collectStates(cubit, cubit.delete), [
      TaskDetailsState.loaded(task, isBusy: true),
      const TaskDetailsState.deleted(),
    ]);
  });

  test('keeps the task and reports the error when toggling fails', () async {
    when(() => toggleTaskCompletion(task))
        .thenAnswer((_) async => const Err(CacheFailure()));
    await watchTask1();

    expect(await collectStates(cubit, cubit.toggleCompletion), [
      TaskDetailsState.loaded(task, isBusy: true),
      TaskDetailsState.loaded(task, errorMessage: const CacheFailure().message),
    ]);
  });

  test('keeps the task and reports the error when delete fails', () async {
    when(() => deleteTask('task-1'))
        .thenAnswer((_) async => const Err(CacheFailure()));
    await watchTask1();

    expect(await collectStates(cubit, cubit.delete), [
      TaskDetailsState.loaded(task, isBusy: true),
      TaskDetailsState.loaded(task, errorMessage: const CacheFailure().message),
    ]);
  });
}
