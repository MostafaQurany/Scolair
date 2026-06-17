import 'package:json_annotation/json_annotation.dart';

part 'login_request_data.g.dart';

@JsonSerializable()
class LoginRequestData {
  const LoginRequestData({required this.email, required this.password});

  final String email;
  final String password;

  factory LoginRequestData.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestDataToJson(this);
}
