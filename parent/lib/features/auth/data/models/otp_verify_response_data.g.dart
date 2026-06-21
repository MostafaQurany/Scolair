// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerifyTokenData _$OtpVerifyTokenDataFromJson(Map<String, dynamic> json) =>
    OtpVerifyTokenData(resetToken: json['reset_token'] as String);

Map<String, dynamic> _$OtpVerifyTokenDataToJson(OtpVerifyTokenData instance) =>
    <String, dynamic>{'reset_token': instance.resetToken};

OtpVerifyResponseData _$OtpVerifyResponseDataFromJson(
  Map<String, dynamic> json,
) => OtpVerifyResponseData(
  state: json['state'] as String,
  message: json['message'] as String,
  data: OtpVerifyTokenData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OtpVerifyResponseDataToJson(
  OtpVerifyResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};
