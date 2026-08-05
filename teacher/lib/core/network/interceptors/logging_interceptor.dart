import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Returns a configured logger interceptor if in debug mode, otherwise returns a silent interceptor.
Interceptor getDioLogger() {
  if (kDebugMode) {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    );
  }
  return const Interceptor(); // Dummy interceptor for production that does nothing
}
