// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerifyResponseData _$OtpVerifyResponseDataFromJson(
  Map<String, dynamic> json,
) => OtpVerifyResponseData(
  accessToken: json['access_token'] as String,
  refreshToken: json['refresh_token'] as String,
);

Map<String, dynamic> _$OtpVerifyResponseDataToJson(
  OtpVerifyResponseData instance,
) => <String, dynamic>{
  'access_token': instance.accessToken,
  'refresh_token': instance.refreshToken,
};
