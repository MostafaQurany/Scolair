import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_data.g.dart';

@JsonSerializable()
class ResetPasswordRequestData {
  const ResetPasswordRequestData({
    required this.token,
    required this.newPassword,
    required this.confirmPassword,
  });

  final String token;
  final String newPassword;
  final String confirmPassword;

  factory ResetPasswordRequestData.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestDataToJson(this);
}
