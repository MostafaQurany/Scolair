sealed class Failure {
  const Failure(this.message, {this.code});

  final String message;
  final String? code;
}

final class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code});
}

final class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

final class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code});
}

final class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.code});
}
