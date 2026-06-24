import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/reset_password_usecase.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._useCase)
      : super(const ResetPasswordState.initial());

  final ForgotPasswordResetUseCase _useCase;

  Future<void> reset(
      String resetToken,
      String newPassword
      ) async {
    emit(const ResetPasswordState.loading());
    final result = await _useCase(resetToken, newPassword);
    result.when(
      success: (_) => emit(const ResetPasswordState.success()),
      failure: (failure) => emit(ResetPasswordState.error(failure.message)),
    );
  }
}
