import 'dart:developer';

import 'package:smart_task_manager/core/errors/failure.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/data/datasources/task_local_data_source.dart';
import 'package:smart_task_manager/data/models/task_row_mapper.dart';
import 'package:smart_task_manager/domain/entities/sync_status.dart';
import 'package:smart_task_manager/domain/entities/task.dart';
import 'package:smart_task_manager/domain/entities/task_query.dart';
import 'package:smart_task_manager/domain/entities/task_summary.dart';
import 'package:smart_task_manager/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl(this._localDataSource);

  final TaskLocalDataSource _localDataSource;

  @override
  Stream<List<Task>> watchTasks(TaskQuery query) => _localDataSource
      .watchTasks(query)
      .map((rows) => rows.map((row) => row.toEntity()).toList());

  @override
  Stream<TaskSummary> watchSummary() => _localDataSource.watchSummary().map(
    (counts) => TaskSummary(total: counts.total, completed: counts.completed),
  );

  @override
  Stream<Task?> watchTask(String id) =>
      _localDataSource.watchTaskById(id).map((row) => row?.toEntity());

  @override
  Future<Result<Task>> getTaskById(String id) => _guard(() async {
    final row = await _localDataSource.getTaskById(id);
    return row == null ? const Err(NotFoundFailure()) : Ok(row.toEntity());
  });

  @override
  Future<Result<Task>> createTask(Task task) => _guard(() async {
    final pendingTask = task.copyWith(syncStatus: SyncStatus.pending);
    await _localDataSource.insertTask(pendingTask.toCompanion());
    return Ok(pendingTask);
  });

  @override
  Future<Result<Task>> updateTask(Task task) => _guard(() async {
    final pendingTask = task.copyWith(syncStatus: SyncStatus.pending);
    final updated = await _localDataSource.updateTask(
      pendingTask.toCompanion(),
    );
    return updated ? Ok(pendingTask) : const Err(NotFoundFailure());
  });

  @override
  Future<Result<void>> deleteTask(String id) => _guard(() async {
    final deleted = await _localDataSource.deleteTask(id);
    return deleted ? const Ok(null) : const Err(NotFoundFailure());
  });

  Future<Result<T>> _guard<T>(Future<Result<T>> Function() action) async {
    try {
      return await action();
    } on Exception catch (error, stackTrace) {
      log(
        'Local storage operation failed',
        name: 'TaskRepository',
        error: error,
        stackTrace: stackTrace,
      );
      return const Err(CacheFailure());
    }
  }
}
