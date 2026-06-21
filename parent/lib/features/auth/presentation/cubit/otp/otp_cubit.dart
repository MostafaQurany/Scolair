import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/verify_otp_usecase.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._verifyOtpUseCase) : super(const OtpState.initial());

  final ForgotPasswordVerifyOtpUseCase _verifyOtpUseCase;

  Future<void> verify(String sessionId, String otp) async {
    emit(const OtpState.loading());
    final result = await _verifyOtpUseCase(sessionId, otp);
    result.when(
      success: (resetToken) => emit(OtpState.success(resetToken)),
      failure: (failure) => emit(OtpState.error(failure.message)),
    );
  }
}
