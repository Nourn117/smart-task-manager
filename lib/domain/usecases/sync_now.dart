import 'package:smart_task_manager/domain/repositories/sync_repository.dart';

class SyncNow {
  const SyncNow(this._repository);

  final SyncRepository _repository;

  Future<void> call() => _repository.syncNow();
}
