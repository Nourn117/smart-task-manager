import 'package:flutter/material.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/utils/date_formatting.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/utils/task_labels.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/widgets/priority_badge.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/widgets/sync_status_icon.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required this.task,
    required this.onTap,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  });

  final Task task;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final dueDate = task.dueDate;
    final isOverdue = !task.isCompleted && dueDate != null && dueDate.isOverdue;

    return Padding(
      padding: margin,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(
                  task.isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: task.isCompleted ? colors.primary : colors.outline,
                  semanticLabel: task.isCompleted ? 'Completed' : 'Pending',
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: task.isCompleted
                              ? colors.onSurfaceVariant
                              : null,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 12,
                        runSpacing: 4,
                        children: [
                          _TaskMeta(
                            icon: task.category.icon,
                            label: task.category.label,
                          ),
                          if (dueDate != null)
                            _TaskMeta(
                              icon: Icons.event_outlined,
                              label: isOverdue
                                  ? 'Overdue · ${context.formatDate(dueDate)}'
                                  : context.formatDate(dueDate),
                              color: isOverdue ? colors.error : null,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    PriorityBadge(priority: task.priority),
                    const SizedBox(height: 8),
                    SyncStatusIcon(status: task.syncStatus),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TaskMeta extends StatelessWidget {
  const _TaskMeta({required this.icon, required this.label, this.color});

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.onSurfaceVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: effectiveColor),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(color: effectiveColor),
        ),
      ],
    );
  }
}
