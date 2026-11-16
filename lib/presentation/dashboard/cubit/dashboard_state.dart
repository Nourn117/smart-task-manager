import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/entities/task_query.dart';
import 'package:smart_task_manager/domain/entities/task_summary.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const DashboardState._();

  const factory DashboardState({
    TaskSummary? summary,

    /// The status picked from the summary cards; filters [recentTasks].
    @Default(TaskStatusFilter.all) TaskStatusFilter selectedStatus,
    List<Task>? recentTasks,
    String? errorMessage,
  }) = _DashboardState;

  bool get isLoading =>
      errorMessage == null && (summary == null || recentTasks == null);
}
