import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/core/utils/typedefs.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/repositories/task_repository.dart';

class ToggleTaskCompletion {
  ToggleTaskCompletion(this._repository, {Clock? now})
    : _now = now ?? DateTime.now;

  final TaskRepository _repository;
  final Clock _now;

  Future<Result<Task>> call(Task task) => _repository.updateTask(
    task.copyWith(isCompleted: !task.isCompleted, updatedAt: _now()),
  );
}
