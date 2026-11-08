import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/sync_status.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_category.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_priority.dart';

part 'task.freezed.dart';

@freezed
abstract class Task with _$Task {
  const factory Task({
    /// Stable local id (UUID), never depends on the server.
    required String id,

    /// Server id, null until the task exists remotely.
    int? remoteId,
    required String title,
    String? description,
    required TaskPriority priority,
    required TaskCategory category,
    DateTime? dueDate,
    @Default(false) bool isCompleted,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(SyncStatus.pending) SyncStatus syncStatus,
  }) = _Task;
}
