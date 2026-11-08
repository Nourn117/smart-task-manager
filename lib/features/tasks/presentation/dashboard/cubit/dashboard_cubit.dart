import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_query.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_summary.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_task_summary.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_tasks.dart';
import 'package:smart_task_manager/features/tasks/presentation/dashboard/cubit/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this._watchTaskSummary, this._watchTasks)
    : super(const DashboardState());

  static const recentTasksLimit = 5;

  final WatchTaskSummary _watchTaskSummary;
  final WatchTasks _watchTasks;

  StreamSubscription<TaskSummary>? _summarySubscription;
  StreamSubscription<List<Task>>? _recentTasksSubscription;

  void load() {
    if (state.errorMessage != null) {
      emit(DashboardState(selectedStatus: state.selectedStatus));
    }

    unawaited(_summarySubscription?.cancel());
    _summarySubscription = _watchTaskSummary().listen(
      (summary) => emit(state.copyWith(summary: summary)),
      onError: _onError,
    );
    _watchRecentTasks(state.selectedStatus);
  }

  void selectStatus(TaskStatusFilter status) {
    if (status == state.selectedStatus) return;
    emit(state.copyWith(selectedStatus: status));
    _watchRecentTasks(status);
  }

  void _watchRecentTasks(TaskStatusFilter status) {
    unawaited(_recentTasksSubscription?.cancel());
    _recentTasksSubscription =
        _watchTasks(TaskQuery(status: status, limit: recentTasksLimit)).listen(
          (tasks) => emit(state.copyWith(recentTasks: tasks)),
          onError: _onError,
        );
  }

  void _onError(Object _) =>
      emit(state.copyWith(errorMessage: 'Could not load the dashboard.'));

  @override
  Future<void> close() async {
    await _summarySubscription?.cancel();
    await _recentTasksSubscription?.cancel();
    return super.close();
  }
}
