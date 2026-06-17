import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/forgot_password_usecase.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._forgotPasswordUseCase)
    : super(const ForgotPasswordState.initial());

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  Future<void> sendResetCode(String email) async {
    emit(const ForgotPasswordState.loading());
    final result = await _forgotPasswordUseCase(email);
    result.when(
      success: (_) => emit(const ForgotPasswordState.sent()),
      failure: (failure) => emit(ForgotPasswordState.error(failure.message)),
    );
  }
}
