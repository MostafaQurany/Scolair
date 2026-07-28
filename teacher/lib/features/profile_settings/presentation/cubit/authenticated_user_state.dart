import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user_profile.dart';

part 'authenticated_user_state.freezed.dart';

@freezed
sealed class AuthenticatedUserState with _$AuthenticatedUserState {
  const factory AuthenticatedUserState.initial() = _Initial;
  const factory AuthenticatedUserState.loading() = _Loading;
  const factory AuthenticatedUserState.loaded(
    UserProfile profile, {
    @Default(false) bool isUpdating,
  }) = _Loaded;
  const factory AuthenticatedUserState.error(
    String message, {
    UserProfile? profile,
  }) = _Error;
}
