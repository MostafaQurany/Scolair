import '../../../../core/network/api_result.dart';
import '../entities/auth_token.dart';
import '../repositories/auth_repository.dart';

class GoogleLoginUseCase {
  const GoogleLoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<AuthToken>> call(String idToken) =>
      _repository.googleLogin(idToken);
}
