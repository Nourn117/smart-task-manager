import 'package:smart_task_manager/core/errors/failure.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/core/utils/typedefs.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_category.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_priority.dart';
import 'package:smart_task_manager/features/tasks/domain/repositories/task_repository.dart';

class CreateTask {
  CreateTask(this._repository, {required this._generateId, Clock? now})
      : _now = now ?? DateTime.now;

  final TaskRepository _repository;
  final IdGenerator _generateId;
  final Clock _now;

  Future<Result<Task>> call({
    required String title,
    String? description,
    required TaskPriority priority,
    required TaskCategory category,
    DateTime? dueDate,
  }) async {
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      return const Err(ValidationFailure.emptyTitle());
    }

    final trimmedDescription = description?.trim();
    final timestamp = _now();

    return _repository.createTask(
      Task(
        id: _generateId(),
        title: trimmedTitle,
        description: (trimmedDescription?.isEmpty ?? true)
            ? null
            : trimmedDescription,
        priority: priority,
        category: category,
        dueDate: dueDate,
        createdAt: timestamp,
        updatedAt: timestamp,
      ),
    );
  }
}