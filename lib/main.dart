import 'package:flutter/material.dart';
import 'package:smart_task_manager/app.dart';
import 'package:smart_task_manager/core/di/injection.dart';

void main() {
  configureDependencies();
  runApp(const SmartTaskManagerApp());
}
