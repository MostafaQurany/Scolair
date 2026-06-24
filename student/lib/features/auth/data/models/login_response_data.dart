import 'package:json_annotation/json_annotation.dart';

part 'login_response_data.g.dart';

@JsonSerializable()
class LoginTokenData {
  const LoginTokenData({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.tokenType,
    required this.scope,
  });

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(name: 'expires_in')
  final int expiresIn;

  @JsonKey(name: 'token_type')
  final String tokenType;

  final String scope;

  factory LoginTokenData.fromJson(Map<String, dynamic> json) =>
      _$LoginTokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginTokenDataToJson(this);
}

@JsonSerializable()
class LoginResponseData {
  const LoginResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final LoginTokenData data;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}
