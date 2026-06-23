// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequestData _$ResetPasswordRequestDataFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequestData(
  resetToken: json['reset_token'] as String,
  newPassword: json['new_password'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestDataToJson(
  ResetPasswordRequestData instance,
) => <String, dynamic>{
  'reset_token': instance.resetToken,
  'new_password': instance.newPassword,
};
