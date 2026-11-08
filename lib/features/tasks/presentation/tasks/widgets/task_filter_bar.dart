import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_category.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_priority.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_query.dart';
import 'package:smart_task_manager/features/tasks/presentation/shared/utils/task_labels.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/cubit/tasks_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/cubit/tasks_state.dart';

class TaskFilterBar extends StatelessWidget {
  const TaskFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Rebuilds only when the query changes, not when new results arrive.
    return BlocSelector<TasksCubit, TasksState, TaskQuery>(
      selector: (state) => state.query,
      builder: (context, query) {
        final cubit = context.read<TasksCubit>();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              for (final status in TaskStatusFilter.values)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(status.label),
                    selected: query.status == status,
                    onSelected: (_) => cubit.statusChanged(status),
                  ),
                ),
              _FilterMenu<TaskPriority>(
                label: 'Priority',
                selected: query.priority,
                values: TaskPriority.values,
                labelOf: (priority) => priority.label,
                onChanged: cubit.priorityChanged,
              ),
              const SizedBox(width: 8),
              _FilterMenu<TaskCategory>(
                label: 'Category',
                selected: query.category,
                values: TaskCategory.values,
                labelOf: (category) => category.label,
                onChanged: cubit.categoryChanged,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterMenu<T extends Enum> extends StatelessWidget {
  const _FilterMenu({
    required this.label,
    required this.selected,
    required this.values,
    required this.labelOf,
    required this.onChanged,
  });

  final String label;
  final T? selected;
  final List<T> values;
  final String Function(T value) labelOf;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final current = selected;
    // Values are wrapped in a record so that "Any" (null) is a selectable option.
    return PopupMenuButton<({T? value})>(
      tooltip: 'Filter by ${label.toLowerCase()}',
      initialValue: (value: current),
      onSelected: (choice) => onChanged(choice.value),
      itemBuilder: (_) => [
        PopupMenuItem<({T? value})>(
          value: (value: null),
          child: Text('Any ${label.toLowerCase()}'),
        ),
        for (final value in values)
          PopupMenuItem<({T? value})>(
            value: (value: value),
            child: Text(labelOf(value)),
          ),
      ],
      child: Chip(
        avatar: const Icon(Icons.filter_list, size: 18),
        label: Text(current == null ? label : '$label: ${labelOf(current)}'),
        backgroundColor: current == null
            ? null
            : Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }
}
