import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_task_manager/core/database/app_database.dart';
import 'package:smart_task_manager/features/tasks/data/models/task_row_mapper.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/sync_status.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_category.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_priority.dart';

void main() {
  test('round-trips a task through the database without losing data', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final task = Task(
      id: 'task-1',
      remoteId: 42,
      title: 'Doctor appointment',
      description: 'Bring the reports',
      priority: TaskPriority.high,
      category: TaskCategory.health,
      dueDate: DateTime(2026, 4, 2, 9, 30),
      isCompleted: true,
      createdAt: DateTime(2026, 1, 1, 8, 0, 0, 123),
      updatedAt: DateTime(2026, 1, 2, 8, 0, 0, 456),
      syncStatus: SyncStatus.failed,
    );

    await database.into(database.tasks).insert(task.toCompanion());
    final row = await database.select(database.tasks).getSingle();

    expect(row.toEntity(), task);
  });
}
