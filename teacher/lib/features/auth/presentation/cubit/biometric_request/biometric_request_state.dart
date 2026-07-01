import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometric_request_state.freezed.dart';

@freezed
sealed class BiometricRequestState with _$BiometricRequestState {
  const factory BiometricRequestState.initial() = _Initial;
  const factory BiometricRequestState.loading() = _Loading;
  const factory BiometricRequestState.enabled() = _Enabled;
  const factory BiometricRequestState.dismissed() = _Dismissed;
  const factory BiometricRequestState.unavailable() = _Unavailable;
  const factory BiometricRequestState.failed(String message) = _Failed;
}
