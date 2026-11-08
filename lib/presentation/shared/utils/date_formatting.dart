import 'package:flutter/material.dart';

extension DateFormatting on BuildContext {
  String formatDate(DateTime date) =>
      MaterialLocalizations.of(this).formatMediumDate(date);

  String formatDateTime(DateTime date) =>
      '${formatDate(date)}, ${TimeOfDay.fromDateTime(date).format(this)}';
}

extension DueDateChecks on DateTime {
  /// True when this date is before today (the due day itself is not overdue).
  bool get isOverdue {
    final now = DateTime.now();
    return isBefore(DateTime(now.year, now.month, now.day));
  }
}
