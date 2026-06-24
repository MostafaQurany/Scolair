import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/forgot_password_usecase.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._useCase)
    : super(const ForgotPasswordState.initial());

  final ForgotPasswordSendOtpUseCase _useCase;

  Future<void> sendResetCode(String email) async {
    emit(const ForgotPasswordState.loading());
    final result = await _useCase(email);
    result.when(
      success: (sessionId) => emit(ForgotPasswordState.sent(sessionId)),
      failure: (failure) => emit(ForgotPasswordState.error(failure.message)),
    );
  }
}
