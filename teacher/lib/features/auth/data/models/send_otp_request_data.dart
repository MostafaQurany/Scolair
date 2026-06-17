import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request_data.g.dart';

@JsonSerializable()
class SendOtpRequestData {
  const SendOtpRequestData({required this.phone, required this.countryCode});

  final String phone;
  @JsonKey(name: 'country_code') final String countryCode;

  factory SendOtpRequestData.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$SendOtpRequestDataToJson(this);
}
