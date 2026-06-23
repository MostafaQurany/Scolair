import '../../../../core/network/api_result.dart';
import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  const VerifyOtpUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<String>> call(String sessionId, String otp) =>
      _repository.forgotPasswordVerifyOtp(sessionId, otp);
}
