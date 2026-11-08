import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';
import 'package:smart_task_manager/presentation/task_form/cubit/task_form_cubit.dart';
import 'package:smart_task_manager/presentation/task_form/cubit/task_form_state.dart';
import 'package:smart_task_manager/presentation/task_form/task_form_page.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockTaskFormCubit cubit;

  setUpAll(() {
    registerFallbackValue(TaskPriority.medium);
    registerFallbackValue(TaskCategory.work);
    registerFallbackValue(DateTime(2026));
  });

  setUp(() {
    cubit = MockTaskFormCubit();
    stubState(cubit, const TaskFormState(status: TaskFormStatus.ready));
    when(
      () => cubit.submit(
        title: any(named: 'title'),
        description: any(named: 'description'),
        priority: any(named: 'priority'),
        category: any(named: 'category'),
        dueDate: any(named: 'dueDate'),
      ),
    ).thenAnswer((_) async {});
  });

  Future<void> pumpForm(WidgetTester tester) {
    // A phone-sized screen tall enough to show the whole form.
    tester.view.physicalSize = const Size(400, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    return tester.pumpWidget(
      MaterialApp(
        restorationScopeId: 'app',
        home: BlocProvider<TaskFormCubit>.value(
          value: cubit,
          child: const TaskFormView(isEditing: false),
        ),
      ),
    );
  }

  Finder titleField() => find.widgetWithText(TextFormField, 'Title');

  Future<void> tapSave(WidgetTester tester) async {
    await tester.tap(find.text('Save'));
    await tester.pump();
  }

  testWidgets('shows a validation error and does not submit without a title', (
    tester,
  ) async {
    await pumpForm(tester);

    await tapSave(tester);

    expect(find.text('Title is required'), findsOneWidget);
    verifyNever(
      () => cubit.submit(
        title: any(named: 'title'),
        description: any(named: 'description'),
        priority: any(named: 'priority'),
        category: any(named: 'category'),
        dueDate: any(named: 'dueDate'),
      ),
    );
  });

  testWidgets('submits the entered values', (tester) async {
    await pumpForm(tester);

    await tester.enterText(titleField(), 'Buy milk');
    await tapSave(tester);

    verify(
      () => cubit.submit(
        title: 'Buy milk',
        description: '',
        priority: TaskPriority.medium,
        category: TaskCategory.personal,
        dueDate: null,
      ),
    ).called(1);
  });

  testWidgets('restores unsaved input after the app is restarted', (
    tester,
  ) async {
    await pumpForm(tester);
    await tester.enterText(titleField(), 'Buy milk');
    // Restoration data is saved at the end of a frame.
    await tester.pump();

    await tester.restartAndRestore();

    expect(find.text('Buy milk'), findsOneWidget);
  });
}
