import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_task_manager/domain/entities/task.dart';

part 'task_form_state.freezed.dart';

enum TaskFormStatus { loading, ready, submitting, saved, loadFailure }

@freezed
abstract class TaskFormState with _$TaskFormState {
  const factory TaskFormState({
    @Default(TaskFormStatus.loading) TaskFormStatus status,

    /// The task being edited, null when creating a new one.
    Task? initialTask,
    String? errorMessage,
  }) = _TaskFormState;
}
