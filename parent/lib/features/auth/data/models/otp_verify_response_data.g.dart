// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerifyResponseData _$OtpVerifyResponseDataFromJson(
  Map<String, dynamic> json,
) => OtpVerifyResponseData(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
);

Map<String, dynamic> _$OtpVerifyResponseDataToJson(
  OtpVerifyResponseData instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
};
