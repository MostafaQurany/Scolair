import 'notification_category.dart';
import 'notification_priority.dart';

class NotificationEntity {

  NotificationEntity({
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
  final String id;
  final String title;
  final String message;
  final NotificationCategory category;
  final NotificationPriority priority;
  final DateTime createdAt;
  final bool isRead;
  final bool isPinned;
  final bool isArchived;
  final bool actionRequired;
  final bool actionCompleted;
  final String? courseId;
  final String? courseName;
  final String? actionUrl;
  final String? relatedEntityId;
  final String? studentId;
  final String? studentName;

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? message,
    NotificationCategory? category,
    NotificationPriority? priority,
    DateTime? createdAt,
    bool? isRead,
    bool? isPinned,
    bool? isArchived,
    bool? actionRequired,
    bool? actionCompleted,
    String? courseId,
    String? courseName,
    String? actionUrl,
    String? relatedEntityId,
    String? studentId,
    String? studentName,
  }) => NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      actionRequired: actionRequired ?? this.actionRequired,
      actionCompleted: actionCompleted ?? this.actionCompleted,
      courseId: courseId ?? this.courseId,
      courseName: courseName ?? this.courseName,
      actionUrl: actionUrl ?? this.actionUrl,
      relatedEntityId: relatedEntityId ?? this.relatedEntityId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
    );
}
