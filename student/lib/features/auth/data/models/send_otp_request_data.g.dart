// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_otp_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpRequestData _$SendOtpRequestDataFromJson(Map<String, dynamic> json) =>
    SendOtpRequestData(
      phone: json['phone'] as String,
      countryCode: json['country_code'] as String,
    );

Map<String, dynamic> _$SendOtpRequestDataToJson(SendOtpRequestData instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'country_code': instance.countryCode,
    };
