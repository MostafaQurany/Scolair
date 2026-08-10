import 'package:json_annotation/json_annotation.dart';

part 'quiz_submission_models.g.dart';

// --- Safe JSON Converters ---

int _intFromJson(Object? value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is bool) return value ? 1 : 0;
  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return 0;
    return int.tryParse(trimmed) ?? double.tryParse(trimmed)?.toInt() ?? 0;
  }
  return 0;
}

num _numFromJson(Object? value) {
  if (value == null) return 0;
  if (value is num) return value;
  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return 0;
    return num.tryParse(trimmed) ?? 0;
  }
  return 0;
}

String _stringFromJson(Object? value) => value?.toString() ?? '';

@JsonSerializable(explicitToJson: true)
class GetQuizSubmissionsResponseData {
  const GetQuizSubmissionsResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  final QuizSubmissionsResponseData data;

  factory GetQuizSubmissionsResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetQuizSubmissionsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetQuizSubmissionsResponseDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuizSubmissionsResponseData {
  const QuizSubmissionsResponseData({
    this.items = const [],
    required this.total,
    required this.start,
    required this.pageSize,
    required this.hasNextPage,
    this.summary,
    this.students = const [],
  });

  final List<QuizSubmissionItemModel> items;
  @JsonKey(fromJson: _intFromJson)
  final int total;
  @JsonKey(fromJson: _intFromJson)
  final int start;
  @JsonKey(name: 'page_size', fromJson: _intFromJson)
  final int pageSize;
  @JsonKey(name: 'has_next_page')
  final bool hasNextPage;
  final QuizSubmissionsSummaryModel? summary;
  final List<StudentQuizPerformanceModel> students;

  factory QuizSubmissionsResponseData.fromJson(Map<String, dynamic> json) =>
      _$QuizSubmissionsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$QuizSubmissionsResponseDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuizSubmissionItemModel {
  const QuizSubmissionItemModel({
    required this.name,
    required this.quiz,
    required this.quizTitle,
    required this.member,
    required this.memberName,
    required this.score,
    required this.scoreOutOf,
    required this.percentage,
    required this.passingPercentage,
    required this.creation,
    this.requiresManualGrading = false,
  });

  final String name;
  final String quiz;
  @JsonKey(name: 'quiz_title')
  final String quizTitle;
  final String member;
  @JsonKey(name: 'member_name')
  final String memberName;
  @JsonKey(fromJson: _numFromJson)
  final num score;
  @JsonKey(name: 'score_out_of', fromJson: _numFromJson)
  final num scoreOutOf;
  @JsonKey(fromJson: _numFromJson)
  final num percentage;
  @JsonKey(name: 'passing_percentage', fromJson: _numFromJson)
  final num passingPercentage;
  final String creation;
  @JsonKey(name: 'requires_manual_grading')
  final bool requiresManualGrading;

  factory QuizSubmissionItemModel.fromJson(Map<String, dynamic> json) =>
      _$QuizSubmissionItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizSubmissionItemModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuizSubmissionsSummaryModel {
  const QuizSubmissionsSummaryModel({
    required this.attempts,
    required this.averagePercentage,
    required this.bestPercentage,
    required this.passed,
    required this.failed,
    required this.quizzesAttempted,
  });

  final int attempts;
  @JsonKey(name: 'average_percentage')
  final num averagePercentage;
  @JsonKey(name: 'best_percentage')
  final num bestPercentage;
  final int passed;
  final int failed;
  @JsonKey(name: 'quizzes_attempted')
  final int quizzesAttempted;

  factory QuizSubmissionsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$QuizSubmissionsSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizSubmissionsSummaryModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StudentQuizPerformanceModel {
  const StudentQuizPerformanceModel({
    required this.member,
    required this.memberName,
    required this.attempts,
    required this.averagePercentage,
    required this.bestPercentage,
    required this.passed,
    required this.failed,
    required this.quizzesAttempted,
  });

  final String member;
  @JsonKey(name: 'member_name')
  final String memberName;
  final int attempts;
  @JsonKey(name: 'average_percentage')
  final num averagePercentage;
  @JsonKey(name: 'best_percentage')
  final num bestPercentage;
  final int passed;
  final int failed;
  @JsonKey(name: 'quizzes_attempted')
  final int quizzesAttempted;

  factory StudentQuizPerformanceModel.fromJson(Map<String, dynamic> json) =>
      _$StudentQuizPerformanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentQuizPerformanceModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GradeQuizSubmissionResponseData {
  const GradeQuizSubmissionResponseData({
    required this.submission,
    required this.score,
    required this.scoreOutOf,
    required this.percentage,
    this.pass,
  });

  final String submission;
  final num score;
  @JsonKey(name: 'score_out_of')
  final num scoreOutOf;
  final num percentage;
  final bool? pass;

  factory GradeQuizSubmissionResponseData.fromJson(Map<String, dynamic> json) =>
      _$GradeQuizSubmissionResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GradeQuizSubmissionResponseDataToJson(this);
}
