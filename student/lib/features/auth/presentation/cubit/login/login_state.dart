import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/auth_token.dart';

part 'login_state.freezed.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(AuthToken token) = _Success;
  const factory LoginState.error(String message) = _Error;
}
