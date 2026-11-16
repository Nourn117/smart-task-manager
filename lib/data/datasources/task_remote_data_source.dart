import 'package:dio/dio.dart';
import 'package:smart_task_manager/core/errors/exceptions.dart';
import 'package:smart_task_manager/data/models/task_dto.dart';

/// DummyJSON todos API. Writes are simulated by the server and not stored.
class TaskRemoteDataSource {
  const TaskRemoteDataSource(this._dio);

  static const pullLimit = 30;

  /// DummyJSON requires a user for new todos; any existing user id works.
  static const _sampleUserId = 1;

  final Dio _dio;

  Future<List<TaskDto>> fetchTasks() => _request(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/todos',
      queryParameters: {'limit': pullLimit},
    );
    final todos = response.data?['todos'];
    if (todos is! List<Object?>) {
      throw const FormatException('Missing "todos" list');
    }
    return [for (final todo in todos) TaskDto.fromJson(_asJson(todo))];
  });

  Future<TaskDto> createTask({
    required String title,
    required bool completed,
  }) => _request(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/todos/add',
      data: {'todo': title, 'completed': completed, 'userId': _sampleUserId},
    );
    return TaskDto.fromJson(_asJson(response.data));
  });

  Future<TaskDto> updateTask(
    int remoteId, {
    required String title,
    required bool completed,
  }) => _request(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/todos/$remoteId',
      data: {'todo': title, 'completed': completed},
    );
    return TaskDto.fromJson(_asJson(response.data));
  });

  Future<void> deleteTask(int remoteId) => _request(() async {
    await _dio.delete<Object?>('/todos/$remoteId');
  });

  /// Converts Dio and parsing errors into [RemoteException]s.
  Future<T> _request<T>(Future<T> Function() send) async {
    try {
      return await send();
    } on DioException catch (error) {
      throw switch (error.type) {
        DioExceptionType.badResponse => switch (error.response?.statusCode) {
          404 => const NotFoundException(),
          final statusCode => ServerException(statusCode),
        },
        _ => const NetworkException(),
      };
    } on FormatException {
      throw const InvalidResponseException();
    }
  }

  static Map<String, dynamic> _asJson(Object? value) =>
      value is Map<String, dynamic>
      ? value
      : throw const FormatException('Expected a JSON object');
}
