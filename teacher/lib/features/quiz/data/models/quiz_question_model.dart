part of 'quiz_models.dart';

@JsonSerializable()
class QuizQuestionModel {
  const QuizQuestionModel({
    required this.name,
    required this.question,
    this.questionDetail,
    this.attachment,
    this.type,
    this.marks = 0,
    this.multiple = 0,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.option5,
    this.isCorrect1 = 0,
    this.isCorrect2 = 0,
    this.isCorrect3 = 0,
    this.isCorrect4 = 0,
    this.isCorrect5 = 0,
    this.explanation1,
    this.explanation2,
    this.explanation3,
    this.explanation4,
    this.explanation5,
    this.possibility1,
    this.possibility2,
    this.possibility3,
    this.possibility4,
    this.possibility5,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionModelFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String name;
  @JsonKey(fromJson: _stringFromJson)
  final String question;
  @JsonKey(name: 'question_detail', fromJson: _nullableStringFromJson)
  final String? questionDetail;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? attachment;

  final ApiQuestionType? type;

  @JsonKey(fromJson: _intFromJson)
  final int marks;
  @JsonKey(fromJson: _intFromJson)
  final int multiple;

  @JsonKey(name: 'option_1', fromJson: _nullableStringFromJson)
  final String? option1;
  @JsonKey(name: 'option_2', fromJson: _nullableStringFromJson)
  final String? option2;
  @JsonKey(name: 'option_3', fromJson: _nullableStringFromJson)
  final String? option3;
  @JsonKey(name: 'option_4', fromJson: _nullableStringFromJson)
  final String? option4;
  @JsonKey(name: 'option_5', fromJson: _nullableStringFromJson)
  final String? option5;
  @JsonKey(name: 'is_correct_1', fromJson: _intFromJson)
  final int isCorrect1;
  @JsonKey(name: 'is_correct_2', fromJson: _intFromJson)
  final int isCorrect2;
  @JsonKey(name: 'is_correct_3', fromJson: _intFromJson)
  final int isCorrect3;
  @JsonKey(name: 'is_correct_4', fromJson: _intFromJson)
  final int isCorrect4;
  @JsonKey(name: 'is_correct_5', fromJson: _intFromJson)
  final int isCorrect5;
  @JsonKey(name: 'explanation_1', fromJson: _nullableStringFromJson)
  final String? explanation1;
  @JsonKey(name: 'explanation_2', fromJson: _nullableStringFromJson)
  final String? explanation2;
  @JsonKey(name: 'explanation_3', fromJson: _nullableStringFromJson)
  final String? explanation3;
  @JsonKey(name: 'explanation_4', fromJson: _nullableStringFromJson)
  final String? explanation4;
  @JsonKey(name: 'explanation_5', fromJson: _nullableStringFromJson)
  final String? explanation5;
  @JsonKey(name: 'possibility_1', fromJson: _nullableStringFromJson)
  final String? possibility1;
  @JsonKey(name: 'possibility_2', fromJson: _nullableStringFromJson)
  final String? possibility2;
  @JsonKey(name: 'possibility_3', fromJson: _nullableStringFromJson)
  final String? possibility3;
  @JsonKey(name: 'possibility_4', fromJson: _nullableStringFromJson)
  final String? possibility4;
  @JsonKey(name: 'possibility_5', fromJson: _nullableStringFromJson)
  final String? possibility5;

  /// Display text: prefer question_detail, fall back to question name.
  String get displayText => questionDetail ?? question;

  Map<String, dynamic> toJson() => _$QuizQuestionModelToJson(this);
}
