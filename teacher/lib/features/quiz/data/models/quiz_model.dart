part of 'quiz_models.dart';

@JsonSerializable()
class QuizModel {
  const QuizModel({
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
    this.questions = const [],
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) =>
      _$QuizModelFromJson(json);

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
  @JsonKey(fromJson: _quizQuestionsFromJson)
  final List<QuizQuestionModel> questions;

  Map<String, dynamic> toJson() => _$QuizModelToJson(this);

  QuizModel copyWith({
    String? name,
    String? title,
    int? maxAttempts,
    int? showAnswers,
    int? showSubmissionHistory,
    int? totalMarks,
    int? passingPercentage,
    String? duration,
    int? shuffleQuestions,
    int? limitQuestionsTo,
    int? enableNegativeMarking,
    int? marksToCut,
    String? lesson,
    String? course,
    String? owner,
    String? creation,
    String? modified,
    List<QuizQuestionModel>? questions,
  }) => QuizModel(
      name: name ?? this.name,
      title: title ?? this.title,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      showAnswers: showAnswers ?? this.showAnswers,
      showSubmissionHistory:
          showSubmissionHistory ?? this.showSubmissionHistory,
      totalMarks: totalMarks ?? this.totalMarks,
      passingPercentage: passingPercentage ?? this.passingPercentage,
      duration: duration ?? this.duration,
      shuffleQuestions: shuffleQuestions ?? this.shuffleQuestions,
      limitQuestionsTo: limitQuestionsTo ?? this.limitQuestionsTo,
      enableNegativeMarking:
          enableNegativeMarking ?? this.enableNegativeMarking,
      marksToCut: marksToCut ?? this.marksToCut,
      lesson: lesson ?? this.lesson,
      course: course ?? this.course,
      owner: owner ?? this.owner,
      creation: creation ?? this.creation,
      modified: modified ?? this.modified,
      questions: questions ?? this.questions,
    );
}
