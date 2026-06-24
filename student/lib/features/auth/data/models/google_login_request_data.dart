import 'package:json_annotation/json_annotation.dart';

part 'google_login_request_data.g.dart';

@JsonSerializable()
class GoogleLoginRequestData {
  const GoogleLoginRequestData({required this.idToken, this.role = 'student'});

  @JsonKey(name: 'id_token')
  final String idToken;

  final String role;

  factory GoogleLoginRequestData.fromJson(Map<String, dynamic> json) =>
      _$GoogleLoginRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleLoginRequestDataToJson(this);
}
