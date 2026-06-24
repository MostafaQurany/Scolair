import '../../../../core/network/api_result.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordVerifyOtpUseCase {
  const ForgotPasswordVerifyOtpUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<String>> call(String sessionId, String otp) =>
      _repository.forgotPasswordVerifyOtp(sessionId, otp);
}
