import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:smart_task_manager/features/tasks/domain/repositories/task_repository.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

class MockTaskLocalDataSource extends Mock implements TaskLocalDataSource {}
