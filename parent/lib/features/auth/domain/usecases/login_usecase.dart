import '../../../../core/network/api_result.dart';
import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<AuthToken>> call(String username, String password) =>
      _repository.login(username, password);
}
