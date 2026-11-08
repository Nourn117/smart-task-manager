import 'package:smart_task_manager/domain/entities/task_summary.dart';
import 'package:smart_task_manager/domain/repositories/task_repository.dart';

class WatchTaskSummary {
  const WatchTaskSummary(this._repository);

  final TaskRepository _repository;

  Stream<TaskSummary> call() => _repository.watchSummary();
}
