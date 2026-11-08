import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/domain/entities/sync_overview.dart';
import 'package:smart_task_manager/presentation/shared/utils/date_formatting.dart';
import 'package:smart_task_manager/presentation/sync/cubit/sync_cubit.dart';

class SyncStatusCard extends StatelessWidget {
  const SyncStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocBuilder<SyncCubit, SyncOverview>(
      builder: (context, sync) {
        final lastSyncedAt = sync.lastSyncedAt;
        final lastError = sync.lastError;

        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: Icon(
                  sync.isOnline
                      ? Icons.cloud_done_outlined
                      : Icons.cloud_off_outlined,
                  color: sync.isOnline ? colors.primary : colors.error,
                ),
                title: const Text('Connection'),
                subtitle: Text(sync.isOnline ? 'Online' : 'Offline'),
                trailing: sync.isSyncing
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
              ),
              const Divider(indent: 56),
              ListTile(
                leading: Icon(
                  Icons.cloud_upload_outlined,
                  color: colors.primary,
                ),
                title: const Text('Pending changes'),
                trailing: Text(
                  '${sync.pendingChanges}',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              if (sync.failedChanges > 0) ...[
                const Divider(indent: 56),
                ListTile(
                  leading: Icon(Icons.error_outline, color: colors.error),
                  title: const Text('Failed to sync'),
                  subtitle: const Text('Retried on the next sync'),
                  trailing: Text(
                    '${sync.failedChanges}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colors.error,
                    ),
                  ),
                ),
              ],
              const Divider(indent: 56),
              ListTile(
                leading: Icon(Icons.schedule, color: colors.primary),
                title: const Text('Last synced'),
                subtitle: Text(
                  lastSyncedAt == null
                      ? 'Not yet'
                      : context.formatDateTime(lastSyncedAt),
                ),
              ),
              if (lastError != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Text(
                    lastError,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.error,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton.tonalIcon(
                  onPressed: sync.isSyncing
                      ? null
                      : context.read<SyncCubit>().syncNow,
                  icon: const Icon(Icons.sync),
                  label: Text(sync.isSyncing ? 'Syncing…' : 'Sync now'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
