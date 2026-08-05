part of 'quiz_models.dart';

@JsonSerializable()
class QuestionModel {
  const QuestionModel({
    required this.name,
    required this.question,
    required this.type,
    this.attachment,
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

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String name;
  @JsonKey(fromJson: _stringFromJson)
  final String question;
  @JsonKey(fromJson: _nullableStringFromJson)
  final String? attachment;
  final ApiQuestionType type;
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

  /// Returns non-null options as a list of (index, text) pairs.
  List<(int, String)> get activeOptions {
    final result = <(int, String)>[];
    if (option1 != null) result.add((1, option1!));
    if (option2 != null) result.add((2, option2!));
    if (option3 != null) result.add((3, option3!));
    if (option4 != null) result.add((4, option4!));
    if (option5 != null) result.add((5, option5!));
    return result;
  }

  /// Returns whether the option at 1-based [index] is correct.
  bool isCorrect(int index) => switch (index) {
    1 => isCorrect1 == 1,
    2 => isCorrect2 == 1,
    3 => isCorrect3 == 1,
    4 => isCorrect4 == 1,
    5 => isCorrect5 == 1,
    _ => false,
  };

  /// Returns the explanation for option at 1-based [index].
  String? explanation(int index) => switch (index) {
    1 => explanation1,
    2 => explanation2,
    3 => explanation3,
    4 => explanation4,
    5 => explanation5,
    _ => null,
  };

  /// Returns non-null possibilities as a list.
  List<String> get activePossibilities {
    final result = <String>[];
    if (possibility1 != null) result.add(possibility1!);
    if (possibility2 != null) result.add(possibility2!);
    if (possibility3 != null) result.add(possibility3!);
    if (possibility4 != null) result.add(possibility4!);
    if (possibility5 != null) result.add(possibility5!);
    return result;
  }

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
