import 'package:json_annotation/json_annotation.dart';

part 'upload_file_response.g.dart';

@JsonSerializable()
class UploadFileMessage {
  const UploadFileMessage({required this.fileUrl, this.name});

  factory UploadFileMessage.fromJson(Map<String, dynamic> json) =>
      _$UploadFileMessageFromJson(json);

  @JsonKey(name: 'file_url', fromJson: _stringFromJson)
  final String fileUrl;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? name;

  Map<String, dynamic> toJson() => _$UploadFileMessageToJson(this);
}

@JsonSerializable()
class UploadFileResponseData {
  const UploadFileResponseData({required this.message});

  factory UploadFileResponseData.fromJson(Map<String, dynamic> json) =>
      _$UploadFileResponseDataFromJson(json);

  @JsonKey(fromJson: _uploadFileMessageFromJson)
  final UploadFileMessage message;

  Map<String, dynamic> toJson() => _$UploadFileResponseDataToJson(this);
}

// --- Safe JSON converters for Frappe dynamic/null responses ---

String _stringFromJson(Object? value) {
  if (value is String) return value;
  if (value != null) return value.toString();
  return '';
}

String? _nullableStringFromJson(Object? value) {
  if (value == null) return null;
  if (value is String) return value.isEmpty ? null : value;
  return value.toString();
}

Map<String, dynamic> _asStringMap(Object? json) {
  if (json is Map) {
    return json.cast<String, dynamic>();
  }
  return {};
}

UploadFileMessage _uploadFileMessageFromJson(Object? json) =>
    UploadFileMessage.fromJson(_asStringMap(json));
