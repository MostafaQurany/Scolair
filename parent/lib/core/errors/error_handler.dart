import 'dart:convert';

import 'package:dio/dio.dart';

import 'exceptions.dart';
import 'failures.dart';

abstract final class ErrorHandler {
  static Failure handle(Object error) {
    if (error is DioException) {
      return _fromDio(error);
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

  static Failure _fromDio(DioException e) {
    final type = e.type;
    if (type == DioExceptionType.connectionError ||
        type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout) {
      return const NetworkFailure('No internet connection');
    }

    final statusCode = e.response?.statusCode;
    if (statusCode != null) {
      final message = _extractServerMessage(e.response?.data, statusCode);
      return ServerFailure(message, code: statusCode.toString());
    }

    return NetworkFailure(e.message ?? 'Network error');
  }

  static String _extractServerMessage(dynamic data, int statusCode) {
    if (data is Map<String, dynamic>) {
      final fromMessage = data['message'];
      if (fromMessage is String && fromMessage.isNotEmpty) {
        return fromMessage;
      }

      final fromException = data['exception'];
      if (fromException is String && fromException.isNotEmpty) {
        return fromException;
      }

      // Frappe encodes _server_messages as a JSON string: "[{\"message\":\"...\"}]"
      final serverMessages = data['_server_messages'];
      if (serverMessages is String && serverMessages.isNotEmpty) {
        try {
          final decoded = jsonDecode(serverMessages);
          if (decoded is List && decoded.isNotEmpty) {
            final first = decoded.first;
            if (first is Map<String, dynamic>) {
              final msg = first['message'];
              if (msg is String && msg.isNotEmpty) return msg;
            }
            if (first is String) {
              final inner = jsonDecode(first);
              if (inner is Map<String, dynamic>) {
                final msg = inner['message'];
                if (msg is String && msg.isNotEmpty) return msg;
              }
            }
          }
        } catch (_) {}
      }
    }

    return 'Server error ($statusCode)';
  }
}
