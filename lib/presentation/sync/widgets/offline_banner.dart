import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_task_manager/domain/entities/sync_overview.dart';
import 'package:smart_task_manager/presentation/sync/cubit/sync_cubit.dart';

/// A slim banner shown while the server can't be reached.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      SyncCubit,
      SyncOverview,
      ({bool isOnline, int pending})
    >(
      selector: (sync) =>
          (isOnline: sync.isOnline, pending: sync.pendingChanges),
      builder: (context, status) {
        final colors = Theme.of(context).colorScheme;
        final message = switch (status.pending) {
          0 => 'You’re offline. Changes are saved on this device.',
          1 => 'You’re offline. 1 change will sync when you’re back online.',
          final count =>
            'You’re offline. $count changes will sync when you’re back online.',
        };

        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: status.isOnline
              ? const SizedBox(width: double.infinity)
              : Semantics(
                  liveRegion: true,
                  child: Container(
                    width: double.infinity,
                    color: colors.tertiaryContainer,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cloud_off_outlined,
                          size: 20,
                          color: colors.onTertiaryContainer,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            message,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colors.onTertiaryContainer),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
