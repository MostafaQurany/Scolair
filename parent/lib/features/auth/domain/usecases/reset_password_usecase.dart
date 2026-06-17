import '../../../../core/network/api_result.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<void>> call(
    String token,
    String newPassword,
    String confirmPassword,
  ) {
    return _repository.resetPassword(token, newPassword, confirmPassword);
  }
}
