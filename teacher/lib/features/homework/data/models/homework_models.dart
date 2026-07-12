enum HomeworkTargetType { examQuiz, lesson }

enum HomeworkStatus { published, draft, scheduled }

class HomeworkModel {
  const HomeworkModel({
    required this.id,
    required this.title,
    required this.category,
    required this.subject,
    required this.fileName,
    required this.targetType,
    required this.targetName,
    required this.dueDateTime,
    required this.status,
    required this.totalStudents,
    required this.submittedCount,
  });

  final String id;
  final String title;
  final String category;
  final String subject;
  final String fileName;
  final HomeworkTargetType targetType;
  final String targetName;
  final DateTime dueDateTime;
  final HomeworkStatus status;
  final int totalStudents;
  final int submittedCount;

  HomeworkModel copyWith({
    String? title,
    String? category,
    String? subject,
    String? fileName,
    HomeworkTargetType? targetType,
    String? targetName,
    DateTime? dueDateTime,
    HomeworkStatus? status,
    int? totalStudents,
    int? submittedCount,
  }) => HomeworkModel(
    id: id,
    title: title ?? this.title,
    category: category ?? this.category,
    subject: subject ?? this.subject,
    fileName: fileName ?? this.fileName,
    targetType: targetType ?? this.targetType,
    targetName: targetName ?? this.targetName,
    dueDateTime: dueDateTime ?? this.dueDateTime,
    status: status ?? this.status,
    totalStudents: totalStudents ?? this.totalStudents,
    submittedCount: submittedCount ?? this.submittedCount,
  );
}
