import 'package:smart_task_manager/domain/entities/sync_overview.dart';

abstract interface class SyncRepository {
  Stream<SyncOverview> watchOverview();

  /// Sends pending local changes and fetches remote tasks. Joins the run
  /// already in progress instead of starting a second one.
  Future<void> syncNow();
}
