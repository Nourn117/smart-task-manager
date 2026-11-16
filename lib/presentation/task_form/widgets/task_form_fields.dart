import 'package:flutter/material.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';
import 'package:smart_task_manager/presentation/shared/utils/date_formatting.dart';
import 'package:smart_task_manager/presentation/shared/utils/task_labels.dart';

/// The add/edit task form. Its values live in the parent, which keeps them
/// across rebuilds and restores them after the app is killed.
class TaskFormFields extends StatelessWidget {
  const TaskFormFields({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.priority,
    required this.category,
    required this.dueDate,
    required this.isSubmitting,
    required this.onPriorityChanged,
    required this.onCategoryChanged,
    required this.onPickDueDate,
    required this.onClearDueDate,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TaskPriority priority;
  final TaskCategory category;
  final DateTime? dueDate;
  final bool isSubmitting;
  final ValueChanged<TaskPriority> onPriorityChanged;
  final ValueChanged<TaskCategory> onCategoryChanged;
  final VoidCallback onPickDueDate;
  final VoidCallback onClearDueDate;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final sectionStyle = Theme.of(context).textTheme.titleSmall;
    final dueDate = this.dueDate;

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.next,
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'Title is required'
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description (optional)',
              alignLabelWithHint: true,
            ),
            textCapitalization: TextCapitalization.sentences,
            minLines: 3,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          Text('Priority', style: sectionStyle),
          const SizedBox(height: 8),
          SegmentedButton<TaskPriority>(
            segments: [
              for (final priority in TaskPriority.values)
                ButtonSegment(value: priority, label: Text(priority.label)),
            ],
            selected: {priority},
            onSelectionChanged: (selection) =>
                onPriorityChanged(selection.first),
          ),
          const SizedBox(height: 24),
          Text('Category', style: sectionStyle),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final category in TaskCategory.values)
                ChoiceChip(
                  avatar: Icon(category.icon, size: 18),
                  label: Text(category.label),
                  selected: this.category == category,
                  onSelected: (_) => onCategoryChanged(category),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Due date', style: sectionStyle),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onPickDueDate,
                  icon: const Icon(Icons.event_outlined),
                  label: Text(
                    dueDate == null
                        ? 'No due date'
                        : context.formatDate(dueDate),
                  ),
                ),
              ),
              if (dueDate != null)
                IconButton(
                  tooltip: 'Remove due date',
                  icon: const Icon(Icons.close),
                  onPressed: onClearDueDate,
                ),
            ],
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: isSubmitting ? null : onSubmit,
            child: isSubmitting
                ? const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
    );
  }
}
