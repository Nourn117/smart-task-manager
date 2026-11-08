import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/tasks/domain/repositories/task_repository.dart';

class DeleteTask {
  const DeleteTask(this._repository);

  final TaskRepository _repository;

  Future<Result<void>> call(String id) => _repository.deleteTask(id);
}
