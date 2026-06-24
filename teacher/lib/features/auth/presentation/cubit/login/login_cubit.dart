import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/org_login_usecase.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase, this._googleLoginUseCase)
    : super(const LoginState.initial());

  final LoginUseCase _loginUseCase;
  final GoogleLoginUseCase _googleLoginUseCase;

  Future<void> login(String username, String password) async {
    emit(const LoginState.loading());
    final result = await _loginUseCase(username, password);
    result.when(
      success: (token) => emit(LoginState.success(token)),
      failure: (failure) => emit(LoginState.error(failure.message)),
    );
  }

  Future<void> googleLogin(String idToken) async {
    emit(const LoginState.loading());
    final result = await _googleLoginUseCase(idToken);
    result.when(
      success: (token) => emit(LoginState.success(token)),
      failure: (failure) => emit(LoginState.error(failure.message)),
    );
  }
}
