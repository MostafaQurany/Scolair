import '../../../../core/network/api_result.dart';
import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';

class OrgLoginUseCase {
  const OrgLoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<AuthToken>> call(String email, String password) {
    return _repository.orgLogin(email, password);
  }
}
