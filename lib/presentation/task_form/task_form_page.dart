import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/core/di/injection.dart';
import 'package:smart_task_manager/core/theme/app_snack_bar.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';
import 'package:smart_task_manager/presentation/shared/utils/date_formatting.dart';
import 'package:smart_task_manager/presentation/shared/utils/task_labels.dart';
import 'package:smart_task_manager/presentation/shared/widgets/error_view.dart';
import 'package:smart_task_manager/presentation/shared/widgets/loading_view.dart';
import 'package:smart_task_manager/presentation/task_form/cubit/task_form_cubit.dart';
import 'package:smart_task_manager/presentation/task_form/cubit/task_form_state.dart';

class TaskFormPage extends StatelessWidget {
  const TaskFormPage({super.key, this.taskId});

  /// The task to edit, or null to create a new one.
  final String? taskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<TaskFormCubit>();
        unawaited(cubit.load(taskId: taskId));
        return cubit;
      },
      child: TaskFormView(isEditing: taskId != null),
    );
  }
}

class TaskFormView extends StatefulWidget {
  const TaskFormView({super.key, required this.isEditing});

  final bool isEditing;

  @override
  State<TaskFormView> createState() => _TaskFormViewState();
}

/// Uses state restoration so unsaved input survives the app being
/// killed in the background.
class _TaskFormViewState extends State<TaskFormView> with RestorationMixin {
  final _formKey = GlobalKey<FormState>();
  final _title = RestorableTextEditingController();
  final _description = RestorableTextEditingController();
  final _priority = RestorableEnum(
    TaskPriority.medium,
    values: TaskPriority.values,
  );
  final _category = RestorableEnum(
    TaskCategory.personal,
    values: TaskCategory.values,
  );
  final _dueDate = RestorableDateTimeN(null);
  final _isPrefilled = RestorableBool(false);

  @override
  String get restorationId => 'task_form';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_title, 'title');
    registerForRestoration(_description, 'description');
    registerForRestoration(_priority, 'priority');
    registerForRestoration(_category, 'category');
    registerForRestoration(_dueDate, 'due_date');
    registerForRestoration(_isPrefilled, 'is_prefilled');

    if (context.read<TaskFormCubit>().state.initialTask case final task?) {
      _prefill(task);
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _priority.dispose();
    _category.dispose();
    _dueDate.dispose();
    _isPrefilled.dispose();
    super.dispose();
  }

  /// Fills the form once with the task being edited, never over restored input.
  void _prefill(Task task) {
    if (_isPrefilled.value) return;
    _title.value.text = task.title;
    _description.value.text = task.description ?? '';
    _priority.value = task.priority;
    _category.value = task.category;
    _dueDate.value = task.dueDate;
    _isPrefilled.value = true;
  }

  void _onStateChanged(BuildContext context, TaskFormState state) {
    switch (state.status) {
      case TaskFormStatus.ready:
        if (state.initialTask case final task?) setState(() => _prefill(task));
        if (state.errorMessage case final message?) {
          context.showMessage(message, isError: true);
        }
      case TaskFormStatus.saved:
        context.showMessage(widget.isEditing ? 'Task updated' : 'Task created');
        Navigator.of(context).pop();
      case TaskFormStatus.loading ||
          TaskFormStatus.submitting ||
          TaskFormStatus.loadFailure:
        break;
    }
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final current = _dueDate.value;
    final picked = await showDatePicker(
      context: context,
      // Past dates can't be picked; an overdue task's picker opens on today.
      initialDate: current == null || current.isBefore(today) ? today : current,
      firstDate: today,
      lastDate: DateTime(now.year + 10),
    );
    if (picked == null || !mounted) return;
    setState(() => _dueDate.value = picked);
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await context.read<TaskFormCubit>().submit(
      title: _title.value.text,
      description: _description.value.text,
      priority: _priority.value,
      category: _category.value,
      dueDate: _dueDate.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskFormCubit, TaskFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _onStateChanged,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isEditing ? 'Edit task' : 'New task'),
        ),
        body: BlocBuilder<TaskFormCubit, TaskFormState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) => switch (state.status) {
            TaskFormStatus.loading => const LoadingView(),
            TaskFormStatus.loadFailure => ErrorView(
              message: state.errorMessage ?? 'Could not load this task.',
            ),
            TaskFormStatus.ready ||
            TaskFormStatus.submitting ||
            TaskFormStatus.saved => _buildForm(
              isSubmitting: state.status != TaskFormStatus.ready,
            ),
          },
        ),
      ),
    );
  }

  Widget _buildForm({required bool isSubmitting}) {
    final sectionStyle = Theme.of(context).textTheme.titleSmall;
    final dueDate = _dueDate.value;

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _title.value,
            decoration: const InputDecoration(labelText: 'Title'),
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.next,
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'Title is required'
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _description.value,
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
            selected: {_priority.value},
            onSelectionChanged: (selection) =>
                setState(() => _priority.value = selection.first),
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
                  selected: _category.value == category,
                  onSelected: (_) => setState(() => _category.value = category),
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
                  onPressed: _pickDueDate,
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
                  onPressed: () => setState(() => _dueDate.value = null),
                ),
            ],
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: isSubmitting ? null : _submit,
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
