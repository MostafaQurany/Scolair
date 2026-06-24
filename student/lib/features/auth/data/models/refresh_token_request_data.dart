import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request_data.g.dart';

@JsonSerializable()
class RefreshTokenRequestData {
  const RefreshTokenRequestData({required this.refreshToken});

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  factory RefreshTokenRequestData.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestDataToJson(this);
}
