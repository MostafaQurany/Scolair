import '../../../../core/network/api_result.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordSendOtpUseCase {
  const ForgotPasswordSendOtpUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<String>> call(String email) =>
      _repository.forgotPasswordSendOtp(email);
}
