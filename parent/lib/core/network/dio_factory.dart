import 'package:dio/dio.dart';

import '../storage/app_secure_storage.dart';
import 'api_endpoints.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

abstract final class DioFactory {
  static Dio create(AppSecureStorage secureStorage) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: const {
          Headers.acceptHeader: Headers.jsonContentType,
          Headers.contentTypeHeader: Headers.jsonContentType,
        },
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(secureStorage),
      SafeLoggingInterceptor(),
    ]);

    return dio;
  }
}
