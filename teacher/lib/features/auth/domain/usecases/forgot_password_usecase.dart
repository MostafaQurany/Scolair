import '../../../../core/network/api_result.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  const ForgotPasswordUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<void>> call(String email) =>
      _repository.forgotPassword(email);
}
