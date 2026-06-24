import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/change_password_usecase.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._useCase)
    : super(const ChangePasswordState.initial());

  final ChangePasswordUseCase _useCase;

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(const ChangePasswordState.loading());
    final result = await _useCase(oldPassword, newPassword);
    result.when(
      success: (_) => emit(const ChangePasswordState.success()),
      failure: (failure) => emit(ChangePasswordState.error(failure.message)),
    );
  }
}
