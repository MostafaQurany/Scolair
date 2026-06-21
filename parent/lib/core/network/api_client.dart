import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/auth/data/models/change_password_request_data.dart';
import '../../features/auth/data/models/forgot_password_request_data.dart';
import '../../features/auth/data/models/forgot_password_send_otp_response_data.dart';
import '../../features/auth/data/models/google_login_request_data.dart';
import '../../features/auth/data/models/login_request_data.dart';
import '../../features/auth/data/models/login_response_data.dart';
import '../../features/auth/data/models/logout_request_data.dart';
import '../../features/auth/data/models/otp_verify_request_data.dart';
import '../../features/auth/data/models/otp_verify_response_data.dart';
import '../../features/auth/data/models/refresh_token_request_data.dart';
import '../../features/auth/data/models/refresh_token_response_data.dart';
import '../../features/auth/data/models/register_request_data.dart';
import '../../features/auth/data/models/register_response_data.dart';
import '../../features/auth/data/models/reset_password_request_data.dart';
import 'api_endpoints.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(ApiEndpoints.login)
  Future<LoginResponseData> login(@Body() LoginRequestData request);

  @POST(ApiEndpoints.register)
  Future<RegisterResponseData> register(@Body() RegisterRequestData request);

  @POST(ApiEndpoints.googleLogin)
  Future<LoginResponseData> googleLogin(@Body() GoogleLoginRequestData request);

  @POST(ApiEndpoints.refreshToken)
  Future<RefreshTokenResponseData> refreshToken(
    @Body() RefreshTokenRequestData request,
  );

  @POST(ApiEndpoints.logout)
  Future<void> logout(@Body() LogoutRequestData request);

  @POST(ApiEndpoints.forgotPasswordSendOtp)
  Future<ForgotPasswordSendOtpResponseData> forgotPasswordSendOtp(
    @Body() ForgotPasswordRequestData request,
  );

  @POST(ApiEndpoints.forgotPasswordVerifyOtp)
  Future<OtpVerifyResponseData> forgotPasswordVerifyOtp(
    @Body() OtpVerifyRequestData request,
  );

  @POST(ApiEndpoints.forgotPasswordReset)
  Future<RegisterResponseData> forgotPasswordReset(
    @Body() ResetPasswordRequestData request,
  );

  @POST(ApiEndpoints.changePassword)
  Future<void> changePassword(@Body() ChangePasswordRequestData request);
}
