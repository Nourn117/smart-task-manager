import 'package:smart_task_manager/core/errors/failure.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/core/utils/typedefs.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/repositories/task_repository.dart';

class UpdateTask {
  UpdateTask(this._repository, {Clock? now}) : _now = now ?? DateTime.now;

  final TaskRepository _repository;
  final Clock _now;

  Future<Result<Task>> call(Task task) async {
    final trimmedTitle = task.title.trim();
    if (trimmedTitle.isEmpty) {
      return const Err(ValidationFailure.emptyTitle());
    }

    final trimmedDescription = task.description?.trim();

    return _repository.updateTask(
      task.copyWith(
        title: trimmedTitle,
        description: (trimmedDescription?.isEmpty ?? true)
            ? null
            : trimmedDescription,
        updatedAt: _now(),
      ),
    );
  }
}
