// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginTokenData _$LoginTokenDataFromJson(Map<String, dynamic> json) =>
    LoginTokenData(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      tokenType: json['tokenType'] as String,
      scope: json['scope'] as String,
      user: json['user'] == null
          ? null
          : LoginUserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginTokenDataToJson(LoginTokenData instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'tokenType': instance.tokenType,
      'scope': instance.scope,
      'user': instance.user,
    };

LoginResponseData _$LoginResponseDataFromJson(Map<String, dynamic> json) =>
    LoginResponseData(
      state: json['state'] as String,
      message: json['message'] as String,
      data: LoginTokenData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseDataToJson(LoginResponseData instance) =>
    <String, dynamic>{
      'state': instance.state,
      'message': instance.message,
      'data': instance.data,
    };
