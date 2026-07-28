import 'package:json_annotation/json_annotation.dart';

part 'upload_profile_image_response_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UploadProfileImageResponseData {
  const UploadProfileImageResponseData({this.fileUrl, this.userImage});

  final String? fileUrl;
  final String? userImage;

  factory UploadProfileImageResponseData.fromJson(Map<String, dynamic> json) {
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;
    return _$UploadProfileImageResponseDataFromJson(data);
  }

  Map<String, dynamic> toJson() => _$UploadProfileImageResponseDataToJson(this);
}
