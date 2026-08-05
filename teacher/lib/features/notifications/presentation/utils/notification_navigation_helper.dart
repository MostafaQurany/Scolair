import 'package:flutter/material.dart';
import '../../../../core/constants/app_route_names.dart';
import '../../../../core/navigation/navigation_service.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../domain/entities/notification_category.dart';
import '../../domain/entities/notification_entity.dart';
import '../../../courses/presentation/screens/course_students_screen.dart'; // For CourseStudentsScreenArgs

class NotificationNavigationHelper {
  NotificationNavigationHelper._();

  static void navigateFromNotification(BuildContext context, NotificationEntity notification) {
    final navigator = getIt<NavigationService>();
    final relatedId = notification.relatedEntityId;
    final courseId = notification.courseId;
    final courseName = notification.courseName;

    switch (notification.category) {
      case NotificationCategory.assignmentSubmission:
      case NotificationCategory.manualGradingRequired:
        if (relatedId != null) {
          navigator.navigateTo(
            AppRouteNames.homeworkSubmissionDetails,
            arguments: relatedId,
          );
        }
        break;
      
      case NotificationCategory.quizSubmission:
        if (relatedId != null) {
          // If a quiz submission screen exists we could go there. For now, quizDetails.
          navigator.navigateTo(
            AppRouteNames.quizDetails,
            arguments: relatedId,
          );
        }
        break;

      case NotificationCategory.enrollment:
      case NotificationCategory.studentRisk:
        if (courseId != null) {
          navigator.navigateTo(
            AppRouteNames.courseStudents,
            arguments: CourseStudentsScreenArgs(
              courseName: courseId,
              courseTitle: courseName ?? 'Course',
            ),
          );
        }
        break;

      case NotificationCategory.collaborationPost:
      case NotificationCategory.collaborationComment:
        if (relatedId != null) {
          navigator.navigateTo(
            AppRouteNames.wallPostDetails,
            arguments: relatedId,
          );
        }
        break;

      case NotificationCategory.gradesPublished:
      case NotificationCategory.smartNotes:
        if (courseId != null) {
          navigator.navigateTo(
            AppRouteNames.courseDetails,
            arguments: courseId,
          );
        }
        break;

      case NotificationCategory.security:
        navigator.navigateTo(AppRouteNames.securitySettings);
        break;

      case NotificationCategory.workloadCapacity:
      case NotificationCategory.integrationSync:
      case NotificationCategory.moderation:
      case NotificationCategory.studyGroupActivity:
        // Handle other categories, or navigate to a default screen
        break;
    }
  }
}
