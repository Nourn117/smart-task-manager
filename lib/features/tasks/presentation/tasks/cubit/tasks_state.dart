import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_query.dart';

part 'tasks_state.freezed.dart';

enum TasksStatus { loading, loaded, empty, error }

@freezed
abstract class TasksState with _$TasksState {
  const TasksState._();

  const factory TasksState({
    @Default(TasksStatus.loading) TasksStatus status,
    @Default(TaskQuery()) TaskQuery query,
    @Default(<Task>[]) List<Task> tasks,
    @Default(false) bool hasMore,
    String? errorMessage,
  }) = _TasksState;

  bool get hasActiveFilters =>
      query.searchTerm.trim().isNotEmpty ||
      query.status != TaskStatusFilter.all ||
      query.priority != null ||
      query.category != null;
}
