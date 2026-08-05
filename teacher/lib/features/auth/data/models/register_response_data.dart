import 'package:json_annotation/json_annotation.dart';

part 'register_response_data.g.dart';

@JsonSerializable()
class RegisterResponseData {
  const RegisterResponseData({required this.state, required this.message});

  factory RegisterResponseData.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDataFromJson(json);

  final String state;
  final String message;

  Map<String, dynamic> toJson() => _$RegisterResponseDataToJson(this);
}
