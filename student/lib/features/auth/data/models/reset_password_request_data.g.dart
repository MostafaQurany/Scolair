// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequestData _$ResetPasswordRequestDataFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequestData(
  token: json['token'] as String,
  newPassword: json['new_password'] as String,
  confirmPassword: json['confirm_password'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestDataToJson(
  ResetPasswordRequestData instance,
) => <String, dynamic>{
  'token': instance.token,
  'new_password': instance.newPassword,
  'confirm_password': instance.confirmPassword,
};
