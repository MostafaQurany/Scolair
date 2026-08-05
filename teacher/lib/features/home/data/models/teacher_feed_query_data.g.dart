// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_feed_query_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherFeedQueryData _$TeacherFeedQueryDataFromJson(
  Map<String, dynamic> json,
) => TeacherFeedQueryData(
  page: (json['page'] as num).toInt(),
  pageSize: (json['page_size'] as num).toInt(),
  filterId: json['filter_id'] as String?,
);

Map<String, dynamic> _$TeacherFeedQueryDataToJson(
  TeacherFeedQueryData instance,
) => <String, dynamic>{
  'filter_id': instance.filterId,
  'page': instance.page,
  'page_size': instance.pageSize,
};
