import 'package:json_annotation/json_annotation.dart';

part 'google_login_request_data.g.dart';

@JsonSerializable()
class GoogleLoginRequestData {
  const GoogleLoginRequestData({required this.idToken, this.role = 'teacher'});

  factory GoogleLoginRequestData.fromJson(Map<String, dynamic> json) =>
      _$GoogleLoginRequestDataFromJson(json);

  @JsonKey(name: 'id_token')
  final String idToken;

  final String role;

  Map<String, dynamic> toJson() => _$GoogleLoginRequestDataToJson(this);
}
