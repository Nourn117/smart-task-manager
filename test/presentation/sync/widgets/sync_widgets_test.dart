import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/domain/entities/sync_overview.dart';
import 'package:smart_task_manager/presentation/sync/cubit/sync_cubit.dart';
import 'package:smart_task_manager/presentation/sync/widgets/offline_banner.dart';
import 'package:smart_task_manager/presentation/sync/widgets/sync_status_card.dart';

import '../../../helpers/mocks.dart';

void main() {
  late MockSyncCubit cubit;

  setUp(() {
    cubit = MockSyncCubit();
    when(() => cubit.syncNow()).thenAnswer((_) async {});
  });

  Future<void> pump(WidgetTester tester, SyncOverview state, Widget child) {
    stubState(cubit, state);
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<SyncCubit>.value(
            value: cubit,
            child: SingleChildScrollView(child: child),
          ),
        ),
      ),
    );
  }

  group('OfflineBanner', () {
    testWidgets('is hidden while online', (tester) async {
      await pump(tester, const SyncOverview(), const OfflineBanner());

      expect(find.textContaining('offline'), findsNothing);
    });

    testWidgets('shows how many changes are waiting while offline', (
      tester,
    ) async {
      await pump(
        tester,
        const SyncOverview(isOnline: false, pendingChanges: 2),
        const OfflineBanner(),
      );

      expect(
        find.text(
          'You’re offline. 2 changes will sync when you’re back online.',
        ),
        findsOneWidget,
      );
    });
  });

  group('SyncStatusCard', () {
    testWidgets('shows the connection, pending and failed changes', (
      tester,
    ) async {
      await pump(
        tester,
        const SyncOverview(
          isOnline: false,
          pendingChanges: 3,
          failedChanges: 1,
        ),
        const SyncStatusCard(),
      );

      expect(find.text('Offline'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('Failed to sync'), findsOneWidget);
      expect(find.text('Not yet'), findsOneWidget);
    });

    testWidgets('starts a sync when Sync now is tapped', (tester) async {
      await pump(tester, const SyncOverview(), const SyncStatusCard());

      await tester.tap(find.text('Sync now'));

      verify(() => cubit.syncNow()).called(1);
    });

    testWidgets('disables Sync now while syncing', (tester) async {
      await pump(
        tester,
        const SyncOverview(isSyncing: true),
        const SyncStatusCard(),
      );

      await tester.tap(find.text('Syncing…'));

      verifyNever(() => cubit.syncNow());
    });
  });
}
