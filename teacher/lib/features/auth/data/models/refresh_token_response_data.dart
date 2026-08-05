import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_response_data.g.dart';

@JsonSerializable()
class RefreshTokenData {
  const RefreshTokenData({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  factory RefreshTokenData.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenDataFromJson(json);

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(name: 'expires_in')
  final int expiresIn;

  Map<String, dynamic> toJson() => _$RefreshTokenDataToJson(this);
}

@JsonSerializable()
class RefreshTokenResponseData {
  const RefreshTokenResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory RefreshTokenResponseData.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseDataFromJson(json);

  final String state;
  final String message;
  final RefreshTokenData data;

  Map<String, dynamic> toJson() => _$RefreshTokenResponseDataToJson(this);
}
