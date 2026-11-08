import 'package:drift/drift.dart';
import 'package:smart_task_manager/core/database/app_database.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';

extension TaskRowMapper on TaskRow {
  Task toEntity() => Task(
    id: id,
    remoteId: remoteId,
    title: title,
    description: description,
    priority: priority,
    category: category,
    dueDate: dueDate?.toLocal(),
    isCompleted: isCompleted,
    createdAt: createdAt.toLocal(),
    updatedAt: updatedAt.toLocal(),
    syncStatus: syncStatus,
  );
}

extension TaskCompanionMapper on Task {
  TasksCompanion toCompanion() => TasksCompanion.insert(
    id: id,
    remoteId: Value(remoteId),
    title: title,
    description: Value(description),
    priority: priority,
    category: category,
    dueDate: Value(dueDate),
    isCompleted: Value(isCompleted),
    createdAt: createdAt,
    updatedAt: updatedAt,
    syncStatus: syncStatus,
  );
}
