import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_profile.dart';

part 'user_profile_response_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserProfileResponseData {
  const UserProfileResponseData({
    this.id,
    this.name,
    this.username,
    this.email,
    this.fullName,
    this.firstName,
    this.lastName,
    this.headline,
    this.bio,
    this.userImage,
    this.profileImage,
    this.language,
    this.roles = const [],
    this.designation,
    this.department,
    this.subject,
    this.openTo,
    this.linkedin,
    this.github,
    this.twitter,
  });

  final String? id;
  final String? name;
  final String? username;
  final String? email;
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final String? headline;
  final String? bio;
  final String? userImage;
  final String? profileImage;
  final String? language;
  final List<String> roles;
  final String? designation;
  final String? department;
  final String? subject;
  final String? openTo;
  final String? linkedin;
  final String? github;
  final String? twitter;

  UserProfile toDomain() => UserProfile(
    id: id,
    name: name,
    username: username,
    email: email,
    fullName: fullName,
    firstName: firstName,
    lastName: lastName,
    headline: headline,
    bio: bio,
    userImage: userImage,
    profileImage: profileImage,
    language: language,
    roles: roles,
    designation: designation,
    department: department,
    subject: subject,
    openTo: openTo,
    linkedin: linkedin,
    github: github,
    twitter: twitter,
  );

  factory UserProfileResponseData.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;
    return _$UserProfileResponseDataFromJson(data);
  }

  Map<String, dynamic> toJson() => _$UserProfileResponseDataToJson(this);
}
