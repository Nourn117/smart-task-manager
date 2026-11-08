import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/core/di/injection.dart';
import 'package:smart_task_manager/core/routing/app_routes.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/entities/task_query.dart';
import 'package:smart_task_manager/domain/entities/task_summary.dart';
import 'package:smart_task_manager/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:smart_task_manager/presentation/dashboard/cubit/dashboard_state.dart';
import 'package:smart_task_manager/presentation/dashboard/widgets/progress_card.dart';
import 'package:smart_task_manager/presentation/dashboard/widgets/summary_card.dart';
import 'package:smart_task_manager/presentation/shared/widgets/empty_view.dart';
import 'package:smart_task_manager/presentation/shared/widgets/error_view.dart';
import 'package:smart_task_manager/presentation/shared/widgets/loading_view.dart';
import 'package:smart_task_manager/presentation/shared/widgets/task_list_tile.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.onShowTasks});

  /// Opens the Tasks tab filtered by the given status.
  final ValueChanged<TaskStatusFilter> onShowTasks;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardCubit>()..load(),
      child: DashboardView(onShowTasks: onShowTasks),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key, required this.onShowTasks});

  final ValueChanged<TaskStatusFilter> onShowTasks;

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_greeting())),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () => context.openTaskForm(),
        icon: const Icon(Icons.add),
        label: const Text('New task'),
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state.errorMessage case final message?) {
            return ErrorView(
              message: message,
              onRetry: context.read<DashboardCubit>().load,
            );
          }
          final summary = state.summary;
          final recentTasks = state.recentTasks;
          if (summary == null || recentTasks == null) {
            return const LoadingView();
          }
          return _DashboardContent(
            summary: summary,
            recentTasks: recentTasks,
            selectedStatus: state.selectedStatus,
            onShowTasks: onShowTasks,
          );
        },
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({
    required this.summary,
    required this.recentTasks,
    required this.selectedStatus,
    required this.onShowTasks,
  });

  final TaskSummary summary;
  final List<Task> recentTasks;
  final TaskStatusFilter selectedStatus;
  final ValueChanged<TaskStatusFilter> onShowTasks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final cubit = context.read<DashboardCubit>();

    final (sectionTitle, emptyMessage) = switch (selectedStatus) {
      TaskStatusFilter.all => (
        'Recent tasks',
        'No tasks yet. Create your first one!',
      ),
      TaskStatusFilter.pending => (
        'Pending tasks',
        'No pending tasks. Nice work!',
      ),
      TaskStatusFilter.completed => (
        'Completed tasks',
        'No completed tasks yet.',
      ),
    };

    Widget summaryCard(
      TaskStatusFilter status,
      String label,
      int value,
      IconData icon,
      Color color,
    ) {
      return Expanded(
        child: SummaryCard(
          label: label,
          value: value,
          icon: icon,
          color: color,
          isSelected: selectedStatus == status,
          onTap: () => cubit.selectStatus(status),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      children: [
        ProgressCard(summary: summary),
        const SizedBox(height: 12),
        Row(
          children: [
            summaryCard(
              TaskStatusFilter.all,
              'Total',
              summary.total,
              Icons.list_alt,
              colors.primary,
            ),
            const SizedBox(width: 12),
            summaryCard(
              TaskStatusFilter.pending,
              'Pending',
              summary.pending,
              Icons.pending_actions,
              colors.tertiary,
            ),
            const SizedBox(width: 12),
            summaryCard(
              TaskStatusFilter.completed,
              'Completed',
              summary.completed,
              Icons.check_circle_outline,
              colors.secondary,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              sectionTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => onShowTasks(selectedStatus),
              child: const Text('View all'),
            ),
          ],
        ),
        if (recentTasks.isEmpty)
          EmptyView(message: emptyMessage)
        else
          for (final task in recentTasks)
            TaskListTile(
              key: ValueKey(task.id),
              task: task,
              margin: const EdgeInsets.symmetric(vertical: 6),
              onTap: () => context.openTaskDetails(task.id),
            ),
      ],
    );
  }
}
