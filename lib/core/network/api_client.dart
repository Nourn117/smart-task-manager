import 'package:dio/dio.dart';

abstract final class ApiConfig {
  /// Override with `--dart-define=API_BASE_URL=...`.
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://dummyjson.com',
  );

  static const timeout = Duration(seconds: 10);
}

Dio createApiClient() {
  return Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.timeout,
      sendTimeout: ApiConfig.timeout,
      receiveTimeout: ApiConfig.timeout,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );
}
