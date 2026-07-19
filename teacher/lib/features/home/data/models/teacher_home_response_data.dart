import 'package:json_annotation/json_annotation.dart';

part 'teacher_home_response_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TeacherProfileResponseData {
  const TeacherProfileResponseData({
    required this.id,
    required this.displayName,
    this.imageUrl,
  });

  final String id;
  final String displayName;
  final String? imageUrl;

  factory TeacherProfileResponseData.fromJson(Map<String, dynamic> json) =>
      _$TeacherProfileResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherProfileResponseDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TeacherFeedFilterResponseData {
  const TeacherFeedFilterResponseData({
    required this.id,
    required this.label,
    required this.type,
  });

  final String id;
  final String label;
  final String type;

  factory TeacherFeedFilterResponseData.fromJson(Map<String, dynamic> json) =>
      _$TeacherFeedFilterResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherFeedFilterResponseDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TeacherHomeResponseData {
  const TeacherHomeResponseData({
    required this.teacher,
    this.greetingActivityTitle,
    required this.organizationNoticeCount,
    required this.filters,
  });

  final TeacherProfileResponseData teacher;
  final String? greetingActivityTitle;
  final int organizationNoticeCount;
  final List<TeacherFeedFilterResponseData> filters;

  factory TeacherHomeResponseData.fromJson(Map<String, dynamic> json) =>
      _$TeacherHomeResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherHomeResponseDataToJson(this);
}
