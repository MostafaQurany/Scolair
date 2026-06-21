import '../../../../core/network/api_result.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<void>> call(
    String fullName,
    String email,
    String password,
    bool verifyTerms,
  ) => _repository.register(fullName, email, password, verifyTerms);
}
