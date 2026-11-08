import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/core/di/injection.dart';
import 'package:smart_task_manager/core/routing/app_routes.dart';
import 'package:smart_task_manager/core/theme/app_snack_bar.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/utils/date_formatting.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/utils/task_labels.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/widgets/empty_view.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/widgets/error_view.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/widgets/loading_view.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/widgets/priority_badge.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_details/cubit/task_details_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_details/cubit/task_details_state.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TaskDetailsCubit>()..watch(taskId),
      child: const TaskDetailsView(),
    );
  }
}

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key});

  void _onStateChanged(BuildContext context, TaskDetailsState state) {
    switch (state) {
      case TaskDetailsCompletionToggled(:final isCompleted):
        context.showMessage(
          isCompleted ? 'Task marked as completed' : 'Task reopened',
        );
        Navigator.of(context).pop();
      case TaskDetailsDeleted():
        context.showMessage('Task deleted');
        Navigator.of(context).pop();
      case TaskDetailsLoaded(:final errorMessage?):
        context.showMessage(errorMessage, isError: true);
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskDetailsCubit, TaskDetailsState>(
      listenWhen: (previous, current) => previous != current,
      listener: _onStateChanged,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Task details'),
          actions: [
            if (state case TaskDetailsLoaded(:final task, :final isBusy)) ...[
              IconButton(
                tooltip: 'Edit task',
                icon: const Icon(Icons.edit_outlined),
                onPressed: isBusy
                    ? null
                    : () => context.openTaskForm(taskId: task.id),
              ),
              IconButton(
                tooltip: 'Delete task',
                icon: const Icon(Icons.delete_outline),
                onPressed: isBusy ? null : () => _confirmDelete(context),
              ),
            ],
          ],
        ),
        body: switch (state) {
          TaskDetailsLoading() => const LoadingView(),
          TaskDetailsCompletionToggled() ||
          TaskDetailsDeleted() => const SizedBox.shrink(),
          TaskDetailsNotFound() => const EmptyView(
            message: 'This task no longer exists.',
            icon: Icons.search_off,
          ),
          TaskDetailsFailure(:final message) => ErrorView(
            message: message,
            onRetry: context.read<TaskDetailsCubit>().retry,
          ),
          TaskDetailsLoaded(:final task, :final isBusy) => _TaskDetailsBody(
            task: task,
            isBusy: isBusy,
          ),
        },
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final cubit = context.read<TaskDetailsCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.delete_outline),
        title: const Text('Delete task?'),
        content: const Text('This task will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
              minimumSize: const Size(88, 44),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await cubit.delete();
  }
}

class _TaskDetailsBody extends StatelessWidget {
  const _TaskDetailsBody({required this.task, required this.isBusy});

  final Task task;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final dueDate = task.dueDate;
    final isOverdue = !task.isCompleted && dueDate != null && dueDate.isOverdue;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _StatusChip(isCompleted: task.isCompleted),
                    PriorityBadge(priority: task.priority),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  task.title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (task.description case final description?) ...[
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: [
              _InfoTile(
                icon: task.category.icon,
                label: 'Category',
                value: task.category.label,
              ),
              const Divider(indent: 56),
              _InfoTile(
                icon: Icons.event_outlined,
                label: 'Due date',
                value: switch (dueDate) {
                  final date? when isOverdue =>
                    'Overdue · ${context.formatDate(date)}',
                  final date? => context.formatDate(date),
                  null => 'No due date',
                },
                valueColor: isOverdue ? colors.error : null,
              ),
              const Divider(indent: 56),
              _InfoTile(
                icon: task.syncStatus.icon,
                label: 'Sync status',
                value: task.syncStatus.label,
              ),
              const Divider(indent: 56),
              _InfoTile(
                icon: Icons.schedule,
                label: 'Created',
                value: context.formatDateTime(task.createdAt),
              ),
              const Divider(indent: 56),
              _InfoTile(
                icon: Icons.update,
                label: 'Last updated',
                value: context.formatDateTime(task.updatedAt),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: isBusy
              ? null
              : context.read<TaskDetailsCubit>().toggleCompletion,
          icon: Icon(task.isCompleted ? Icons.replay : Icons.check),
          label: Text(task.isCompleted ? 'Reopen task' : 'Mark as completed'),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.isCompleted});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final color = isCompleted ? colors.primary : colors.tertiary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.timelapse,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            isCompleted ? 'Completed' : 'Pending',
            style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      subtitle: Text(
        value,
        style: theme.textTheme.bodyLarge?.copyWith(color: valueColor),
      ),
    );
  }
}
