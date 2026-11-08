import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/entities/task_query.dart';
import 'package:smart_task_manager/domain/repositories/task_repository.dart';

class WatchTasks {
  const WatchTasks(this._repository);

  final TaskRepository _repository;

  Stream<List<Task>> call(TaskQuery query) => _repository.watchTasks(query);
}
