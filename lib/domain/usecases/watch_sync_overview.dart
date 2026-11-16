import 'package:smart_task_manager/domain/entities/sync_overview.dart';
import 'package:smart_task_manager/domain/repositories/sync_repository.dart';

class WatchSyncOverview {
  const WatchSyncOverview(this._repository);

  final SyncRepository _repository;

  Stream<SyncOverview> call() => _repository.watchOverview();
}
