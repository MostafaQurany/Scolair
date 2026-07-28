class HomeworkDetailResponseData {
  const HomeworkDetailResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory HomeworkDetailResponseData.fromJson(Object? json) {
    final map = _map(json);
    return HomeworkDetailResponseData(
      state: _string(map['state']),
      message: _string(map['message']),
      data: HomeworkDetailData.fromJson(map['data']),
    );
  }

  final String state;
  final String message;
  final HomeworkDetailData data;
}

class HomeworkDetailData {
  const HomeworkDetailData({
    required this.name,
    required this.title,
    required this.instructions,
    required this.course,
    required this.dueDate,
    required this.maxMarks,
    required this.allowLateSubmission,
    required this.published,
    required this.questions,
    this.attachment,
    this.lesson,
    this.batch,
    this.owner,
    this.creation,
    this.modified,
  });

  factory HomeworkDetailData.fromJson(Object? json) {
    final map = _map(json);
    final rawQuestions = map['questions'];
    return HomeworkDetailData(
      name: _string(map['name']),
      title: _string(map['title']),
      instructions: _string(map['instructions']),
      attachment: _nullableString(map['attachment']),
      course: _string(map['course']),
      lesson: _nullableString(map['lesson']),
      batch: _nullableString(map['batch']),
      dueDate: _nullableString(map['due_date']),
      maxMarks: _integer(map['max_marks']),
      allowLateSubmission: _integer(map['allow_late_submission']),
      published: _integer(map['published']),
      owner: _nullableString(map['owner']),
      creation: _nullableString(map['creation']),
      modified: _nullableString(map['modified']),
      questions: rawQuestions is List
          ? rawQuestions.map(HomeworkQuestionItemData.fromJson).toList()
          : const [],
    );
  }

  final String name;
  final String title;
  final String instructions;
  final String? attachment;
  final String course;
  final String? lesson;
  final String? batch;
  final String? dueDate;
  final int maxMarks;
  final int allowLateSubmission;
  final int published;
  final String? owner;
  final String? creation;
  final String? modified;
  final List<HomeworkQuestionItemData> questions;
}

class HomeworkQuestionItemData {
  const HomeworkQuestionItemData({
    required this.name,
    required this.question,
    required this.type,
    required this.marks,
    this.multiple = 0,
    this.attachment,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.isCorrect1 = 0,
    this.isCorrect2 = 0,
    this.isCorrect3 = 0,
    this.isCorrect4 = 0,
    this.explanation1,
    this.explanation2,
    this.explanation3,
    this.explanation4,
  });

  factory HomeworkQuestionItemData.fromJson(Object? json) {
    final map = _map(json);
    return HomeworkQuestionItemData(
      name: _string(map['name']),
      question: _string(map['question']),
      type: _string(map['type']),
      marks: _integer(map['marks']),
      multiple: _integer(map['multiple']),
      attachment: _nullableString(map['attachment']),
      option1: _nullableString(map['option_1']),
      option2: _nullableString(map['option_2']),
      option3: _nullableString(map['option_3']),
      option4: _nullableString(map['option_4']),
      isCorrect1: _integer(map['is_correct_1']),
      isCorrect2: _integer(map['is_correct_2']),
      isCorrect3: _integer(map['is_correct_3']),
      isCorrect4: _integer(map['is_correct_4']),
      explanation1: _nullableString(map['explanation_1']),
      explanation2: _nullableString(map['explanation_2']),
      explanation3: _nullableString(map['explanation_3']),
      explanation4: _nullableString(map['explanation_4']),
    );
  }

  final String name;
  final String question;
  final String type;
  final int marks;
  final int multiple;
  final String? attachment;
  final String? option1;
  final String? option2;
  final String? option3;
  final String? option4;
  final int isCorrect1;
  final int isCorrect2;
  final int isCorrect3;
  final int isCorrect4;
  final String? explanation1;
  final String? explanation2;
  final String? explanation3;
  final String? explanation4;
}

Map<String, dynamic> _map(Object? value) => value is Map
    ? value.map((key, item) => MapEntry(key.toString(), item))
    : <String, dynamic>{};

String _string(Object? value) => value?.toString().trim() ?? '';

String? _nullableString(Object? value) {
  final parsed = _string(value);
  return parsed.isEmpty ? null : parsed;
}

int _integer(Object? value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(_string(value)) ?? 0;
}
