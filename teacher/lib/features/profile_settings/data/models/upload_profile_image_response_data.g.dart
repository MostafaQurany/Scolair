// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_profile_image_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadProfileImageResponseData _$UploadProfileImageResponseDataFromJson(
  Map<String, dynamic> json,
) => UploadProfileImageResponseData(
  fileUrl: json['file_url'] as String?,
  userImage: json['user_image'] as String?,
);

Map<String, dynamic> _$UploadProfileImageResponseDataToJson(
  UploadProfileImageResponseData instance,
) => <String, dynamic>{
  'file_url': instance.fileUrl,
  'user_image': instance.userImage,
};
