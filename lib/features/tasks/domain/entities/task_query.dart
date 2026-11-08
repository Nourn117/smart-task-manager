import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_category.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_priority.dart';

part 'task_query.freezed.dart';

enum TaskStatusFilter { all, pending, completed }

enum TaskSortOption { newestFirst, oldestFirst, dueDateSoonest, dueDateLatest }

@freezed
abstract class TaskQuery with _$TaskQuery {
  const factory TaskQuery({
    @Default('') String searchTerm,
    @Default(TaskStatusFilter.all) TaskStatusFilter status,
    TaskPriority? priority,
    TaskCategory? category,
    @Default(TaskSortOption.newestFirst) TaskSortOption sortBy,
    @Default(20) int limit,
  }) = _TaskQuery;
}
