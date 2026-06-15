import 'package:dio/dio.dart';

import 'exceptions.dart';
import 'failures.dart';

abstract final class ErrorHandler {
  static Failure handle(Object error) {
    if (error is DioException) {
      return NetworkFailure(
        error.message ?? 'Network request failed',
        code: error.response?.statusCode?.toString(),
      );
    }

    if (error is NetworkException) {
      return NetworkFailure(error.message, code: error.code);
    }

    if (error is CacheException) {
      return CacheFailure(error.message, code: error.code);
    }

    if (error is AppException) {
      return UnknownFailure(error.message, code: error.code);
    }

    return UnknownFailure(error.toString());
  }
}
