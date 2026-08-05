import 'package:json_annotation/json_annotation.dart';

part 'send_otp_request_data.g.dart';

@JsonSerializable()
class SendOtpRequestData {
  const SendOtpRequestData({required this.phone, required this.countryCode});

  factory SendOtpRequestData.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestDataFromJson(json);

  final String phone;
  @JsonKey(name: 'country_code')
  final String countryCode;

  Map<String, dynamic> toJson() => _$SendOtpRequestDataToJson(this);
}
