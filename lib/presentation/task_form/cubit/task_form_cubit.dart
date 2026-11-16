import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';
import 'package:smart_task_manager/domain/usecases/create_task.dart';
import 'package:smart_task_manager/domain/usecases/get_task_by_id.dart';
import 'package:smart_task_manager/domain/usecases/update_task.dart';
import 'package:smart_task_manager/presentation/task_form/cubit/task_form_state.dart';

class TaskFormCubit extends Cubit<TaskFormState> {
  TaskFormCubit({
    required this._getTaskById,
    required this._createTask,
    required this._updateTask,
  }) : super(const TaskFormState());

  final GetTaskById _getTaskById;
  final CreateTask _createTask;
  final UpdateTask _updateTask;

  /// Pass [taskId] to edit an existing task, or omit it to create a new one.
  Future<void> load({String? taskId}) async {
    if (taskId == null) {
      emit(state.copyWith(status: TaskFormStatus.ready));
      return;
    }

    final result = await _getTaskById(taskId);
    if (isClosed) return;

    emit(switch (result) {
      Ok(:final value) => state.copyWith(
        status: TaskFormStatus.ready,
        initialTask: value,
      ),
      Err(:final failure) => state.copyWith(
        status: TaskFormStatus.loadFailure,
        errorMessage: failure.message,
      ),
    });
  }

  Future<void> submit({
    required String title,
    required String description,
    required TaskPriority priority,
    required TaskCategory category,
    DateTime? dueDate,
  }) async {
    // Ignores taps while a save is in progress, preventing duplicate tasks.
    if (state.status != TaskFormStatus.ready) return;
    emit(state.copyWith(status: TaskFormStatus.submitting, errorMessage: null));

    final initialTask = state.initialTask;
    final result = initialTask == null
        ? await _createTask(
            title: title,
            description: description,
            priority: priority,
            category: category,
            dueDate: dueDate,
          )
        : await _updateTask(
            initialTask.copyWith(
              title: title,
              description: description,
              priority: priority,
              category: category,
              dueDate: dueDate,
            ),
          );
    if (isClosed) return;

    emit(switch (result) {
      Ok() => state.copyWith(status: TaskFormStatus.saved),
      Err(:final failure) => state.copyWith(
        status: TaskFormStatus.ready,
        errorMessage: failure.message,
      ),
    });
  }
}
