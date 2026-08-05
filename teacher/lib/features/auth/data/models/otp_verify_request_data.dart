import 'package:json_annotation/json_annotation.dart';

part 'otp_verify_request_data.g.dart';

@JsonSerializable()
class OtpVerifyRequestData {
  const OtpVerifyRequestData({required this.sessionId, required this.otp});

  factory OtpVerifyRequestData.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyRequestDataFromJson(json);

  @JsonKey(name: 'session_id')
  final String sessionId;

  final String otp;

  Map<String, dynamic> toJson() => _$OtpVerifyRequestDataToJson(this);
}
