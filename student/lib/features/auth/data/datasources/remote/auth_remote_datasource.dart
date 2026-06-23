import '../../../../../core/network/api_client.dart';
import '../../models/change_password_request_data.dart';
import '../../models/forgot_password_request_data.dart';
import '../../models/forgot_password_send_otp_response_data.dart';
import '../../models/google_login_request_data.dart';
import '../../models/login_request_data.dart';
import '../../models/login_response_data.dart';
import '../../models/logout_request_data.dart';
import '../../models/otp_verify_request_data.dart';
import '../../models/otp_verify_response_data.dart';
import '../../models/refresh_token_request_data.dart';
import '../../models/refresh_token_response_data.dart';
import '../../models/register_request_data.dart';
import '../../models/register_response_data.dart';
import '../../models/reset_password_request_data.dart';

abstract interface class AuthRemoteDataSource {
  Future<RegisterResponseData> register(RegisterRequestData request);
  Future<LoginResponseData> login(LoginRequestData request);
  Future<LoginResponseData> googleLogin(GoogleLoginRequestData request);
  Future<RefreshTokenResponseData> refreshToken(
      RefreshTokenRequestData request,
      );
  Future<void> logout(LogoutRequestData request);
  Future<ForgotPasswordSendOtpResponseData> forgotPasswordSendOtp(
      ForgotPasswordRequestData request,
      );
  Future<OtpVerifyResponseData> forgotPasswordVerifyOtp(
      OtpVerifyRequestData request,
      );
  Future<void> forgotPasswordReset(ResetPasswordRequestData request);
  Future<void> changePassword(ChangePasswordRequestData request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<RegisterResponseData> register(RegisterRequestData request) =>
      _apiClient.register(request);

  @override
  Future<LoginResponseData> login(LoginRequestData request) =>
      _apiClient.login(request);

  @override
  Future<LoginResponseData> googleLogin(GoogleLoginRequestData request) =>
      _apiClient.googleLogin(request);

  @override
  Future<RefreshTokenResponseData> refreshToken(
      RefreshTokenRequestData request,
      ) => _apiClient.refreshToken(request);

  @override
  Future<void> logout(LogoutRequestData request) => _apiClient.logout(request);

  @override
  Future<ForgotPasswordSendOtpResponseData> forgotPasswordSendOtp(
      ForgotPasswordRequestData request,
      ) => _apiClient.forgotPasswordSendOtp(request);

  @override
  Future<OtpVerifyResponseData> forgotPasswordVerifyOtp(
      OtpVerifyRequestData request,
      ) => _apiClient.forgotPasswordVerifyOtp(request);

  @override
  Future<void> forgotPasswordReset(ResetPasswordRequestData request) =>
      _apiClient.forgotPasswordReset(request);

  @override
  Future<void> changePassword(ChangePasswordRequestData request) =>
      _apiClient.changePassword(request);
}
