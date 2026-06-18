import 'package:json_annotation/json_annotation.dart';

part 'login_response_data.g.dart';

@JsonSerializable()
class LoginResponseData {
  const LoginResponseData({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}
