sealed class Failure {
  const Failure(this.message);

  final String message;
}

final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);

  const ValidationFailure.emptyTitle() : super('Title is required.');
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Task not found.']);
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Could not access local storage.']);
}
