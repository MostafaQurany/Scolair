import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request_data.g.dart';

@JsonSerializable()
class ForgotPasswordRequestData {
  const ForgotPasswordRequestData({required this.email});

  final String email;

  factory ForgotPasswordRequestData.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestDataToJson(this);
}
