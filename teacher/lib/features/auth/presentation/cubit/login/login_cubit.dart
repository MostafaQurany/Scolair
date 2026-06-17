import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._login) : super(const LoginState.initial());

  final LoginUseCase _login;

  Future<void> orgLogin(String email, String password) async {
    emit(const LoginState.loading());
    final result = await _login(email, password);
    result.when(
      success: (token) => emit(LoginState.success(token)),
      failure: (f) => emit(LoginState.error(f.message)),
    );
  }
}
