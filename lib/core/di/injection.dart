import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_task_manager/core/database/app_database.dart';
import 'package:smart_task_manager/core/network/api_client.dart';
import 'package:smart_task_manager/core/network/network_info.dart';
import 'package:smart_task_manager/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:smart_task_manager/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:smart_task_manager/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:smart_task_manager/features/tasks/data/repositories/sync_repository_impl.dart';
import 'package:smart_task_manager/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:smart_task_manager/features/tasks/domain/repositories/sync_repository.dart';
import 'package:smart_task_manager/features/tasks/domain/repositories/task_repository.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/create_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/delete_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/get_task_by_id.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/sync_now.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/toggle_task_completion.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/update_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_sync_overview.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_task_summary.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_tasks.dart';
import 'package:smart_task_manager/features/tasks/presentation/dashboard/cubit/dashboard_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_details/cubit/task_details_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_form/cubit/task_form_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/cubit/tasks_cubit.dart';
import 'package:uuid/uuid.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  _registerCore();
  _registerTaskData();
  _registerTaskUseCases();
  _registerCubits();
}

/// Starts background synchronization. Call once after [configureDependencies].
void startAutomaticSync() => getIt<SyncRepositoryImpl>().start();

String _generateId() => const Uuid().v4();

void _registerCore() {
  getIt
    ..registerLazySingleton<AppDatabase>(
      AppDatabase.new,
      dispose: (database) => database.close(),
    )
    ..registerLazySingleton(createApiClient)
    ..registerLazySingleton(() => NetworkInfo(Connectivity()));
}

void _registerTaskData() {
  getIt
    ..registerLazySingleton(() => TaskLocalDataSource(getIt()))
    ..registerLazySingleton(() => TaskRemoteDataSource(getIt()))
    ..registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(getIt()))
    ..registerLazySingleton(
      () => SyncRepositoryImpl(
        localDataSource: getIt(),
        remoteDataSource: getIt(),
        networkInfo: getIt(),
        generateId: _generateId,
      ),
      dispose: (repository) => repository.dispose(),
    )
    ..registerLazySingleton<SyncRepository>(() => getIt<SyncRepositoryImpl>());
}

void _registerTaskUseCases() {
  getIt
    ..registerLazySingleton(() => WatchTasks(getIt()))
    ..registerLazySingleton(() => WatchTask(getIt()))
    ..registerLazySingleton(() => WatchTaskSummary(getIt()))
    ..registerLazySingleton(() => GetTaskById(getIt()))
    ..registerLazySingleton(() => CreateTask(getIt(), generateId: _generateId))
    ..registerLazySingleton(() => UpdateTask(getIt()))
    ..registerLazySingleton(() => ToggleTaskCompletion(getIt()))
    ..registerLazySingleton(() => DeleteTask(getIt()))
    ..registerLazySingleton(() => WatchSyncOverview(getIt()))
    ..registerLazySingleton(() => SyncNow(getIt()));
}

void _registerCubits() {
  getIt
    ..registerFactory(ThemeCubit.new)
    ..registerFactory(() => DashboardCubit(getIt(), getIt()))
    ..registerFactory(() => TasksCubit(getIt()))
    ..registerFactory(
      () => TaskDetailsCubit(
        watchTask: getIt(),
        toggleTaskCompletion: getIt(),
        deleteTask: getIt(),
      ),
    )
    ..registerFactory(
      () => TaskFormCubit(
        getTaskById: getIt(),
        createTask: getIt(),
        updateTask: getIt(),
      ),
    );
}
