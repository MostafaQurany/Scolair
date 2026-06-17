import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/reset_password_usecase.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._resetPasswordUseCase)
    : super(const ResetPasswordState.initial());

  final ResetPasswordUseCase _resetPasswordUseCase;

  Future<void> reset(
    String token,
    String newPassword,
    String confirmPassword,
  ) async {
    emit(const ResetPasswordState.loading());
    final result = await _resetPasswordUseCase(
      token,
      newPassword,
      confirmPassword,
    );
    result.when(
      success: (_) => emit(const ResetPasswordState.success()),
      failure: (failure) => emit(ResetPasswordState.error(failure.message)),
    );
  }
}
