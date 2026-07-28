class GetSubmissionsResponseData {
  const GetSubmissionsResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory GetSubmissionsResponseData.fromJson(Object? json) {
    final map = _map(json);
    return GetSubmissionsResponseData(
      state: _string(map['state']),
      message: _string(map['message']),
      data: SubmissionsPageData.fromJson(map['data']),
    );
  }

  final String state;
  final String message;
  final SubmissionsPageData data;
}

class SubmissionsPageData {
  const SubmissionsPageData({
    required this.items,
    required this.total,
    required this.start,
    required this.pageSize,
    required this.hasNextPage,
  });

  factory SubmissionsPageData.fromJson(Object? json) {
    final map = _map(json);
    final rawItems = map['items'];
    return SubmissionsPageData(
      items: rawItems is List
          ? rawItems.map(SubmissionItemData.fromJson).toList()
          : const [],
      total: _integer(map['total']),
      start: _integer(map['start']),
      pageSize: _integer(map['page_size']),
      hasNextPage: _boolean(map['has_next_page']),
    );
  }

  final List<SubmissionItemData> items;
  final int total;
  final int start;
  final int pageSize;
  final bool hasNextPage;
}

class SubmissionItemData {
  const SubmissionItemData({
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

  factory SubmissionItemData.fromJson(Object? json) {
    final map = _map(json);
    return SubmissionItemData(
      name: _string(map['name']),
      member: _string(map['member']),
      status: _string(map['status']),
      isLate: _integer(map['is_late']),
      autoMarks: _num(map['auto_marks']),
      marks: _num(map['marks']),
      feedback: _nullableString(map['feedback']),
      submittedOn: _nullableString(map['submitted_on']),
      studentName: _nullableString(map['student_name']) ?? _nullableString(map['member_name']),
    );
  }

  final String name;
  final String member;
  final String status;
  final int isLate;
  final num autoMarks;
  final num marks;
  final String? feedback;
  final String? submittedOn;
  final String? studentName;
}

class GetSubmissionDetailResponseData {
  const GetSubmissionDetailResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory GetSubmissionDetailResponseData.fromJson(Object? json) {
    final map = _map(json);
    return GetSubmissionDetailResponseData(
      state: _string(map['state']),
      message: _string(map['message']),
      data: SubmissionDetailData.fromJson(map['data']),
    );
  }

  final String state;
  final String message;
  final SubmissionDetailData data;
}

class SubmissionDetailData {
  const SubmissionDetailData({
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

  factory SubmissionDetailData.fromJson(Object? json) {
    final map = _map(json);
    final rawQuestions = map['questions'];
    return SubmissionDetailData(
      name: _string(map['name']),
      homework: _string(map['homework']),
      member: _string(map['member']),
      status: _string(map['status']),
      isLate: _integer(map['is_late']),
      autoMarks: _num(map['auto_marks']),
      marks: _num(map['marks']),
      feedback: _nullableString(map['feedback']),
      submittedOn: _nullableString(map['submitted_on']),
      studentName: _nullableString(map['student_name']) ?? _nullableString(map['member_name']),
      questions: rawQuestions is List
          ? rawQuestions.map(SubmissionQuestionItemData.fromJson).toList()
          : const [],
    );
  }

  final String name;
  final String homework;
  final String member;
  final String status;
  final int isLate;
  final num autoMarks;
  final num marks;
  final String? feedback;
  final String? submittedOn;
  final String? studentName;
  final List<SubmissionQuestionItemData> questions;
}

class SubmissionQuestionItemData {
  const SubmissionQuestionItemData({
    required this.question,
    required this.questionText,
    required this.type,
    required this.maxMarks,
    this.answer,
    this.isCorrect,
    this.marksAwarded,
    this.note,
  });

  factory SubmissionQuestionItemData.fromJson(Object? json) {
    final map = _map(json);
    return SubmissionQuestionItemData(
      question: _string(map['question']),
      questionText: _string(map['question_text']),
      type: _string(map['type']),
      maxMarks: _num(map['max_marks']),
      answer: _nullableString(map['answer']),
      isCorrect: _nullableInt(map['is_correct']),
      marksAwarded: _nullableNum(map['marks_awarded']),
      note: _nullableString(map['note']),
    );
  }

  final String question;
  final String questionText;
  final String type;
  final num maxMarks;
  final String? answer;
  final int? isCorrect;
  final num? marksAwarded;
  final String? note;
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

int? _nullableInt(Object? value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  final parsed = int.tryParse(_string(value));
  return parsed;
}

num _num(Object? value) {
  if (value is num) return value;
  return num.tryParse(_string(value)) ?? 0;
}

num? _nullableNum(Object? value) {
  if (value == null) return null;
  if (value is num) return value;
  return num.tryParse(_string(value));
}

bool _boolean(Object? value) {
  if (value is bool) return value;
  return _integer(value) == 1;
}
