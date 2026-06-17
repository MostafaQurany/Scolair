import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/forgot_password_usecase.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._forgotPassword)
      : super(const ForgotPasswordState.initial());

  final ForgotPasswordUseCase _forgotPassword;

  Future<void> sendResetCode(String email) async {
    emit(const ForgotPasswordState.loading());
    final result = await _forgotPassword(email);
    result.when(
      success: (_) => emit(const ForgotPasswordState.sent()),
      failure: (f) => emit(ForgotPasswordState.error(f.message)),
    );
  }
}
