import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/errors/failure.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/delete_task.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockTaskRepository repository;
  late DeleteTask deleteTask;

  setUp(() {
    repository = MockTaskRepository();
    deleteTask = DeleteTask(repository);
  });

  test('deletes the task by id', () async {
    when(() => repository.deleteTask('task-1'))
        .thenAnswer((_) async => const Ok(null));

    final result = await deleteTask('task-1');

    expect(result, isA<Ok<void>>());
    verify(() => repository.deleteTask('task-1')).called(1);
  });

  test('returns the repository failure when deletion fails', () async {
    when(() => repository.deleteTask('task-1'))
        .thenAnswer((_) async => const Err(NotFoundFailure()));

    final result = await deleteTask('task-1');

    expect(
      result,
      isA<Err<void>>().having(
        (err) => err.failure,
        'failure',
        isA<NotFoundFailure>(),
      ),
    );
  });
}
