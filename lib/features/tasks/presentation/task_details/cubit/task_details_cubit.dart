import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/delete_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/toggle_task_completion.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_task.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_details/cubit/task_details_state.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  TaskDetailsCubit({
    required this._watchTask,
    required this._toggleTaskCompletion,
    required this._deleteTask,
  }) : super(const TaskDetailsState.loading());

  final WatchTask _watchTask;
  final ToggleTaskCompletion _toggleTaskCompletion;
  final DeleteTask _deleteTask;

  StreamSubscription<Task?>? _subscription;
  String? _taskId;

  /// True while an action that closes the screen is running, so updates
  /// caused by that action don't flash on screen.
  bool _isLeaving = false;

  void watch(String taskId) {
    _taskId = taskId;
    unawaited(_subscription?.cancel());
    if (state is! TaskDetailsLoading) emit(const TaskDetailsState.loading());

    _subscription = _watchTask(taskId).listen(
      (task) {
        if (_isLeaving) return;
        emit(
          task == null
              ? const TaskDetailsState.notFound()
              : TaskDetailsState.loaded(task),
        );
      },
      onError: (Object _) =>
          emit(const TaskDetailsState.failure('Could not load this task.')),
    );
  }

  void retry() {
    if (_taskId case final taskId?) watch(taskId);
  }

  Future<void> toggleCompletion() async {
    final current = state;
    if (current is! TaskDetailsLoaded || current.isBusy) return;

    _isLeaving = true;
    emit(current.copyWith(isBusy: true, errorMessage: null));
    final result = await _toggleTaskCompletion(current.task);
    if (isClosed) return;

    switch (result) {
      case Ok(:final value):
        emit(
          TaskDetailsState.completionToggled(isCompleted: value.isCompleted),
        );
        unawaited(_subscription?.cancel());
      case Err(:final failure):
        _isLeaving = false;
        emit(current.copyWith(errorMessage: failure.message));
    }
  }

  Future<void> delete() async {
    final current = state;
    if (current is! TaskDetailsLoaded || current.isBusy) return;

    _isLeaving = true;
    emit(current.copyWith(isBusy: true, errorMessage: null));
    final result = await _deleteTask(current.task.id);
    if (isClosed) return;

    switch (result) {
      case Ok():
        emit(const TaskDetailsState.deleted());
        unawaited(_subscription?.cancel());
      case Err(:final failure):
        _isLeaving = false;
        emit(current.copyWith(errorMessage: failure.message));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
