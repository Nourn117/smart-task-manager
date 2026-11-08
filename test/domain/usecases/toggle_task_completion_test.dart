import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/usecases/toggle_task_completion.dart';

import '../../helpers/mocks.dart';
import '../../helpers/task_builder.dart';

void main() {
  final now = DateTime(2026, 3, 1);
  late MockTaskRepository repository;
  late ToggleTaskCompletion toggleTaskCompletion;

  setUpAll(() => registerFallbackValue(buildTask()));

  setUp(() {
    repository = MockTaskRepository();
    toggleTaskCompletion = ToggleTaskCompletion(repository, now: () => now);
    when(() => repository.updateTask(any())).thenAnswer(
      (invocation) async => Ok(invocation.positionalArguments.first as Task),
    );
  });

  test('marks a pending task as completed', () async {
    await toggleTaskCompletion(buildTask());

    final saved =
        verify(() => repository.updateTask(captureAny())).captured.single
            as Task;
    expect(saved.isCompleted, isTrue);
    expect(saved.updatedAt, now);
  });

  test('reopens a completed task', () async {
    await toggleTaskCompletion(buildTask(isCompleted: true));

    final saved =
        verify(() => repository.updateTask(captureAny())).captured.single
            as Task;
    expect(saved.isCompleted, isFalse);
    expect(saved.updatedAt, now);
  });
}
