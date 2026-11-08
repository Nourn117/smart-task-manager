import 'package:drift/drift.dart';
import 'package:smart_task_manager/domain/entities/sync_status.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';

@DataClassName('TaskRow')
class Tasks extends Table {
  TextColumn get id => text()();
  IntColumn get remoteId => integer().nullable()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get priority => textEnum<TaskPriority>()();
  TextColumn get category => textEnum<TaskCategory>()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => textEnum<SyncStatus>()();

  /// Tombstone for synced tasks deleted locally until the remote delete succeeds.
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
