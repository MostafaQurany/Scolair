import 'package:json_annotation/json_annotation.dart';

part 'register_request_data.g.dart';

@JsonSerializable()
class RegisterRequestData {
  const RegisterRequestData({
    required this.email,
    required this.fullName,
    required this.verifyTerms,
    required this.password,
    this.userCategory = '',
    this.userType = 'parent',
  });

  factory RegisterRequestData.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDataFromJson(json);

  final String email;

  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'verify_terms')
  final int verifyTerms;

  final String password;

  @JsonKey(name: 'user_category')
  final String userCategory;

  @JsonKey(name: 'user_type')
  final String userType;

  Map<String, dynamic> toJson() => _$RegisterRequestDataToJson(this);
}
