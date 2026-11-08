import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/errors/exceptions.dart';
import 'package:smart_task_manager/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:smart_task_manager/features/tasks/data/models/task_dto.dart';

import '../../../../helpers/mocks.dart';

void main() {
  late MockDio dio;
  late TaskRemoteDataSource dataSource;
  final requestOptions = RequestOptions(path: '/todos');

  setUp(() {
    dio = MockDio();
    dataSource = TaskRemoteDataSource(dio);
  });

  Response<Map<String, dynamic>> jsonResponse(Map<String, dynamic> data) =>
      Response(requestOptions: requestOptions, data: data, statusCode: 200);

  DioException dioError(DioExceptionType type, {int? statusCode}) =>
      DioException(
        requestOptions: requestOptions,
        type: type,
        response: statusCode == null
            ? null
            : Response<Object?>(
                requestOptions: requestOptions,
                statusCode: statusCode,
              ),
      );

  void stubFetch(Future<Response<Map<String, dynamic>>> Function() answer) {
    when(
      () => dio.get<Map<String, dynamic>>(
        '/todos',
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((_) => answer());
  }

  group('fetchTasks', () {
    test('parses the todos list', () async {
      stubFetch(
        () async => jsonResponse({
          'todos': [
            {'id': 1, 'todo': 'Buy milk', 'completed': false, 'userId': 3},
          ],
          'total': 254,
        }),
      );

      expect(await dataSource.fetchTasks(), [
        const TaskDto(id: 1, title: 'Buy milk', completed: false),
      ]);
    });

    test('throws InvalidResponseException for a malformed response', () {
      stubFetch(() async => jsonResponse({'items': <Object>[]}));

      expect(dataSource.fetchTasks, throwsA(isA<InvalidResponseException>()));
    });

    test('throws NetworkException on a timeout', () {
      stubFetch(
        () => Future.error(dioError(DioExceptionType.connectionTimeout)),
      );

      expect(dataSource.fetchTasks, throwsA(isA<NetworkException>()));
    });

    test('throws NetworkException when the connection fails', () {
      stubFetch(() => Future.error(dioError(DioExceptionType.connectionError)));

      expect(dataSource.fetchTasks, throwsA(isA<NetworkException>()));
    });

    test('throws ServerException on a server error', () {
      stubFetch(
        () => Future.error(
          dioError(DioExceptionType.badResponse, statusCode: 500),
        ),
      );

      expect(
        dataSource.fetchTasks,
        throwsA(
          isA<ServerException>().having(
            (error) => error.statusCode,
            'statusCode',
            500,
          ),
        ),
      );
    });
  });

  group('writes', () {
    test('createTask posts the todo and returns the created task', () async {
      when(
        () => dio.post<Map<String, dynamic>>(
          '/todos/add',
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => jsonResponse({
          'id': 255,
          'todo': 'Buy milk',
          'completed': false,
          'userId': 1,
        }),
      );

      final created = await dataSource.createTask(
        title: 'Buy milk',
        completed: false,
      );

      expect(created.id, 255);
      verify(
        () => dio.post<Map<String, dynamic>>(
          '/todos/add',
          data: {'todo': 'Buy milk', 'completed': false, 'userId': 1},
        ),
      ).called(1);
    });

    test('updateTask throws NotFoundException for an unknown task', () {
      when(
        () => dio.put<Map<String, dynamic>>(
          '/todos/999',
          data: any(named: 'data'),
        ),
      ).thenAnswer(
        (_) => Future.error(
          dioError(DioExceptionType.badResponse, statusCode: 404),
        ),
      );

      expect(
        () => dataSource.updateTask(999, title: 'Task', completed: true),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('deleteTask sends a delete request', () async {
      when(() => dio.delete<Object?>('/todos/3')).thenAnswer(
        (_) async => Response(requestOptions: requestOptions, statusCode: 200),
      );

      await dataSource.deleteTask(3);

      verify(() => dio.delete<Object?>('/todos/3')).called(1);
    });
  });
}
