import 'package:flutter/material.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_priority.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/utils/task_labels.dart';

class PriorityBadge extends StatelessWidget {
  const PriorityBadge({super.key, required this.priority});

  final TaskPriority priority;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = priority.color(theme.colorScheme);
    return Semantics(
      label: '${priority.label} priority',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          priority.label,
          style: theme.textTheme.labelSmall?.copyWith(color: color),
        ),
      ),
    );
  }
}
