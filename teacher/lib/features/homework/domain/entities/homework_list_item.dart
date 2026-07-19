class HomeworkListItem {
  const HomeworkListItem({
    required this.name,
    required this.title,
    required this.instructions,
    required this.course,
    required this.maxMarks,
    required this.allowLateSubmission,
    required this.isPublished,
    this.attachment,
    this.lesson,
    this.batch,
    this.dueDate,
    this.rawDueDate,
  });

  final String name;
  final String title;
  final String instructions;
  final String? attachment;
  final String course;
  final String? lesson;
  final String? batch;
  final DateTime? dueDate;
  final String? rawDueDate;
  final int maxMarks;
  final bool allowLateSubmission;
  final bool isPublished;
}
