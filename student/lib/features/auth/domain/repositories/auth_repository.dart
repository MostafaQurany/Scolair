import '../../../../core/network/api_result.dart';
import '../entities/auth_token.dart';

abstract interface class AuthRepository {
  Future<ApiResult<AuthToken>> login(String email, String password);
  Future<ApiResult<AuthToken>> verifyOtp(String email, String otp);
  Future<ApiResult<void>> forgotPassword(String email);
  Future<ApiResult<void>> resetPassword(
    String token,
    String newPassword,
    String confirmPassword,
  );
}
