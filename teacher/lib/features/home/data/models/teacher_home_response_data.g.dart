// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_home_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherProfileResponseData _$TeacherProfileResponseDataFromJson(
  Map<String, dynamic> json,
) => TeacherProfileResponseData(
  id: json['id'] as String,
  displayName: json['display_name'] as String,
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$TeacherProfileResponseDataToJson(
  TeacherProfileResponseData instance,
) => <String, dynamic>{
  'id': instance.id,
  'display_name': instance.displayName,
  'image_url': instance.imageUrl,
};

TeacherFeedFilterResponseData _$TeacherFeedFilterResponseDataFromJson(
  Map<String, dynamic> json,
) => TeacherFeedFilterResponseData(
  id: json['id'] as String,
  label: json['label'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$TeacherFeedFilterResponseDataToJson(
  TeacherFeedFilterResponseData instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'type': instance.type,
};

TeacherHomeResponseData _$TeacherHomeResponseDataFromJson(
  Map<String, dynamic> json,
) => TeacherHomeResponseData(
  teacher: TeacherProfileResponseData.fromJson(
    json['teacher'] as Map<String, dynamic>,
  ),
  organizationNoticeCount: (json['organization_notice_count'] as num).toInt(),
  filters: (json['filters'] as List<dynamic>)
      .map(
        (e) =>
            TeacherFeedFilterResponseData.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  greetingActivityTitle: json['greeting_activity_title'] as String?,
);

Map<String, dynamic> _$TeacherHomeResponseDataToJson(
  TeacherHomeResponseData instance,
) => <String, dynamic>{
  'teacher': instance.teacher,
  'greeting_activity_title': instance.greetingActivityTitle,
  'organization_notice_count': instance.organizationNoticeCount,
  'filters': instance.filters,
};
