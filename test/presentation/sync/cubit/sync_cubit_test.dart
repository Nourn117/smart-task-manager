import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/domain/entities/sync_overview.dart';
import 'package:smart_task_manager/presentation/sync/cubit/sync_cubit.dart';

import '../../../helpers/cubit_helpers.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockWatchSyncOverview watchSyncOverview;
  late MockSyncNow syncNow;
  late StreamController<SyncOverview> overviews;
  late SyncCubit cubit;

  setUp(() {
    watchSyncOverview = MockWatchSyncOverview();
    syncNow = MockSyncNow();
    overviews = StreamController<SyncOverview>.broadcast();
    when(() => watchSyncOverview()).thenAnswer((_) => overviews.stream);
    when(() => syncNow()).thenAnswer((_) async {});
    cubit = SyncCubit(watchSyncOverview: watchSyncOverview, syncNow: syncNow);
  });

  tearDown(() async {
    await cubit.close();
    await overviews.close();
  });

  test('starts online with nothing pending', () {
    expect(cubit.state, const SyncOverview());
  });

  test('follows the connection and sync status transitions', () async {
    const syncing = SyncOverview(isSyncing: true, pendingChanges: 1);
    const offline = SyncOverview(isOnline: false, pendingChanges: 1);
    final synced = SyncOverview(lastSyncedAt: DateTime(2026, 5));

    final states = await collectStates(cubit, () {
      cubit.start();
      overviews
        ..add(syncing)
        ..add(offline)
        ..add(synced);
    });

    expect(states, [syncing, offline, synced]);
  });

  test('delegates manual sync to the use case', () async {
    await cubit.syncNow();

    verify(() => syncNow()).called(1);
  });
}
