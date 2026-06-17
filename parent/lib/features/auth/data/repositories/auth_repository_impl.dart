import 'package:dio/dio.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/entities/auth_token.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';
import '../models/forgot_password_request_data.dart';
import '../models/login_request_data.dart';
import '../models/otp_verify_request_data.dart';
import '../models/reset_password_request_data.dart';
import '../models/send_otp_request_data.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<void>> sendOtp(String countryCode, String phone) =>
      _voidResult(
        () => _remoteDataSource.sendOtp(
          SendOtpRequestData(countryCode: countryCode, phone: phone),
        ),
      );

  @override
  Future<ApiResult<AuthToken>> login(String email, String password) =>
      _authResult(
        () => _remoteDataSource.login(
          LoginRequestData(email: email, password: password),
        ),
        (r) => AuthToken(
          accessToken: r.accessToken,
          refreshToken: r.refreshToken,
        ),
      );

  @override
  Future<ApiResult<AuthToken>> orgLogin(String email, String password) =>
      _authResult(
        () => _remoteDataSource.orgLogin(
          LoginRequestData(email: email, password: password),
        ),
        (r) => AuthToken(
          accessToken: r.accessToken,
          refreshToken: r.refreshToken,
        ),
      );

  @override
  Future<ApiResult<AuthToken>> verifyOtp(String email, String otp) =>
      _authResult(
        () => _remoteDataSource.verifyOtp(
          OtpVerifyRequestData(email: email, otp: otp),
        ),
        (r) => AuthToken(
          accessToken: r.accessToken,
          refreshToken: r.refreshToken,
        ),
      );

  @override
  Future<ApiResult<void>> forgotPassword(String email) => _voidResult(
    () => _remoteDataSource.forgotPassword(
      ForgotPasswordRequestData(email: email),
    ),
  );

  @override
  Future<ApiResult<void>> resetPassword(
    String token,
    String newPassword,
    String confirmPassword,
  ) => _voidResult(
    () => _remoteDataSource.resetPassword(
      ResetPasswordRequestData(
        token: token,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      ),
    ),
  );

  Future<ApiResult<AuthToken>> _authResult<T>(
    Future<T> Function() call,
    AuthToken Function(T) map,
  ) async {
    try {
      return ApiSuccess(map(await call()));
    } on DioException catch (e) {
      return ApiFailure(_fromDio(e));
    } on Object catch (e) {
      return ApiFailure(UnknownFailure(e.toString()));
    }
  }

  Future<ApiResult<void>> _voidResult(Future<void> Function() call) async {
    try {
      await call();
      return const ApiSuccess(null);
    } on DioException catch (e) {
      return ApiFailure(_fromDio(e));
    } on Object catch (e) {
      return ApiFailure(UnknownFailure(e.toString()));
    }
  }

  Failure _fromDio(DioException e) {
    final type = e.type;
    if (type == DioExceptionType.connectionError ||
        type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout) {
      return const NetworkFailure('No internet connection');
    }
    final statusCode = e.response?.statusCode;
    final message =
        e.response?.data?['message'] as String? ??
        e.message ??
        'Server error';
    return ServerFailure(message, code: statusCode?.toString());
  }
}
