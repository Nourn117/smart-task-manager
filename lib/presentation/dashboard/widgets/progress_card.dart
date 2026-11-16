import 'package:flutter/material.dart';
import 'package:smart_task_manager/domain/entities/task_summary.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key, required this.summary});

  final TaskSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final progress = summary.total == 0
        ? 0.0
        : summary.completed / summary.total;
    final percent = (progress * 100).round();

    return Semantics(
      container: true,
      label: '$percent percent of tasks completed',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [colors.primary, colors.tertiary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your progress',
              style: theme.textTheme.titleMedium?.copyWith(
                color: colors.onPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$percent%',
              style: theme.textTheme.displaySmall?.copyWith(
                color: colors.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              summary.total == 0
                  ? 'Add a task to get started'
                  : '${summary.completed} of ${summary.total} tasks completed',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onPrimary.withValues(alpha: 0.85),
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                color: colors.onPrimary,
                backgroundColor: colors.onPrimary.withValues(alpha: 0.25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
