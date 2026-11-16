import 'package:smart_task_manager/domain/entities/sync_status.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';

Task buildTask({
  String id = 'task-1',
  int? remoteId,
  String title = 'Task',
  String? description,
  TaskPriority priority = TaskPriority.medium,
  TaskCategory category = TaskCategory.work,
  DateTime? dueDate,
  bool isCompleted = false,
  DateTime? createdAt,
  DateTime? updatedAt,
  SyncStatus syncStatus = SyncStatus.pending,
}) {
  final created = createdAt ?? DateTime(2026);
  return Task(
    id: id,
    remoteId: remoteId,
    title: title,
    description: description,
    priority: priority,
    category: category,
    dueDate: dueDate,
    isCompleted: isCompleted,
    createdAt: created,
    updatedAt: updatedAt ?? created,
    syncStatus: syncStatus,
  );
}
