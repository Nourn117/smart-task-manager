import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/repositories/task_repository.dart';

class WatchTask {
  const WatchTask(this._repository);

  final TaskRepository _repository;

  /// Emits null when the task does not exist or has been deleted.
  Stream<Task?> call(String id) => _repository.watchTask(id);
}
