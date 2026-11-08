import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_category.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_priority.dart';

Task buildTask({
  String id = 'task-1',
  String title = 'Task',
  String? description,
  bool isCompleted = false,
  DateTime? updatedAt,
}) {
  final createdAt = DateTime(2026);
  return Task(
    id: id,
    title: title,
    description: description,
    priority: TaskPriority.medium,
    category: TaskCategory.work,
    isCompleted: isCompleted,
    createdAt: createdAt,
    updatedAt: updatedAt ?? createdAt,
  );
}
