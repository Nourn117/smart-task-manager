import 'package:drift/drift.dart';
import 'package:smart_task_manager/core/database/tables/tasks_table.dart';

enum SyncOperation { create, update, delete }

/// One pending operation per task; newer local changes are merged into it.
@DataClassName('SyncQueueEntry')
class SyncQueue extends Table {
  TextColumn get taskId =>
      text().references(Tasks, #id, onDelete: KeyAction.cascade)();
  TextColumn get operation => textEnum<SyncOperation>()();
  DateTimeColumn get enqueuedAt => dateTime()();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {taskId};
}
