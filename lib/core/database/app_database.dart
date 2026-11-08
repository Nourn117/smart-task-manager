import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:smart_task_manager/core/database/tables/sync_queue_table.dart';
import 'package:smart_task_manager/core/database/tables/tasks_table.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/sync_status.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_category.dart';
import 'package:smart_task_manager/features/tasks/domain/entities/task_priority.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Tasks, SyncQueue])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'smart_task_manager'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
  );
}
