import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';

part 'task_details_state.freezed.dart';

@freezed
sealed class TaskDetailsState with _$TaskDetailsState {
  const factory TaskDetailsState.loading() = TaskDetailsLoading;

  const factory TaskDetailsState.loaded(
    Task task, {
    @Default(false) bool isBusy,
    String? errorMessage,
  }) = TaskDetailsLoaded;

  const factory TaskDetailsState.notFound() = TaskDetailsNotFound;

  const factory TaskDetailsState.failure(String message) = TaskDetailsFailure;

  /// The task was completed or reopened; the screen closes.
  const factory TaskDetailsState.completionToggled({
    required bool isCompleted,
  }) = TaskDetailsCompletionToggled;

  /// The task was deleted; the screen closes.
  const factory TaskDetailsState.deleted() = TaskDetailsDeleted;
}
