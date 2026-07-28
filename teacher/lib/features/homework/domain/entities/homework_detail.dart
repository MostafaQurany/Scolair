class HomeworkDetail {
  const HomeworkDetail({
    required this.name,
    required this.title,
    required this.instructions,
    required this.course,
    required this.maxMarks,
    required this.allowLateSubmission,
    required this.isPublished,
    required this.questions,
    this.attachment,
    this.lesson,
    this.batch,
    this.dueDate,
    this.rawDueDate,
    this.owner,
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
  final String? owner;
  final List<HomeworkQuestionItem> questions;

  HomeworkDetail copyWith({
    String? title,
    String? instructions,
    String? attachment,
    String? lesson,
    String? batch,
    DateTime? dueDate,
    String? rawDueDate,
    int? maxMarks,
    bool? allowLateSubmission,
    bool? isPublished,
    List<HomeworkQuestionItem>? questions,
  }) {
    return HomeworkDetail(
      name: name,
      title: title ?? this.title,
      instructions: instructions ?? this.instructions,
      course: course,
      attachment: attachment ?? this.attachment,
      lesson: lesson ?? this.lesson,
      batch: batch ?? this.batch,
      dueDate: dueDate ?? this.dueDate,
      rawDueDate: rawDueDate ?? this.rawDueDate,
      maxMarks: maxMarks ?? this.maxMarks,
      allowLateSubmission: allowLateSubmission ?? this.allowLateSubmission,
      isPublished: isPublished ?? this.isPublished,
      owner: owner,
      questions: questions ?? this.questions,
    );
  }
}

class HomeworkQuestionItem {
  const HomeworkQuestionItem({
    required this.name,
    required this.question,
    required this.type,
    required this.marks,
    required this.multiple,
    this.attachment,
    this.options = const [],
    this.correctOptions = const [],
    this.explanations = const [],
  });

  final String name;
  final String question;
  final String type;
  final int marks;
  final bool multiple;
  final String? attachment;
  final List<String> options;
  final List<bool> correctOptions;
  final List<String?> explanations;
}
