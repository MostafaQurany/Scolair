import '../../models/forgot_password_request_data.dart';
import '../../models/login_request_data.dart';
import '../../models/login_response_data.dart';
import '../../models/otp_verify_request_data.dart';
import '../../models/otp_verify_response_data.dart';
import '../../models/reset_password_request_data.dart';
import '../../models/send_otp_request_data.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> sendOtp(SendOtpRequestData request) async {
    throw UnimplementedError('sendOtp not implemented'); // TODO: wire up when backend is ready
  }

  Future<LoginResponseData> orgLogin(LoginRequestData request) async {
    throw UnimplementedError('orgLogin not implemented');
  }

  Future<OtpVerifyResponseData> verifyOtp(OtpVerifyRequestData request) async {
    throw UnimplementedError('verifyOtp not implemented');
  }

  Future<void> forgotPassword(ForgotPasswordRequestData request) async {
    throw UnimplementedError('forgotPassword not implemented');
  }

  Future<void> resetPassword(ResetPasswordRequestData request) async {
    throw UnimplementedError('resetPassword not implemented');
  }
}
