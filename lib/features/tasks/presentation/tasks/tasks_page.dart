import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/core/routing/app_routes.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/widgets/empty_view.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/widgets/error_view.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/widgets/loading_view.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/cubit/tasks_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/cubit/tasks_state.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/widgets/task_filter_bar.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/widgets/task_list_view.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/widgets/task_search_field.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/widgets/task_sort_button.dart';

/// The Tasks tab. Its [TasksCubit] is provided by the home shell so other
/// tabs (like the dashboard) can open it with a filter applied.
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) => const TasksView();
}

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TasksCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: const [TaskSortButton()],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        tooltip: 'Add task',
        onPressed: () => context.openTaskForm(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TaskSearchField(onChanged: cubit.searchChanged),
          ),
          const TaskFilterBar(),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<TasksCubit, TasksState>(
              // A query change alone doesn't rebuild the list; new results do.
              buildWhen: (previous, current) =>
                  previous.status != current.status ||
                  previous.tasks != current.tasks ||
                  previous.hasMore != current.hasMore ||
                  previous.hasActiveFilters != current.hasActiveFilters,
              builder: (context, state) => switch (state.status) {
                TasksStatus.loading => const LoadingView(),
                TasksStatus.error => ErrorView(
                  message: state.errorMessage ?? 'Something went wrong.',
                  onRetry: cubit.retry,
                ),
                TasksStatus.empty => EmptyView(
                  message: state.hasActiveFilters
                      ? 'No tasks match your filters.'
                      : 'No tasks yet. Tap + to add one.',
                ),
                TasksStatus.loaded => TaskListView(
                  tasks: state.tasks,
                  hasMore: state.hasMore,
                  onLoadMore: cubit.loadMore,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
