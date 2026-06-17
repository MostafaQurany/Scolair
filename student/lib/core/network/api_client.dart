import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/auth/data/models/forgot_password_request_data.dart';
import '../../features/auth/data/models/login_request_data.dart';
import '../../features/auth/data/models/login_response_data.dart';
import '../../features/auth/data/models/otp_verify_request_data.dart';
import '../../features/auth/data/models/otp_verify_response_data.dart';
import '../../features/auth/data/models/reset_password_request_data.dart';
import 'api_endpoints.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(ApiEndpoints.health)
  Future<void> healthCheck();

  @POST(ApiEndpoints.login)
  Future<LoginResponseData> login(@Body() LoginRequestData request);

  @POST(ApiEndpoints.verifyOtp)
  Future<OtpVerifyResponseData> verifyOtp(@Body() OtpVerifyRequestData request);

  @POST(ApiEndpoints.forgotPassword)
  Future<void> forgotPassword(@Body() ForgotPasswordRequestData request);

  @POST(ApiEndpoints.resetPassword)
  Future<void> resetPassword(@Body() ResetPasswordRequestData request);
}
