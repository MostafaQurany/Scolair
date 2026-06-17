import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/org_login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase, this._orgLoginUseCase)
    : super(const LoginState.initial());

  final LoginUseCase _loginUseCase;
  final OrgLoginUseCase _orgLoginUseCase;

  Future<void> login(String email, String password) async {
    emit(const LoginState.loading());
    final result = await _loginUseCase(email, password);
    result.when(
      success: (token) => emit(LoginState.success(token)),
      failure: (failure) => emit(LoginState.error(failure.message)),
    );
  }

  Future<void> orgLogin(String email, String password) async {
    emit(const LoginState.loading());
    final result = await _orgLoginUseCase(email, password);
    result.when(
      success: (token) => emit(LoginState.success(token)),
      failure: (failure) => emit(LoginState.error(failure.message)),
    );
  }
}
