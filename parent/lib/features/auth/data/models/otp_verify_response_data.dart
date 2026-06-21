import 'package:json_annotation/json_annotation.dart';

part 'otp_verify_response_data.g.dart';

@JsonSerializable()
class OtpVerifyTokenData {
  const OtpVerifyTokenData({required this.resetToken});

  @JsonKey(name: 'reset_token')
  final String resetToken;

  factory OtpVerifyTokenData.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyTokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerifyTokenDataToJson(this);
}

@JsonSerializable()
class OtpVerifyResponseData {
  const OtpVerifyResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final OtpVerifyTokenData data;

  factory OtpVerifyResponseData.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerifyResponseDataToJson(this);
}
