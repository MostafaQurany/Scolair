import 'package:json_annotation/json_annotation.dart';

part 'logout_request_data.g.dart';

@JsonSerializable()
class LogoutRequestData {
  const LogoutRequestData({required this.token});

  final String token;

  factory LogoutRequestData.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutRequestDataToJson(this);
}
