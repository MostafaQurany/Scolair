class CreateHomeworkRequestData {
  const CreateHomeworkRequestData({
    required this.title,
    required this.dueDate,
    this.course,
    this.lesson,
    this.batch,
    this.instructions,
    this.allowLateSubmission = 0,
    this.published = 0,
    this.questions = const [],
  });

  final String title;
  final String dueDate;
  final String? course;
  final String? lesson;
  final String? batch;
  final String? instructions;
  final int allowLateSubmission;
  final int published;
  final List<CreateHomeworkQuestionItemData> questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'title': title,
      'due_date': dueDate,
      'allow_late_submission': allowLateSubmission,
      'published': published,
    };
    if (course != null && course!.isNotEmpty) {
      map['course'] = course;
    }
    if (lesson != null && lesson!.isNotEmpty) {
      map['lesson'] = lesson;
    }
    if (batch != null && batch!.isNotEmpty) {
      map['batch'] = batch;
    }
    if (instructions != null && instructions!.isNotEmpty) {
      map['instructions'] = instructions;
    }
    if (questions.isNotEmpty) {
      map['questions'] = questions.map((e) => e.toJson()).toList();
    }
    return map;
  }
}

class CreateHomeworkQuestionItemData {
  const CreateHomeworkQuestionItemData({
    required this.marks,
    this.questionName,
    this.inlineQuestion,
  });

  final int marks;
  final String? questionName;
  final Map<String, dynamic>? inlineQuestion;

  String get displayName => questionName ?? inlineQuestion?['title']?.toString() ?? 'Question';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'marks': marks};
    if (questionName != null && questionName!.isNotEmpty) {
      map['question'] = questionName;
    } else if (inlineQuestion != null) {
      map['inline'] = inlineQuestion;
    }
    return map;
  }
}

class UpdateHomeworkRequestData {
  const UpdateHomeworkRequestData({
    required this.homeworkName,
    this.title,
    this.dueDate,
    this.course,
    this.lesson,
    this.batch,
    this.instructions,
    this.allowLateSubmission,
    this.published,
    this.attachment,
    this.questions,
  });

  final String homeworkName;
  final String? title;
  final String? dueDate;
  final String? course;
  final String? lesson;
  final String? batch;
  final String? instructions;
  final int? allowLateSubmission;
  final int? published;
  final String? attachment;
  final List<Map<String, dynamic>>? questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'homework': homeworkName};
    if (title != null) map['title'] = title;
    if (dueDate != null) map['due_date'] = dueDate;
    if (course != null) map['course'] = course;
    if (lesson != null) map['lesson'] = lesson;
    if (batch != null) map['batch'] = batch;
    if (instructions != null) map['instructions'] = instructions;
    if (allowLateSubmission != null) {
      map['allow_late_submission'] = allowLateSubmission;
    }
    if (published != null) map['published'] = published;
    if (attachment != null) map['attachment'] = attachment;
    if (questions != null) map['questions'] = questions;
    return map;
  }
}

class AddHomeworkQuestionRequestData {
  const AddHomeworkQuestionRequestData({
    required this.homeworkName,
    required this.questionName,
    required this.marks,
  });

  final String homeworkName;
  final String questionName;
  final int marks;

  Map<String, dynamic> toJson() => {
    'homework': homeworkName,
    'question': questionName,
    'marks': marks,
  };
}

class GradeSubmissionRequestData {
  const GradeSubmissionRequestData({
    required this.submissionName,
    required this.questionMarks,
    this.feedback,
  });

  final String submissionName;
  final Map<String, GradeQuestionMarkItem> questionMarks;
  final String? feedback;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'submission': submissionName,
      'question_marks': questionMarks.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
    if (feedback != null && feedback!.isNotEmpty) {
      map['feedback'] = feedback;
    }
    return map;
  }
}

class GradeQuestionMarkItem {
  const GradeQuestionMarkItem({required this.marks, this.note});

  final num marks;
  final String? note;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'marks': marks};
    if (note != null && note!.isNotEmpty) {
      map['note'] = note;
    }
    return map;
  }
}
