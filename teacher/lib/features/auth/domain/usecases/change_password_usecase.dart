import '../../../../core/network/api_result.dart';
import '../repositories/auth_repository.dart';

class ChangePasswordUseCase {
  const ChangePasswordUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<void>> call(String oldPassword, String newPassword) =>
      _repository.changePassword(oldPassword, newPassword);
}
