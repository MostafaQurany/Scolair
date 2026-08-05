import 'package:json_annotation/json_annotation.dart';

part 'login_request_data.g.dart';

@JsonSerializable()
class LoginRequestData {
  const LoginRequestData({required this.username, required this.password});

  factory LoginRequestData.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDataFromJson(json);

  final String username;
  final String password;

  Map<String, dynamic> toJson() => _$LoginRequestDataToJson(this);
}
