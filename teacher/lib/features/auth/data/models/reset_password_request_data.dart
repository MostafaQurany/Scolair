import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_data.g.dart';

@JsonSerializable()
class ResetPasswordRequestData {
  const ResetPasswordRequestData({
    required this.resetToken,
    required this.newPassword,
  });

  factory ResetPasswordRequestData.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestDataFromJson(json);

  @JsonKey(name: 'reset_token')
  final String resetToken;

  @JsonKey(name: 'new_password')
  final String newPassword;

  Map<String, dynamic> toJson() => _$ResetPasswordRequestDataToJson(this);
}
