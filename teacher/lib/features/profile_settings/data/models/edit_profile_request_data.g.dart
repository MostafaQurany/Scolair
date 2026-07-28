// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileRequestData _$EditProfileRequestDataFromJson(
  Map<String, dynamic> json,
) => EditProfileRequestData(
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  headline: json['headline'] as String?,
  bio: json['bio'] as String?,
  openTo: json['open_to'] as String?,
  linkedin: json['linkedin'] as String?,
  github: json['github'] as String?,
  twitter: json['twitter'] as String?,
  language: json['language'] as String?,
);

Map<String, dynamic> _$EditProfileRequestDataToJson(
  EditProfileRequestData instance,
) => <String, dynamic>{
  'first_name': ?instance.firstName,
  'last_name': ?instance.lastName,
  'headline': ?instance.headline,
  'bio': ?instance.bio,
  'open_to': ?instance.openTo,
  'linkedin': ?instance.linkedin,
  'github': ?instance.github,
  'twitter': ?instance.twitter,
  'language': ?instance.language,
};
