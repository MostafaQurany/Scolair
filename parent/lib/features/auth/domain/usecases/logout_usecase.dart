import '../../../../core/network/api_result.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  const LogoutUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<void>> call(String accessToken) =>
      _repository.logout(accessToken);
}
