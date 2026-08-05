import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/notification_category.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/notification_priority.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.category,
    required this.priority,
    required this.createdAt,
    required this.isRead,
    required this.isPinned,
    required this.isArchived,
    required this.actionRequired,
    required this.actionCompleted,
    this.courseId,
    this.courseName,
    this.actionUrl,
    this.relatedEntityId,
    this.studentId,
    this.studentName,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  final String id;
  final String title;
  final String message;
  
  @JsonKey(unknownEnumValue: NotificationCategory.security)
  final NotificationCategory category;
  
  @JsonKey(unknownEnumValue: NotificationPriority.normal)
  final NotificationPriority priority;
  
  final DateTime createdAt;
  
  @JsonKey(name: 'is_read', defaultValue: false)
  final bool isRead;
  
  @JsonKey(name: 'is_pinned', defaultValue: false)
  final bool isPinned;
  
  @JsonKey(name: 'is_archived', defaultValue: false)
  final bool isArchived;
  
  @JsonKey(name: 'action_required', defaultValue: false)
  final bool actionRequired;
  
  @JsonKey(name: 'action_completed', defaultValue: false)
  final bool actionCompleted;
  
  @JsonKey(name: 'course_id')
  final String? courseId;
  
  @JsonKey(name: 'course_name')
  final String? courseName;
  
  @JsonKey(name: 'action_url')
  final String? actionUrl;
  
  @JsonKey(name: 'related_entity_id')
  final String? relatedEntityId;
  
  @JsonKey(name: 'student_id')
  final String? studentId;
  
  @JsonKey(name: 'student_name')
  final String? studentName;

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  NotificationEntity toEntity() => NotificationEntity(
      id: id,
      title: title,
      message: message,
      category: category,
      priority: priority,
      createdAt: createdAt,
      isRead: isRead,
      isPinned: isPinned,
      isArchived: isArchived,
      actionRequired: actionRequired,
      actionCompleted: actionCompleted,
      courseId: courseId,
      courseName: courseName,
      actionUrl: actionUrl,
      relatedEntityId: relatedEntityId,
      studentId: studentId,
      studentName: studentName,
    );
}
