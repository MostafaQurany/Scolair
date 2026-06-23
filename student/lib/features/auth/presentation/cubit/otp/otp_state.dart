import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/auth_token.dart';

part 'otp_state.freezed.dart';

@freezed
sealed class OtpState with _$OtpState {
  const factory OtpState.initial() = _Initial;
  const factory OtpState.loading() = _Loading;
  const factory OtpState.success(String token) = _Success;
  const factory OtpState.error(String message) = _Error;
}
