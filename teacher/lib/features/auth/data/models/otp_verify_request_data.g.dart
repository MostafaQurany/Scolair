// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verify_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerifyRequestData _$OtpVerifyRequestDataFromJson(
  Map<String, dynamic> json,
) => OtpVerifyRequestData(
  identifier: json['identifier'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$OtpVerifyRequestDataToJson(
  OtpVerifyRequestData instance,
) => <String, dynamic>{'identifier': instance.identifier, 'otp': instance.otp};
