import 'package:flutter/material.dart';
import 'package:smart_task_manager/app.dart';
import 'package:smart_task_manager/core/di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  startAutomaticSync();
  runApp(const SmartTaskManagerApp());
}
