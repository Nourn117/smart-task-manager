import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_query.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/cubit/tasks_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/cubit/tasks_state.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/tasks_page.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/task_builder.dart';

void main() {
  late MockTasksCubit cubit;

  setUp(() => cubit = MockTasksCubit());

  Future<void> pumpTasksView(WidgetTester tester, TasksState state) async {
    stubState(cubit, state);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TasksCubit>.value(
          value: cubit,
          child: const TasksView(),
        ),
      ),
    );
  }

  testWidgets('renders the tasks', (tester) async {
    await pumpTasksView(
      tester,
      TasksState(
        status: TasksStatus.loaded,
        tasks: [
          buildTask(title: 'Buy milk'),
          buildTask(id: 'task-2', title: 'Write report'),
        ],
      ),
    );

    expect(find.text('Buy milk'), findsOneWidget);
    expect(find.text('Write report'), findsOneWidget);
  });

  testWidgets('shows the empty state when there are no tasks', (tester) async {
    await pumpTasksView(tester, const TasksState(status: TasksStatus.empty));

    expect(find.text('No tasks yet. Tap + to add one.'), findsOneWidget);
  });

  testWidgets('shows a different empty state when filters are active', (
    tester,
  ) async {
    await pumpTasksView(
      tester,
      const TasksState(
        status: TasksStatus.empty,
        query: TaskQuery(status: TaskStatusFilter.completed),
      ),
    );

    expect(find.text('No tasks match your filters.'), findsOneWidget);
  });

  testWidgets('sends search input to the cubit', (tester) async {
    await pumpTasksView(tester, const TasksState(status: TasksStatus.empty));

    await tester.enterText(find.byType(TextField), 'milk');

    verify(() => cubit.searchChanged('milk')).called(1);
  });

  testWidgets('filters by status when a chip is tapped', (tester) async {
    await pumpTasksView(tester, const TasksState(status: TasksStatus.empty));

    await tester.tap(find.widgetWithText(ChoiceChip, 'Completed'));

    verify(() => cubit.statusChanged(TaskStatusFilter.completed)).called(1);
  });
}
