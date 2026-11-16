import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';
import 'package:smart_task_manager/domain/entities/task_query.dart';
import 'package:smart_task_manager/domain/usecases/watch_tasks.dart';
import 'package:smart_task_manager/presentation/tasks/cubit/tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(
    this._watchTasks, {
    this._searchDebounce = const Duration(milliseconds: 300),
  }) : super(const TasksState());

  static const pageSize = 20;

  final WatchTasks _watchTasks;
  final Duration _searchDebounce;

  StreamSubscription<List<Task>>? _subscription;
  Timer? _searchTimer;
  bool _isLoadingMore = false;

  void load() => _watch(state.query);

  void retry() {
    emit(state.copyWith(status: TasksStatus.loading, errorMessage: null));
    _watch(state.query);
  }

  void searchChanged(String searchTerm) {
    _searchTimer?.cancel();
    _searchTimer = Timer(
      _searchDebounce,
      () => _applyQuery(
        state.query.copyWith(searchTerm: searchTerm, limit: pageSize),
      ),
    );
  }

  void statusChanged(TaskStatusFilter status) =>
      _applyQuery(state.query.copyWith(status: status, limit: pageSize));

  void priorityChanged(TaskPriority? priority) =>
      _applyQuery(state.query.copyWith(priority: priority, limit: pageSize));

  void categoryChanged(TaskCategory? category) =>
      _applyQuery(state.query.copyWith(category: category, limit: pageSize));

  void sortChanged(TaskSortOption sortBy) =>
      _applyQuery(state.query.copyWith(sortBy: sortBy, limit: pageSize));

  void loadMore() {
    if (!state.hasMore || _isLoadingMore) return;
    _isLoadingMore = true;
    _applyQuery(state.query.copyWith(limit: state.query.limit + pageSize));
  }

  void _applyQuery(TaskQuery query) {
    if (query == state.query) return;
    emit(state.copyWith(query: query));
    _watch(query);
  }

  void _watch(TaskQuery query) {
    unawaited(_subscription?.cancel());
    _subscription = _watchTasks(query).listen(
      (tasks) {
        _isLoadingMore = false;
        emit(
          state.copyWith(
            status: tasks.isEmpty ? TasksStatus.empty : TasksStatus.loaded,
            tasks: tasks,
            hasMore: tasks.length >= query.limit,
            errorMessage: null,
          ),
        );
      },
      onError: (Object _) {
        _isLoadingMore = false;
        emit(
          state.copyWith(
            status: TasksStatus.error,
            errorMessage: 'Could not load tasks.',
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    _searchTimer?.cancel();
    await _subscription?.cancel();
    return super.close();
  }
}
