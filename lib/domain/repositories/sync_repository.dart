import 'package:smart_task_manager/domain/entities/sync_overview.dart';

abstract interface class SyncRepository {
  /// Starts syncing automatically: once now, whenever a local change is
  /// queued and whenever connectivity returns.
  void start();

  Stream<SyncOverview> watchOverview();

  /// Sends pending local changes and fetches remote tasks. Joins the run
  /// already in progress instead of starting a second one.
  Future<void> syncNow();

  /// Stops automatic syncing and releases its resources.
  Future<void> dispose();
}
