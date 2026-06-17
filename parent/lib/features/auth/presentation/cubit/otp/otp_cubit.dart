import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/verify_otp_usecase.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._verifyOtpUseCase) : super(const OtpState.initial());

  final VerifyOtpUseCase _verifyOtpUseCase;

  Future<void> verify(String email, String otp) async {
    emit(const OtpState.loading());
    final result = await _verifyOtpUseCase(email, otp);
    result.when(
      success: (token) => emit(OtpState.success(token)),
      failure: (failure) => emit(OtpState.error(failure.message)),
    );
  }
}
