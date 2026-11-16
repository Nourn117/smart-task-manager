import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_overview.freezed.dart';

@freezed
abstract class SyncOverview with _$SyncOverview {
  const factory SyncOverview({
    /// Whether the API was reachable on the last attempt.
    @Default(true) bool isOnline,
    @Default(false) bool isSyncing,

    /// Local changes waiting to be sent to the server.
    @Default(0) int pendingChanges,

    /// Pending changes whose last upload attempt failed.
    @Default(0) int failedChanges,
    DateTime? lastSyncedAt,
    String? lastError,
  }) = _SyncOverview;
}
