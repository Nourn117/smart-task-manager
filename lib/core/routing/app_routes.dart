import 'package:flutter/widgets.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const taskDetails = '/task-details';
  static const taskForm = '/task-form';
}

/// Restorable navigation, so open screens survive the app being killed in the background.
extension AppNavigation on BuildContext {
  void openTaskDetails(String taskId) =>
      Navigator.of(this)
          .restorablePushNamed(AppRoutes.taskDetails, arguments: taskId);

  void openTaskForm({String? taskId}) =>
      Navigator.of(this)
          .restorablePushNamed(AppRoutes.taskForm, arguments: taskId);
}
