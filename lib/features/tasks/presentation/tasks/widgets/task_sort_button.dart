import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_query.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/utils/task_labels.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/cubit/tasks_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/cubit/tasks_state.dart';

class TaskSortButton extends StatelessWidget {
  const TaskSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TasksCubit, TasksState, TaskSortOption>(
      selector: (state) => state.query.sortBy,
      builder: (context, sortBy) => PopupMenuButton<TaskSortOption>(
        tooltip: 'Sort tasks',
        icon: const Icon(Icons.sort),
        initialValue: sortBy,
        onSelected: context.read<TasksCubit>().sortChanged,
        itemBuilder: (_) => [
          for (final option in TaskSortOption.values)
            CheckedPopupMenuItem(
              value: option,
              checked: option == sortBy,
              child: Text(option.label),
            ),
        ],
      ),
    );
  }
}
