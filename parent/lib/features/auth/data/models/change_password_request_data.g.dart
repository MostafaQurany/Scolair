// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequestData _$ChangePasswordRequestDataFromJson(
  Map<String, dynamic> json,
) => ChangePasswordRequestData(
  newPassword: json['new_password'] as String,
  oldPassword: json['old_password'] as String,
  logoutAllSessions: (json['logout_all_sessions'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ChangePasswordRequestDataToJson(
  ChangePasswordRequestData instance,
) => <String, dynamic>{
  'new_password': instance.newPassword,
  'old_password': instance.oldPassword,
  'logout_all_sessions': instance.logoutAllSessions,
};
