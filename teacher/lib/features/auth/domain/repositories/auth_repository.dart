import '../../../../core/network/api_result.dart';
import '../entities/auth_token.dart';

abstract interface class AuthRepository {
  Future<ApiResult<void>> sendOtp(String countryCode, String phone);
  Future<ApiResult<AuthToken>> orgLogin(String email, String password);
  Future<ApiResult<AuthToken>> verifyOtp(String identifier, String otp);
  Future<ApiResult<void>> forgotPassword(String email);
  Future<ApiResult<void>> resetPassword(
    String token,
    String newPassword,
    String confirmPassword,
  );
}
