import '../../../../core/network/api_result.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordResetUseCase {
  const ForgotPasswordResetUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<void>> call(String resetToken, String newPassword) =>
      _repository.forgotPasswordReset(resetToken, newPassword);
}
