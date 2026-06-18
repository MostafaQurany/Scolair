import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/send_otp_usecase.dart';
import 'phone_login_state.dart';

class PhoneLoginCubit extends Cubit<PhoneLoginState> {
  PhoneLoginCubit(this._sendOtp) : super(const PhoneLoginState.initial());

  final SendOtpUseCase _sendOtp;

  Future<void> sendOtp(String countryCode, String phone) async {
    emit(const PhoneLoginState.loading());
    final result = await _sendOtp(countryCode: countryCode, phone: phone);
    result.when(
      success: (_) => emit(const PhoneLoginState.sent()),
      failure: (f) => emit(PhoneLoginState.error(f.message)),
    );
  }
}
