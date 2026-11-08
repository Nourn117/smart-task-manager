import 'package:get_it/get_it.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/create_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/delete_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/get_task_by_id.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/toggle_task_completion.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/update_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_task_summary.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_tasks.dart';
import 'package:uuid/uuid.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  _registerTaskUseCases();
}

void _registerTaskUseCases() {
  getIt
    ..registerLazySingleton(() => WatchTasks(getIt()))
    ..registerLazySingleton(() => WatchTaskSummary(getIt()))
    ..registerLazySingleton(() => GetTaskById(getIt()))
    ..registerLazySingleton(
      () => CreateTask(getIt(), generateId: () => const Uuid().v4()),
    )
    ..registerLazySingleton(() => UpdateTask(getIt()))
    ..registerLazySingleton(() => ToggleTaskCompletion(getIt()))
    ..registerLazySingleton(() => DeleteTask(getIt()));
}
