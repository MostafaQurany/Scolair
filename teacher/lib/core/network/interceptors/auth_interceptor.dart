import 'dart:async';

import 'package:dio/dio.dart';

import '../../errors/app_logger.dart';
import '../../navigation/navigation_service.dart';
import '../../storage/app_secure_storage.dart';
import '../api_endpoints.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(
    this._secureStorage,
    this._refreshDio, [
    this._navigationService,
  ]);

  final AppSecureStorage _secureStorage;

  /// Plain Dio with no interceptors — used exclusively for token refresh
  /// to prevent circular 401 handling.
  final Dio _refreshDio;

  final NavigationService? _navigationService;

  static const _retryHeader = 'X-Retry-After-Refresh';

  Completer<void>? _refreshLock;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final isUnauthorized = response?.statusCode == 401;
    final alreadyRetried = err.requestOptions.headers.containsKey(_retryHeader);

    if (!isUnauthorized || alreadyRetried) {
      if (isUnauthorized && alreadyRetried) {
        await _handleUnauthorized();
      }
      return handler.next(err);
    }

    if (_refreshLock != null) {
      // Another request is already refreshing — wait for it to finish.
      await _refreshLock!.future.catchError((_) {});
      final newToken = await _secureStorage.readAccessToken();
      if (newToken != null) {
        return handler.resolve(await _retry(err.requestOptions, newToken));
      }
      await _handleUnauthorized();
      return handler.next(err);
    }

    final refreshToken = await _secureStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      await _handleUnauthorized();
      return handler.next(err);
    }

    _refreshLock = Completer<void>();
    try {
      final refreshResponse = await _refreshDio.post<Map<String, dynamic>>(
        ApiEndpoints.baseUrl + ApiEndpoints.refreshToken,
        data: {'refresh_token': refreshToken},
      );
      final data = refreshResponse.data?['data'] as Map<String, dynamic>?;
      final newAccess = data?['access_token'] as String?;
      final newRefresh = data?['refresh_token'] as String?;

      if (newAccess == null || newRefresh == null) {
        throw DioException(requestOptions: err.requestOptions);
      }

      await Future.wait([
        _secureStorage.saveAccessToken(newAccess),
        _secureStorage.saveRefreshToken(newRefresh),
      ]);

      _refreshLock!.complete();
      _refreshLock = null;

      handler.resolve(await _retry(err.requestOptions, newAccess));
    } catch (e, st) {
      AppLogger.error('Token refresh failed — clearing session', e, st);
      await _handleUnauthorized();
      _refreshLock?.completeError('refresh_failed');
      _refreshLock = null;
      handler.next(err);
    }
  }

  Future<void> _handleUnauthorized() async {
    await _secureStorage.clearAll();
    _navigationService?.navigateToLogin();
  }

  Future<Response<dynamic>> _retry(RequestOptions options, String newToken) {
    final retryOptions = options.copyWith(
      headers: {
        ...options.headers,
        'Authorization': 'Bearer $newToken',
        _retryHeader: '1',
      },
    );
    return _refreshDio.fetch(retryOptions);
  }
}
