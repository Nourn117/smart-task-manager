import 'package:flutter/material.dart';
import 'package:smart_task_manager/core/routing/app_routes.dart';
import 'package:smart_task_manager/core/routing/home_shell.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_details/task_details_page.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_form/task_form_page.dart';

abstract final class AppRouter {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    final Widget page = switch (settings.name) {
      AppRoutes.taskDetails => TaskDetailsPage(
        taskId: settings.arguments! as String,
      ),
      AppRoutes.taskForm => TaskFormPage(taskId: settings.arguments as String?),
      _ => const HomeShell(),
    };

    return MaterialPageRoute<void>(settings: settings, builder: (_) => page);
  }
}
