import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/domain/entities/sync_overview.dart';
import 'package:smart_task_manager/domain/usecases/sync_now.dart';
import 'package:smart_task_manager/domain/usecases/watch_sync_overview.dart';

/// App-wide connection and synchronization status.
class SyncCubit extends Cubit<SyncOverview> {
  SyncCubit({required this._watchSyncOverview, required this._syncNow})
    : super(const SyncOverview());

  final WatchSyncOverview _watchSyncOverview;
  final SyncNow _syncNow;

  StreamSubscription<SyncOverview>? _subscription;

  void start() {
    unawaited(_subscription?.cancel());
    _subscription = _watchSyncOverview().listen(emit);
  }

  Future<void> syncNow() => _syncNow();

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
