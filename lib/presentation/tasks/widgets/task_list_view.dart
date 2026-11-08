import 'package:flutter/material.dart';
import 'package:smart_task_manager/core/routing/app_routes.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/presentation/shared/widgets/task_list_tile.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    super.key,
    required this.tasks,
    required this.hasMore,
    required this.onLoadMore,
  });

  static const _loadMoreThreshold = 200.0;

  final List<Task> tasks;
  final bool hasMore;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (hasMore && notification.metrics.extentAfter < _loadMoreThreshold) {
          onLoadMore();
        }
        return false;
      },
      child: ListView.builder(
        // Leaves room so the floating action button never covers the last task.
        padding: const EdgeInsets.only(bottom: 88),
        itemCount: tasks.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == tasks.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final task = tasks[index];
          return TaskListTile(
            key: ValueKey(task.id),
            task: task,
            onTap: () => context.openTaskDetails(task.id),
          );
        },
      ),
    );
  }
}
