import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/core/di/injection.dart';
import 'package:smart_task_manager/core/theme/app_snack_bar.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';
import 'package:smart_task_manager/presentation/shared/widgets/error_view.dart';
import 'package:smart_task_manager/presentation/shared/widgets/loading_view.dart';
import 'package:smart_task_manager/presentation/task_form/cubit/task_form_cubit.dart';
import 'package:smart_task_manager/presentation/task_form/cubit/task_form_state.dart';
import 'package:smart_task_manager/presentation/task_form/widgets/task_form_fields.dart';

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
            TaskFormStatus.saved => TaskFormFields(
              formKey: _formKey,
              titleController: _title.value,
              descriptionController: _description.value,
              priority: _priority.value,
              category: _category.value,
              dueDate: _dueDate.value,
              isSubmitting: state.status != TaskFormStatus.ready,
              onPriorityChanged: (priority) =>
                  setState(() => _priority.value = priority),
              onCategoryChanged: (category) =>
                  setState(() => _category.value = category),
              onPickDueDate: _pickDueDate,
              onClearDueDate: () => setState(() => _dueDate.value = null),
              onSubmit: _submit,
            ),
          },
        ),
      ),
    );
  }
}
