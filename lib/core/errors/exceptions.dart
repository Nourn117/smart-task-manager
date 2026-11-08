/// Errors raised by the remote data source. Repositories catch these and
/// never let them reach the presentation layer.
sealed class RemoteException implements Exception {
  const RemoteException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// The API could not be reached: no connection, a timeout or a dropped request.
final class NetworkException extends RemoteException {
  const NetworkException([super.message = 'The server could not be reached.']);
}

final class NotFoundException extends RemoteException {
  const NotFoundException([
    super.message = 'The task was not found on the server.',
  ]);
}

final class ServerException extends RemoteException {
  ServerException(this.statusCode)
    : super('The server returned an error (${statusCode ?? 'unknown'}).');

  final int? statusCode;
}

final class InvalidResponseException extends RemoteException {
  const InvalidResponseException([
    super.message = 'The server sent an unexpected response.',
  ]);
}
