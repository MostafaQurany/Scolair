import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/reset_password_usecase.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._resetPassword)
      : super(const ResetPasswordState.initial());

  final ResetPasswordUseCase _resetPassword;

  Future<void> reset(
    String token,
    String newPassword,
  ) async {
    emit(const ResetPasswordState.loading());
    final result = await _resetPassword(token, newPassword);
    result.when(
      success: (_) => emit(const ResetPasswordState.success()),
      failure: (f) => emit(ResetPasswordState.error(f.message)),
    );
  }
}
