import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/entities/task_query.dart';
import 'package:smart_task_manager/presentation/tasks/cubit/tasks_cubit.dart';
import 'package:smart_task_manager/presentation/tasks/cubit/tasks_state.dart';

import '../../../helpers/cubit_helpers.dart';
import '../../../helpers/mocks.dart';
import '../../../helpers/task_builder.dart';

void main() {
  late MockWatchTasks watchTasks;
  late TasksCubit cubit;
  final task = buildTask(title: 'Buy milk');
  final fullPage = List.generate(
    TasksCubit.pageSize,
    (index) => buildTask(id: 'task-$index'),
  );

  setUpAll(() => registerFallbackValue(const TaskQuery()));

  setUp(() {
    watchTasks = MockWatchTasks();
    when(() => watchTasks(any())).thenAnswer((_) => Stream.value([task]));
    cubit = TasksCubit(
      watchTasks,
      searchDebounce: const Duration(milliseconds: 20),
    );
  });

  tearDown(() => cubit.close());

  void stubTasks(List<Task> tasks) =>
      when(() => watchTasks(any())).thenAnswer((_) => Stream.value(tasks));

  test('initial state is loading with the default query', () {
    expect(cubit.state, const TasksState());
  });

  test('emits loaded when tasks arrive', () async {
    expect(await collectStates(cubit, cubit.load), [
      TasksState(status: TasksStatus.loaded, tasks: [task]),
    ]);
  });

  test('emits empty when there are no tasks', () async {
    stubTasks([]);

    expect(await collectStates(cubit, cubit.load), [
      const TasksState(status: TasksStatus.empty),
    ]);
  });

  test('emits error when loading fails', () async {
    when(() => watchTasks(any()))
        .thenAnswer((_) => Stream.error(Exception('database closed')));

    expect(await collectStates(cubit, cubit.load), [
      const TasksState(
        status: TasksStatus.error,
        errorMessage: 'Could not load tasks.',
      ),
    ]);
  });

  test('reports more tasks when a full page is returned', () async {
    stubTasks(fullPage);

    await collectStates(cubit, cubit.load);

    expect(cubit.state.hasMore, isTrue);
  });

  test('debounces search and queries only the latest term', () async {
    await collectStates(
      cubit,
      () => cubit
        ..searchChanged('b')
        ..searchChanged('bu')
        ..searchChanged('buy'),
      wait: const Duration(milliseconds: 60),
    );

    verify(() => watchTasks(const TaskQuery(searchTerm: 'buy'))).called(1);
    verifyNever(() => watchTasks(const TaskQuery(searchTerm: 'b')));
    verifyNever(() => watchTasks(const TaskQuery(searchTerm: 'bu')));
  });

  test('re-queries with the selected status filter', () async {
    const query = TaskQuery(status: TaskStatusFilter.completed);

    final states = await collectStates(
      cubit,
      () => cubit.statusChanged(TaskStatusFilter.completed),
    );

    expect(states, [
      const TasksState(query: query),
      TasksState(query: query, status: TasksStatus.loaded, tasks: [task]),
    ]);
  });

  test('loads the next page when more tasks are available', () async {
    stubTasks(fullPage);
    await collectStates(cubit, cubit.load);

    await collectStates(cubit, cubit.loadMore);

    verify(() => watchTasks(const TaskQuery(limit: TasksCubit.pageSize * 2)))
        .called(1);
  });

  test('does not load more when every task is already shown', () async {
    await collectStates(cubit, cubit.load);

    await collectStates(cubit, cubit.loadMore);

    verifyNever(
      () => watchTasks(const TaskQuery(limit: TasksCubit.pageSize * 2)),
    );
  });
}
