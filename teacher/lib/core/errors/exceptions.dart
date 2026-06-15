class AppException implements Exception {
  const AppException(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() {
    final errorCode = code;
    if (errorCode == null || errorCode.isEmpty) {
      return message;
    }
    return '$message ($errorCode)';
  }
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code});
}

class CacheException extends AppException {
  const CacheException(super.message, {super.code});
}
