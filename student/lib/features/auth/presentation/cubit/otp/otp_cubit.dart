import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/verify_otp_usecase.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._verifyOtp) : super(const OtpState.initial());

  final VerifyOtpUseCase _verifyOtp;

  Future<void> verify(String email, String otp) async {
    emit(const OtpState.loading());
    final result = await _verifyOtp(email, otp);
    result.when(
      success: (token) => emit(OtpState.success(token)),
      failure: (f) => emit(OtpState.error(f.message)),
    );
  }
}
