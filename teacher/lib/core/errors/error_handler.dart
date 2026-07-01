import 'dart:convert';
import 'package:dio/dio.dart';

import 'app_logger.dart';
import 'exceptions.dart';
import 'failures.dart';

abstract final class ErrorHandler {
  static Failure handle(Object error) {
    AppLogger.error('ErrorHandler: ${error.runtimeType}', error, StackTrace.current);

    if (error is DioException) {
      String message = error.message ?? 'Network request failed';

      try {
        final responseData = error.response?.data;
        if (responseData != null) {
          if (responseData is Map<String, dynamic>) {
            if (responseData.containsKey('message') &&
                responseData['message'] is String &&
                (responseData['message'] as String).isNotEmpty) {
              message = responseData['message'] as String;
            } else if (responseData.containsKey('_server_messages') &&
                responseData['_server_messages'] is String) {
              final rawMsgs = responseData['_server_messages'] as String;
              final parsed = jsonDecode(rawMsgs);
              if (parsed is List && parsed.isNotEmpty) {
                final firstMsg = parsed.first;
                if (firstMsg is Map && firstMsg.containsKey('message')) {
                  message = firstMsg['message'] as String;
                } else if (firstMsg is String) {
                  try {
                    final innerParsed = jsonDecode(firstMsg);
                    if (innerParsed is Map &&
                        innerParsed.containsKey('message')) {
                      message = innerParsed['message'] as String;
                    } else {
                      message = firstMsg;
                    }
                  } catch (_) {
                    message = firstMsg;
                  }
                }
              }
            } else if (responseData.containsKey('exception') &&
                responseData['exception'] is String &&
                (responseData['exception'] as String).isNotEmpty) {
              message = responseData['exception'] as String;
            }
          } else if (responseData is String && responseData.isNotEmpty) {
            message = responseData;
          }
        }
      } catch (_) {}

      // Strip raw HTML response pages (e.g. Nginx 502/504 Bad Gateway pages)
      if (message.contains('<html') ||
          message.contains('<body') ||
          message.contains('<!DOCTYPE html>')) {
        message =
            'Server error (${error.response?.statusCode ?? "unknown"}). Please try again later.';
      }

      return NetworkFailure(
        message,
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
