import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:smart_task_manager/features/tasks/domain/repositories/task_repository.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/create_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/delete_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/get_task_by_id.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/toggle_task_completion.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/update_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_task.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_task_summary.dart';
import 'package:smart_task_manager/features/tasks/domain/usecases/watch_tasks.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_details/cubit/task_details_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/task_form/cubit/task_form_cubit.dart';
import 'package:smart_task_manager/features/tasks/presentation/tasks/cubit/tasks_cubit.dart';

// Data
class MockTaskRepository extends Mock implements TaskRepository {}

class MockTaskLocalDataSource extends Mock implements TaskLocalDataSource {}

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
