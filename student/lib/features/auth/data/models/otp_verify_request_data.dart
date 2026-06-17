import 'package:json_annotation/json_annotation.dart';

part 'otp_verify_request_data.g.dart';

@JsonSerializable()
class OtpVerifyRequestData {
  const OtpVerifyRequestData({required this.email, required this.otp});

  final String email;
  final String otp;

  factory OtpVerifyRequestData.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerifyRequestDataToJson(this);
}
