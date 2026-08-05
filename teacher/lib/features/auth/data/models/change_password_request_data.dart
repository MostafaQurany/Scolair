import 'package:json_annotation/json_annotation.dart';

part 'change_password_request_data.g.dart';

@JsonSerializable()
class ChangePasswordRequestData {
  const ChangePasswordRequestData({
    required this.newPassword,
    required this.oldPassword,
    this.logoutAllSessions = 0,
  });

  factory ChangePasswordRequestData.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestDataFromJson(json);

  @JsonKey(name: 'new_password')
  final String newPassword;

  @JsonKey(name: 'old_password')
  final String oldPassword;

  @JsonKey(name: 'logout_all_sessions')
  final int logoutAllSessions;

  Map<String, dynamic> toJson() => _$ChangePasswordRequestDataToJson(this);
}
