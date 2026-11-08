import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_summary.freezed.dart';

@freezed
abstract class TaskSummary with _$TaskSummary {
  const TaskSummary._();

  const factory TaskSummary({
    @Default(0) int total,
    @Default(0) int completed,
  }) = _TaskSummary;

  int get pending => total - completed;
}
