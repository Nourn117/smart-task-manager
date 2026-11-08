import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/network/network_info.dart';
import 'package:smart_task_manager/data/datasources/task_local_data_source.dart';
import 'package:smart_task_manager/data/datasources/task_remote_data_source.dart';
import 'package:smart_task_manager/domain/repositories/task_repository.dart';
import 'package:smart_task_manager/domain/usecases/create_task.dart';
import 'package:smart_task_manager/domain/usecases/delete_task.dart';
import 'package:smart_task_manager/domain/usecases/get_task_by_id.dart';
import 'package:smart_task_manager/domain/usecases/toggle_task_completion.dart';
import 'package:smart_task_manager/domain/usecases/update_task.dart';
import 'package:smart_task_manager/domain/usecases/watch_task.dart';
import 'package:smart_task_manager/domain/usecases/watch_task_summary.dart';
import 'package:smart_task_manager/domain/usecases/watch_tasks.dart';
import 'package:smart_task_manager/presentation/task_details/cubit/task_details_cubit.dart';
import 'package:smart_task_manager/presentation/task_form/cubit/task_form_cubit.dart';
import 'package:smart_task_manager/presentation/tasks/cubit/tasks_cubit.dart';

// Core
class MockConnectivity extends Mock implements Connectivity {}

class MockDio extends Mock implements Dio {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

// Data
class MockTaskRepository extends Mock implements TaskRepository {}

class MockTaskLocalDataSource extends Mock implements TaskLocalDataSource {}

class MockTaskRemoteDataSource extends Mock implements TaskRemoteDataSource {}

// Use cases
class MockWatchTasks extends Mock implements WatchTasks {}

class MockWatchTask extends Mock implements WatchTask {}

class MockWatchTaskSummary extends Mock implements WatchTaskSummary {}

class MockGetTaskById extends Mock implements GetTaskById {}

class MockCreateTask extends Mock implements CreateTask {}

class MockUpdateTask extends Mock implements UpdateTask {}

class MockToggleTaskCompletion extends Mock implements ToggleTaskCompletion {}

class MockDeleteTask extends Mock implements DeleteTask {}

// Cubits
class MockTasksCubit extends Mock implements TasksCubit {}

class MockTaskDetailsCubit extends Mock implements TaskDetailsCubit {}

class MockTaskFormCubit extends Mock implements TaskFormCubit {}

/// Makes a mocked cubit expose a fixed [state] to the widgets under test.
void stubState<S>(BlocBase<S> cubit, S state) {
  when(() => cubit.state).thenReturn(state);
  when(() => cubit.stream).thenAnswer((_) => Stream<S>.empty());
}
