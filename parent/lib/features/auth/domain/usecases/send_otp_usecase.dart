import '../../../../core/network/api_result.dart';
import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  const SendOtpUseCase(this._repository);

  final AuthRepository _repository;

  Future<ApiResult<void>> call({
    required String countryCode,
    required String phone,
  }) =>
      _repository.sendOtp(countryCode, phone);
}
