import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_details/cubit/task_details_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_details/cubit/task_details_state.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_details/task_details_page.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/task_builder.dart';

void main() {
  late MockTaskDetailsCubit cubit;

  setUp(() {
    cubit = MockTaskDetailsCubit();
    stubState(cubit, TaskDetailsState.loaded(buildTask(title: 'Buy milk')));
    when(() => cubit.delete()).thenAnswer((_) async {});
    when(() => cubit.toggleCompletion()).thenAnswer((_) async {});
  });

  Future<void> pumpDetails(WidgetTester tester) {
    return tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<TaskDetailsCubit>.value(
          value: cubit,
          child: const TaskDetailsView(),
        ),
      ),
    );
  }

  testWidgets('shows the task', (tester) async {
    await pumpDetails(tester);

    expect(find.text('Buy milk'), findsOneWidget);
  });

  testWidgets('deletes the task after confirmation', (tester) async {
    await pumpDetails(tester);

    await tester.tap(find.byTooltip('Delete task'));
    await tester.pumpAndSettle();
    expect(find.text('Delete task?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();

    verify(() => cubit.delete()).called(1);
  });

  testWidgets('does not delete when the confirmation is cancelled', (
    tester,
  ) async {
    await pumpDetails(tester);

    await tester.tap(find.byTooltip('Delete task'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    verifyNever(() => cubit.delete());
  });

  testWidgets('marks the task as completed', (tester) async {
    await pumpDetails(tester);

    await tester.scrollUntilVisible(find.text('Mark as completed'), 200);
    await tester.tap(find.text('Mark as completed'));

    verify(() => cubit.toggleCompletion()).called(1);
  });
}
