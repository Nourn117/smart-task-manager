import 'package:flutter/material.dart';
import 'package:smart_task_manager/domain/entities/sync_status.dart';
import 'package:smart_task_manager/presentation/shared/utils/task_labels.dart';

class SyncStatusIcon extends StatelessWidget {
  const SyncStatusIcon({super.key, required this.status});

  final SyncStatus status;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Tooltip(
      message: status.label,
      child: Icon(
        status.icon,
        size: 20,
        semanticLabel: status.label,
        color: status == SyncStatus.failed
            ? colors.error
            : colors.onSurfaceVariant,
      ),
    );
  }
}
