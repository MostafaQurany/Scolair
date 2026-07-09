part of 'quiz_models.dart';

enum ApiQuestionType {
  @JsonValue('Choices')
  choices,
  @JsonValue('User Input')
  userInput,
  @JsonValue('Open Ended')
  openEnded,
}
