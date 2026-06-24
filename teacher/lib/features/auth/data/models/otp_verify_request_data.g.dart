// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerifyRequestData _$OtpVerifyRequestDataFromJson(
  Map<String, dynamic> json,
) => OtpVerifyRequestData(
  sessionId: json['session_id'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$OtpVerifyRequestDataToJson(
  OtpVerifyRequestData instance,
) => <String, dynamic>{'session_id': instance.sessionId, 'otp': instance.otp};
