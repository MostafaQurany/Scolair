import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/send_otp_usecase.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerUseCase) : super(const RegisterState.initial());

  final RegisterUseCase _registerUseCase;

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required bool verifyTerms,
  }) async {
    emit(const RegisterState.loading());
    final result = await _registerUseCase(
      fullName,
      email,
      password,
      verifyTerms,
    );
    result.when(
      success: (_) => emit(const RegisterState.success()),
      failure: (failure) => emit(RegisterState.error(failure.message)),
    );
  }
}
