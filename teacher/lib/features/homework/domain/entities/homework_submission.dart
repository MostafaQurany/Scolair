class HomeworkSubmissionItem {
  const HomeworkSubmissionItem({
    required this.name,
    required this.member,
    required this.status,
    required this.isLate,
    required this.autoMarks,
    required this.marks,
    this.feedback,
    this.submittedOn,
    this.studentName,
  });

  final String name;
  final String member;
  final String status;
  final bool isLate;
  final num autoMarks;
  final num marks;
  final String? feedback;
  final String? submittedOn;
  final String? studentName;

  String get displayStudentName => studentName?.isNotEmpty ?? false ? studentName! : member;
  
  num get totalMarks => autoMarks + marks;
}

class HomeworkSubmissionDetail {
  const HomeworkSubmissionDetail({
    required this.name,
    required this.homework,
    required this.member,
    required this.status,
    required this.isLate,
    required this.autoMarks,
    required this.marks,
    required this.questions,
    this.feedback,
    this.submittedOn,
    this.studentName,
  });

  final String name;
  final String homework;
  final String member;
  final String status;
  final bool isLate;
  final num autoMarks;
  final num marks;
  final String? feedback;
  final String? submittedOn;
  final String? studentName;
  final List<SubmissionQuestionDetail> questions;

  String get displayStudentName => studentName?.isNotEmpty ?? false ? studentName! : member;

  num get totalMarks => autoMarks + marks;
}

class SubmissionQuestionDetail {
  const SubmissionQuestionDetail({
    required this.question,
    required this.questionText,
    required this.type,
    required this.maxMarks,
    this.answer,
    this.isCorrect,
    this.marksAwarded,
    this.note,
  });

  final String question;
  final String questionText;
  final String type;
  final num maxMarks;
  final String? answer;
  final bool? isCorrect;
  final num? marksAwarded;
  final String? note;

  bool get isManualGraded => type.toLowerCase() != 'choices';
}
