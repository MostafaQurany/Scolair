// Data models for the Classes feature.
//
// These models represent teacher class data including
// schedule, curriculum, attendance, and performance.

/// Represents a single teacher class (e.g. MATH-10A).
class ClassModel {
  const ClassModel({
    required this.code,
    required this.subject,
    required this.description,
    required this.studentCount,
    required this.scheduleTime,
    required this.scheduleDays,
    required this.category,
    this.nextLesson,
    this.submissionStatus,
    this.urgentAlert,
    this.curriculum = const [],
    this.activities = const [],
    this.attendance,
    this.performance,
  });

  final String code;
  final String subject;
  final String description;
  final int studentCount;
  final String scheduleTime;
  final String scheduleDays;
  final String category;
  final String? nextLesson;
  final SubmissionStatus? submissionStatus;
  final String? urgentAlert;
  final List<CurriculumItem> curriculum;
  final List<ClassActivity> activities;
  final AttendanceData? attendance;
  final PerformanceData? performance;
}

/// Status of assignment submissions for a class.
class SubmissionStatus {
  const SubmissionStatus({
    required this.pendingCount,
    required this.isAllCaughtUp,
  });

  final int pendingCount;
  final bool isAllCaughtUp;

  String get displayText => isAllCaughtUp ? '' : '$pendingCount Pending Review';
}

/// Represents one curriculum item (lesson, quiz, problem set).
class CurriculumItem {
  const CurriculumItem({
    required this.title,
    this.subtitle,
    required this.status,
    required this.type,
    this.dueDate,
    this.itemNumber,
  });

  final String title;
  final String? subtitle;
  final CurriculumStatus status;
  final CurriculumType type;
  final String? dueDate;
  final String? itemNumber;
}

/// Completion status of a curriculum item.
enum CurriculumStatus { completed, current, upcoming, overdue }

/// Type of curriculum item.
enum CurriculumType { lesson, quiz, problemSet, chapter }

/// Represents a class activity entry.
class ClassActivity {
  const ClassActivity({
    required this.type,
    required this.title,
    required this.description,
    this.timestamp,
    this.actionLabel,
    this.badgeLabel,
    this.submittedCount,
    this.totalCount,
  });

  final ClassActivityType type;
  final String title;
  final String description;
  final String? timestamp;
  final String? actionLabel;
  final String? badgeLabel;
  final int? submittedCount;
  final int? totalCount;
}

/// Type of class activity.
enum ClassActivityType { announcement, grading }

/// Attendance data for a class.
class AttendanceData {
  const AttendanceData({
    required this.percentage,
    required this.presentToday,
    required this.absentToday,
  });

  final double percentage;
  final int presentToday;
  final int absentToday;
}

/// Performance metrics for a class.
class PerformanceData {
  const PerformanceData({
    required this.classAverage,
    required this.assignmentCompletion,
  });

  final double classAverage;
  final double assignmentCompletion;
}
