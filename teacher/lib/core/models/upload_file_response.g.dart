// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_file_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadFileMessage _$UploadFileMessageFromJson(Map<String, dynamic> json) =>
    UploadFileMessage(
      fileUrl: _stringFromJson(json['file_url']),
      name: _nullableStringFromJson(json['name']),
    );

Map<String, dynamic> _$UploadFileMessageToJson(UploadFileMessage instance) =>
    <String, dynamic>{'file_url': instance.fileUrl, 'name': instance.name};

UploadFileResponseData _$UploadFileResponseDataFromJson(
  Map<String, dynamic> json,
) => UploadFileResponseData(
  message: _uploadFileMessageFromJson(json['message']),
);

Map<String, dynamic> _$UploadFileResponseDataToJson(
  UploadFileResponseData instance,
) => <String, dynamic>{'message': instance.message};
