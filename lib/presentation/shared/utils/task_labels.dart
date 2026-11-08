import 'package:flutter/material.dart';
import 'package:smart_task_manager/domain/entities/sync_status.dart';
import 'package:smart_task_manager/domain/entities/task_category.dart';
import 'package:smart_task_manager/domain/entities/task_priority.dart';
import 'package:smart_task_manager/domain/entities/task_query.dart';

extension TaskPriorityLabels on TaskPriority {
  String get label => switch (this) {
    TaskPriority.low => 'Low',
    TaskPriority.medium => 'Medium',
    TaskPriority.high => 'High',
  };

  Color color(ColorScheme colors) => switch (this) {
    TaskPriority.low => colors.primary,
    TaskPriority.medium => colors.tertiary,
    TaskPriority.high => colors.error,
  };
}

extension TaskCategoryLabels on TaskCategory {
  String get label => switch (this) {
    TaskCategory.work => 'Work',
    TaskCategory.personal => 'Personal',
    TaskCategory.shopping => 'Shopping',
    TaskCategory.health => 'Health',
    TaskCategory.other => 'Other',
  };

  IconData get icon => switch (this) {
    TaskCategory.work => Icons.work_outline,
    TaskCategory.personal => Icons.person_outline,
    TaskCategory.shopping => Icons.shopping_cart_outlined,
    TaskCategory.health => Icons.favorite_outline,
    TaskCategory.other => Icons.label_outline,
  };
}

extension TaskStatusFilterLabels on TaskStatusFilter {
  String get label => switch (this) {
    TaskStatusFilter.all => 'All',
    TaskStatusFilter.pending => 'Pending',
    TaskStatusFilter.completed => 'Completed',
  };
}

extension TaskSortOptionLabels on TaskSortOption {
  String get label => switch (this) {
    TaskSortOption.newestFirst => 'Newest first',
    TaskSortOption.oldestFirst => 'Oldest first',
    TaskSortOption.dueDateSoonest => 'Due date (soonest)',
    TaskSortOption.dueDateLatest => 'Due date (latest)',
  };
}

extension SyncStatusLabels on SyncStatus {
  String get label => switch (this) {
    SyncStatus.synced => 'Synced',
    SyncStatus.pending => 'Pending sync',
    SyncStatus.failed => 'Sync failed',
  };

  IconData get icon => switch (this) {
    SyncStatus.synced => Icons.cloud_done_outlined,
    SyncStatus.pending => Icons.cloud_upload_outlined,
    SyncStatus.failed => Icons.cloud_off_outlined,
  };
}
