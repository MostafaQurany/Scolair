// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponseData _$UserProfileResponseDataFromJson(
  Map<String, dynamic> json,
) => UserProfileResponseData(
  id: json['id'] as String?,
  name: json['name'] as String?,
  username: json['username'] as String?,
  email: json['email'] as String?,
  fullName: json['full_name'] as String?,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  headline: json['headline'] as String?,
  bio: json['bio'] as String?,
  userImage: json['user_image'] as String?,
  profileImage: json['profile_image'] as String?,
  language: json['language'] as String?,
  roles:
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  designation: json['designation'] as String?,
  department: json['department'] as String?,
  subject: json['subject'] as String?,
  openTo: json['open_to'] as String?,
  linkedin: json['linkedin'] as String?,
  github: json['github'] as String?,
  twitter: json['twitter'] as String?,
);

Map<String, dynamic> _$UserProfileResponseDataToJson(
  UserProfileResponseData instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'email': instance.email,
  'full_name': instance.fullName,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'headline': instance.headline,
  'bio': instance.bio,
  'user_image': instance.userImage,
  'profile_image': instance.profileImage,
  'language': instance.language,
  'roles': instance.roles,
  'designation': instance.designation,
  'department': instance.department,
  'subject': instance.subject,
  'open_to': instance.openTo,
  'linkedin': instance.linkedin,
  'github': instance.github,
  'twitter': instance.twitter,
};
