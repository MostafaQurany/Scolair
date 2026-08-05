import 'package:json_annotation/json_annotation.dart';

part 'otp_verify_response_data.g.dart';

@JsonSerializable()
class OtpVerifyTokenData {
  const OtpVerifyTokenData({required this.resetToken});

  factory OtpVerifyTokenData.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyTokenDataFromJson(json);

  @JsonKey(name: 'reset_token')
  final String resetToken;

  Map<String, dynamic> toJson() => _$OtpVerifyTokenDataToJson(this);
}

@JsonSerializable()
class OtpVerifyResponseData {
  const OtpVerifyResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory OtpVerifyResponseData.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyResponseDataFromJson(json);

  final String state;
  final String message;
  final OtpVerifyTokenData data;

  Map<String, dynamic> toJson() => _$OtpVerifyResponseDataToJson(this);
}
