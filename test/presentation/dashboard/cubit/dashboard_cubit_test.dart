import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/domain/entities/task_query.dart';
import 'package:smart_task_manager/domain/entities/task_summary.dart';
import 'package:smart_task_manager/presentation/dashboard/cubit/dashboard_cubit.dart';

import '../../../helpers/cubit_helpers.dart';
import '../../../helpers/mocks.dart';
import '../../../helpers/task_builder.dart';

void main() {
  late MockWatchTaskSummary watchTaskSummary;
  late MockWatchTasks watchTasks;
  late DashboardCubit cubit;
  final task = buildTask();
  const summary = TaskSummary(total: 3, completed: 1);

  setUpAll(() => registerFallbackValue(const TaskQuery()));

  setUp(() {
    watchTaskSummary = MockWatchTaskSummary();
    watchTasks = MockWatchTasks();
    when(() => watchTaskSummary()).thenAnswer((_) => Stream.value(summary));
    when(() => watchTasks(any())).thenAnswer((_) => Stream.value([task]));
    cubit = DashboardCubit(watchTaskSummary, watchTasks);
  });

  tearDown(() => cubit.close());

  test('initial state is loading', () {
    expect(cubit.state.isLoading, isTrue);
  });

  test('shows the summary and the most recent tasks', () async {
    await collectStates(cubit, cubit.load);

    expect(cubit.state.summary, summary);
    expect(cubit.state.recentTasks, [task]);
    expect(cubit.state.isLoading, isFalse);
    verify(
      () => watchTasks(const TaskQuery(limit: DashboardCubit.recentTasksLimit)),
    ).called(1);
  });

  test('filters the task list by the selected status', () async {
    await collectStates(cubit, cubit.load);

    await collectStates(
      cubit,
      () => cubit.selectStatus(TaskStatusFilter.pending),
    );

    expect(cubit.state.selectedStatus, TaskStatusFilter.pending);
    verify(
      () => watchTasks(
        const TaskQuery(
          status: TaskStatusFilter.pending,
          limit: DashboardCubit.recentTasksLimit,
        ),
      ),
    ).called(1);
  });

  test('emits an error when the summary cannot be loaded', () async {
    when(() => watchTaskSummary())
        .thenAnswer((_) => Stream.error(Exception('database closed')));

    await collectStates(cubit, cubit.load);

    expect(cubit.state.errorMessage, 'Could not load the dashboard.');
  });
}
