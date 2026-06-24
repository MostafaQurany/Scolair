import '../../../../core/network/api_result.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<void>> call(
    String token,
    String newPassword,
  ) => _repository.forgotPasswordReset(token, newPassword);
}
