import 'package:json_annotation/json_annotation.dart';

part 'otp_verify_response_data.g.dart';

@JsonSerializable()
class OtpVerifyResponseData {
  const OtpVerifyResponseData({
    required this.accessToken,
    required this.refreshToken,
  });

  @JsonKey(name: 'access_token') final String accessToken;
  @JsonKey(name: 'refresh_token') final String refreshToken;

  factory OtpVerifyResponseData.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerifyResponseDataToJson(this);
}
