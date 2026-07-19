import 'package:json_annotation/json_annotation.dart';

part 'teacher_feed_query_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TeacherFeedQueryData {
  const TeacherFeedQueryData({
    this.filterId,
    required this.page,
    required this.pageSize,
  });

  final String? filterId;
  final int page;
  final int pageSize;

  factory TeacherFeedQueryData.fromJson(Map<String, dynamic> json) =>
      _$TeacherFeedQueryDataFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherFeedQueryDataToJson(this);
}
