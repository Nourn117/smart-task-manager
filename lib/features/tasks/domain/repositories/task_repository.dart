import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_query.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_summary.dart';

abstract interface class TaskRepository {
  Stream<List<Task>> watchTasks(TaskQuery query);

  Stream<TaskSummary> watchSummary();

  /// Emits null when the task does not exist or has been deleted.
  Stream<Task?> watchTask(String id);

  Future<Result<Task>> getTaskById(String id);

  Future<Result<Task>> createTask(Task task);

  Future<Result<Task>> updateTask(Task task);

  Future<Result<void>> deleteTask(String id);
}
