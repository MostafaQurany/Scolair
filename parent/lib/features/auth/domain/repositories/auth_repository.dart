import '../../../../core/network/api_result.dart';
import '../entities/auth_token.dart';

abstract interface class AuthRepository {
  Future<ApiResult<void>> register(
    String fullName,
    String email,
    String password,
    bool verifyTerms,
  );
  Future<ApiResult<AuthToken>> login(String username, String password);
  Future<ApiResult<AuthToken>> googleLogin(String idToken);
  Future<ApiResult<AuthToken>> refreshToken(String refreshToken);
  Future<ApiResult<void>> logout(String accessToken);
  Future<ApiResult<String>> forgotPasswordSendOtp(String email);
  Future<ApiResult<String>> forgotPasswordVerifyOtp(
    String sessionId,
    String otp,
  );
  Future<ApiResult<void>> forgotPasswordReset(
    String resetToken,
    String newPassword,
  );
  Future<ApiResult<void>> changePassword(
    String oldPassword,
    String newPassword,
  );
}
