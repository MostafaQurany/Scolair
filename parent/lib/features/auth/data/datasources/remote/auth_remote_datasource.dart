import '../../../../../core/network/api_client.dart';
import '../../models/forgot_password_request_data.dart';
import '../../models/login_request_data.dart';
import '../../models/send_otp_request_data.dart';
import '../../models/login_response_data.dart';
import '../../models/otp_verify_request_data.dart';
import '../../models/otp_verify_response_data.dart';
import '../../models/reset_password_request_data.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> sendOtp(SendOtpRequestData request);
  Future<LoginResponseData> login(LoginRequestData request);
  Future<LoginResponseData> orgLogin(LoginRequestData request);
  Future<OtpVerifyResponseData> verifyOtp(OtpVerifyRequestData request);
  Future<void> forgotPassword(ForgotPasswordRequestData request);
  Future<void> resetPassword(ResetPasswordRequestData request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._apiClient);

  // ignore: unused_field — will be used when backend is wired up
  final ApiClient _apiClient;

  @override
  Future<void> sendOtp(SendOtpRequestData request) {
    // TODO: wire up when backend is ready
    throw UnimplementedError('sendOtp not implemented');
  }

  @override
  Future<LoginResponseData> login(LoginRequestData request) {
    // TODO: wire up when backend is ready
    throw UnimplementedError('login not implemented');
  }

  @override
  Future<LoginResponseData> orgLogin(LoginRequestData request) {
    // TODO: wire up when backend is ready
    throw UnimplementedError('orgLogin not implemented');
  }

  @override
  Future<OtpVerifyResponseData> verifyOtp(OtpVerifyRequestData request) {
    // TODO: wire up when backend is ready
    throw UnimplementedError('verifyOtp not implemented');
  }

  @override
  Future<void> forgotPassword(ForgotPasswordRequestData request) {
    // TODO: wire up when backend is ready
    throw UnimplementedError('forgotPassword not implemented');
  }

  @override
  Future<void> resetPassword(ResetPasswordRequestData request) {
    // TODO: wire up when backend is ready
    throw UnimplementedError('resetPassword not implemented');
  }
}
