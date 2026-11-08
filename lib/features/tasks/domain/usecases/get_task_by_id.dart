import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/repositories/task_repository.dart';

class GetTaskById {
  const GetTaskById(this._repository);

  final TaskRepository _repository;

  Future<Result<Task>> call(String id) => _repository.getTaskById(id);
}
