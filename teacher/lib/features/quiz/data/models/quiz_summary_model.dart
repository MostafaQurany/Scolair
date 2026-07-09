part of 'quiz_models.dart';

@JsonSerializable()
class QuizSummaryModel {
  const QuizSummaryModel({
    required this.name,
    required this.title,
    this.maxAttempts = 0,
    this.showAnswers = 1,
    this.showSubmissionHistory = 0,
    this.totalMarks = 0,
    this.passingPercentage = 0,
    this.duration,
    this.shuffleQuestions = 0,
    this.limitQuestionsTo = 0,
    this.enableNegativeMarking = 0,
    this.marksToCut = 1,
    this.lesson,
    this.course,
    this.owner,
    this.creation,
    this.modified,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String name;
  @JsonKey(fromJson: _stringFromJson)
  final String title;
  @JsonKey(name: 'max_attempts', fromJson: _intFromJson)
  final int maxAttempts;
  @JsonKey(name: 'show_answers', fromJson: _intFromJson)
  final int showAnswers;
  @JsonKey(name: 'show_submission_history', fromJson: _intFromJson)
  final int showSubmissionHistory;
  @JsonKey(name: 'total_marks', fromJson: _intFromJson)
  final int totalMarks;
  @JsonKey(name: 'passing_percentage', fromJson: _intFromJson)
  final int passingPercentage;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? duration;
  @JsonKey(name: 'shuffle_questions', fromJson: _intFromJson)
  final int shuffleQuestions;
  @JsonKey(name: 'limit_questions_to', fromJson: _intFromJson)
  final int limitQuestionsTo;
  @JsonKey(name: 'enable_negative_marking', fromJson: _intFromJson)
  final int enableNegativeMarking;
  @JsonKey(name: 'marks_to_cut', fromJson: _intFromJson)
  final int marksToCut;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? lesson;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? course;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? owner;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? creation;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? modified;

  factory QuizSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$QuizSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizSummaryModelToJson(this);
}
