import 'package:flutter/material.dart';

extension AppSnackBar on BuildContext {
  /// Shows a short floating message, replacing any message already visible.
  void showMessage(String message, {bool isError = false}) {
    final colors = Theme.of(this).colorScheme;
    final background = isError ? colors.error : colors.primary;
    final foreground = isError ? colors.onError : colors.onPrimary;

    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: background,
          content: Row(
            children: [
              Icon(
                isError ? Icons.error_outline : Icons.check_circle_outline,
                color: foreground,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(message, style: TextStyle(color: foreground)),
              ),
            ],
          ),
        ),
      );
  }
}
