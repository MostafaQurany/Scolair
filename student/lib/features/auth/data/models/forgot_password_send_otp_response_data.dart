import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_send_otp_response_data.g.dart';

@JsonSerializable()
class ForgotPasswordSessionData {
  const ForgotPasswordSessionData({required this.sessionId});

  @JsonKey(name: 'session_id')
  final String sessionId;

  factory ForgotPasswordSessionData.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordSessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordSessionDataToJson(this);
}

@JsonSerializable()
class ForgotPasswordSendOtpResponseData {
  const ForgotPasswordSendOtpResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final ForgotPasswordSessionData data;

  factory ForgotPasswordSendOtpResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$ForgotPasswordSendOtpResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ForgotPasswordSendOtpResponseDataToJson(this);
}
