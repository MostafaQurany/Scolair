// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      category: $enumDecode(
        _$NotificationCategoryEnumMap,
        json['category'],
        unknownValue: NotificationCategory.security,
      ),
      priority: $enumDecode(
        _$NotificationPriorityEnumMap,
        json['priority'],
        unknownValue: NotificationPriority.normal,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['is_read'] as bool? ?? false,
      isPinned: json['is_pinned'] as bool? ?? false,
      isArchived: json['is_archived'] as bool? ?? false,
      actionRequired: json['action_required'] as bool? ?? false,
      actionCompleted: json['action_completed'] as bool? ?? false,
      courseId: json['course_id'] as String?,
      courseName: json['course_name'] as String?,
      actionUrl: json['action_url'] as String?,
      relatedEntityId: json['related_entity_id'] as String?,
      studentId: json['student_id'] as String?,
      studentName: json['student_name'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'category': _$NotificationCategoryEnumMap[instance.category]!,
      'priority': _$NotificationPriorityEnumMap[instance.priority]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'is_read': instance.isRead,
      'is_pinned': instance.isPinned,
      'is_archived': instance.isArchived,
      'action_required': instance.actionRequired,
      'action_completed': instance.actionCompleted,
      'course_id': instance.courseId,
      'course_name': instance.courseName,
      'action_url': instance.actionUrl,
      'related_entity_id': instance.relatedEntityId,
      'student_id': instance.studentId,
      'student_name': instance.studentName,
    };

const _$NotificationCategoryEnumMap = {
  NotificationCategory.assignmentSubmission: 'assignmentSubmission',
  NotificationCategory.quizSubmission: 'quizSubmission',
  NotificationCategory.manualGradingRequired: 'manualGradingRequired',
  NotificationCategory.gradesPublished: 'gradesPublished',
  NotificationCategory.collaborationPost: 'collaborationPost',
  NotificationCategory.collaborationComment: 'collaborationComment',
  NotificationCategory.studyGroupActivity: 'studyGroupActivity',
  NotificationCategory.moderation: 'moderation',
  NotificationCategory.smartNotes: 'smartNotes',
  NotificationCategory.enrollment: 'enrollment',
  NotificationCategory.studentRisk: 'studentRisk',
  NotificationCategory.workloadCapacity: 'workloadCapacity',
  NotificationCategory.integrationSync: 'integrationSync',
  NotificationCategory.security: 'security',
};

const _$NotificationPriorityEnumMap = {
  NotificationPriority.urgent: 'urgent',
  NotificationPriority.high: 'high',
  NotificationPriority.normal: 'normal',
  NotificationPriority.low: 'low',
};
