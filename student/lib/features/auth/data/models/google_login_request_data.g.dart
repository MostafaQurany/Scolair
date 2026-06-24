// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_login_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleLoginRequestData _$GoogleLoginRequestDataFromJson(
  Map<String, dynamic> json,
) => GoogleLoginRequestData(
  idToken: json['id_token'] as String,
  role: json['role'] as String? ?? 'parent',
);

Map<String, dynamic> _$GoogleLoginRequestDataToJson(
  GoogleLoginRequestData instance,
) => <String, dynamic>{'id_token': instance.idToken, 'role': instance.role};
