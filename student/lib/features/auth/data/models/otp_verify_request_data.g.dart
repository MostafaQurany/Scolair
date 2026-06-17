// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerifyRequestData _$OtpVerifyRequestDataFromJson(
  Map<String, dynamic> json,
) => OtpVerifyRequestData(
  email: json['email'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$OtpVerifyRequestDataToJson(
  OtpVerifyRequestData instance,
) => <String, dynamic>{'email': instance.email, 'otp': instance.otp};
