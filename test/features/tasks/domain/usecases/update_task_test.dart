import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/errors/failure.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/update_task.dart';

import '../../../../helpers/mocks.dart';
import '../../../../helpers/task_builder.dart';

void main() {
  final now = DateTime(2026, 2, 1);
  late MockTaskRepository repository;
  late UpdateTask updateTask;

  setUpAll(() => registerFallbackValue(buildTask()));

  setUp(() {
    repository = MockTaskRepository();
    updateTask = UpdateTask(repository, now: () => now);
    when(() => repository.updateTask(any())).thenAnswer(
      (invocation) async => Ok(invocation.positionalArguments.first as Task),
    );
  });

  test('saves trimmed fields and refreshes updatedAt', () async {
    final task = buildTask(title: '  New title ', description: '  Notes  ');

    await updateTask(task);

    final saved =
        verify(() => repository.updateTask(captureAny())).captured.single
            as Task;
    expect(
      saved,
      task.copyWith(title: 'New title', description: 'Notes', updatedAt: now),
    );
  });

  test(
    'returns ValidationFailure and does not save when title is blank',
    () async {
      final result = await updateTask(buildTask(title: ' '));

      expect(
        result,
        isA<Err<Task>>().having(
          (err) => err.failure,
          'failure',
          isA<ValidationFailure>(),
        ),
      );
      verifyNever(() => repository.updateTask(any()));
    },
  );
}
