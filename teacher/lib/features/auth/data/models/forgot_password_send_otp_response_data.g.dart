// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_send_otp_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordSessionData _$ForgotPasswordSessionDataFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordSessionData(sessionId: json['session_id'] as String);

Map<String, dynamic> _$ForgotPasswordSessionDataToJson(
  ForgotPasswordSessionData instance,
) => <String, dynamic>{'session_id': instance.sessionId};

ForgotPasswordSendOtpResponseData _$ForgotPasswordSendOtpResponseDataFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordSendOtpResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: ForgotPasswordSessionData.fromJson(
    json['data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ForgotPasswordSendOtpResponseDataToJson(
  ForgotPasswordSendOtpResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};
