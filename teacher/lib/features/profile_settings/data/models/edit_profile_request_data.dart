import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class EditProfileRequestData {
  const EditProfileRequestData({
    this.firstName,
    this.lastName,
    this.headline,
    this.bio,
    this.openTo,
    this.linkedin,
    this.github,
    this.twitter,
    this.language,
  });

  final String? firstName;
  final String? lastName;
  final String? headline;
  final String? bio;
  final String? openTo;
  final String? linkedin;
  final String? github;
  final String? twitter;
  final String? language;

  factory EditProfileRequestData.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestDataToJson(this);
}
