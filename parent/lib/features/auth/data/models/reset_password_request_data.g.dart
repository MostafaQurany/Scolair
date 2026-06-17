// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequestData _$ResetPasswordRequestDataFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequestData(
  token: json['token'] as String,
  newPassword: json['newPassword'] as String,
  confirmPassword: json['confirmPassword'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestDataToJson(
  ResetPasswordRequestData instance,
) => <String, dynamic>{
  'token': instance.token,
  'newPassword': instance.newPassword,
  'confirmPassword': instance.confirmPassword,
};
