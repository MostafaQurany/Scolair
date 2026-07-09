part of 'quiz_models.dart';

@JsonSerializable()
class ListQuestionsResponseData {
  const ListQuestionsResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(
    fromJson: _paginatedQuestionsFromJson,
    toJson: _paginatedQuestionsToJson,
  )
  final PaginatedList<QuestionModel> data;

  factory ListQuestionsResponseData.fromJson(Map<String, dynamic> json) =>
      _$ListQuestionsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListQuestionsResponseDataToJson(this);
}

@JsonSerializable()
class GetQuestionResponseData {
  const GetQuestionResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _questionFromJson)
  final QuestionModel data;

  factory GetQuestionResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetQuestionResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetQuestionResponseDataToJson(this);
}

@JsonSerializable()
class CreateQuestionResponseData {
  const CreateQuestionResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _questionFromJson)
  final QuestionModel data;

  factory CreateQuestionResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateQuestionResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateQuestionResponseDataToJson(this);
}

@JsonSerializable()
class UpdateQuestionResponseData {
  const UpdateQuestionResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _questionFromJson)
  final QuestionModel data;

  factory UpdateQuestionResponseData.fromJson(Map<String, dynamic> json) =>
      _$UpdateQuestionResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateQuestionResponseDataToJson(this);
}

@JsonSerializable()
class DeleteQuestionResponseData {
  const DeleteQuestionResponseData({
    required this.state,
    required this.message,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;

  factory DeleteQuestionResponseData.fromJson(Map<String, dynamic> json) =>
      _$DeleteQuestionResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteQuestionResponseDataToJson(this);
}

@JsonSerializable()
class ListQuizzesResponseData {
  const ListQuizzesResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _paginatedQuizzesFromJson, toJson: _paginatedQuizzesToJson)
  final PaginatedList<QuizSummaryModel> data;

  factory ListQuizzesResponseData.fromJson(Map<String, dynamic> json) =>
      _$ListQuizzesResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListQuizzesResponseDataToJson(this);
}

@JsonSerializable()
class GetQuizResponseData {
  const GetQuizResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _quizFromJson)
  final QuizModel data;

  factory GetQuizResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetQuizResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetQuizResponseDataToJson(this);
}

@JsonSerializable()
class CreateQuizResponseData {
  const CreateQuizResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _quizFromJson)
  final QuizModel data;

  factory CreateQuizResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateQuizResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateQuizResponseDataToJson(this);
}

@JsonSerializable()
class UpdateQuizResponseData {
  const UpdateQuizResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _quizFromJson)
  final QuizModel data;

  factory UpdateQuizResponseData.fromJson(Map<String, dynamic> json) =>
      _$UpdateQuizResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateQuizResponseDataToJson(this);
}

@JsonSerializable()
class DeleteQuizResponseData {
  const DeleteQuizResponseData({required this.state, required this.message});

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;

  factory DeleteQuizResponseData.fromJson(Map<String, dynamic> json) =>
      _$DeleteQuizResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteQuizResponseDataToJson(this);
}

@JsonSerializable()
class AddQuestionToQuizResponseData {
  const AddQuestionToQuizResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _quizFromJson)
  final QuizModel data;

  factory AddQuestionToQuizResponseData.fromJson(Map<String, dynamic> json) =>
      _$AddQuestionToQuizResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddQuestionToQuizResponseDataToJson(this);
}

@JsonSerializable()
class RemoveQuestionFromQuizResponseData {
  const RemoveQuestionFromQuizResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _quizFromJson)
  final QuizModel data;

  factory RemoveQuestionFromQuizResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$RemoveQuestionFromQuizResponseDataFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RemoveQuestionFromQuizResponseDataToJson(this);
}
