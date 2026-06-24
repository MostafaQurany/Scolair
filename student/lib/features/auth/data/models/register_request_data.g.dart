// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestData _$RegisterRequestDataFromJson(Map<String, dynamic> json) =>
    RegisterRequestData(
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      verifyTerms: (json['verify_terms'] as num).toInt(),
      password: json['password'] as String,
      userCategory: json['user_category'] as String? ?? '',
      userType: json['user_type'] as String? ?? 'parent',
    );

Map<String, dynamic> _$RegisterRequestDataToJson(
  RegisterRequestData instance,
) => <String, dynamic>{
  'email': instance.email,
  'full_name': instance.fullName,
  'verify_terms': instance.verifyTerms,
  'password': instance.password,
  'user_category': instance.userCategory,
  'user_type': instance.userType,
};
