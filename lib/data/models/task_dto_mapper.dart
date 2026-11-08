import 'package:drift/drift.dart';
import 'package:smart_task_manager/core/database/app_database.dart';
import 'package:smart_task_manager/data/models/task_dto.dart';
import 'package:smart_task_manager/domain/entities/sync_status.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';

extension TaskDtoMapper on TaskDto {
  /// A new local record for a task that so far only exists on the server.
  /// DummyJSON has no priority, category or dates, so defaults are used.
  TasksCompanion toCompanion({required String localId, required DateTime now}) {
    return TasksCompanion.insert(
      id: localId,
      remoteId: Value(id),
      title: title,
      priority: TaskPriority.medium,
      category: TaskCategory.other,
      isCompleted: Value(completed),
      createdAt: now,
      updatedAt: now,
      syncStatus: SyncStatus.synced,
    );
  }
}
