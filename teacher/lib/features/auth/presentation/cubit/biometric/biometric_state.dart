import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometric_state.freezed.dart';

@freezed
sealed class BiometricState with _$BiometricState {
  const factory BiometricState.initial() = _Initial;
  const factory BiometricState.checking() = _Checking;
  const factory BiometricState.authenticated() = _Authenticated;
  const factory BiometricState.unavailable() = _Unavailable;
  const factory BiometricState.failed(String message) = _Failed;
}
