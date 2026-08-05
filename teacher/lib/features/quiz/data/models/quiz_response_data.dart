part of 'quiz_models.dart';

@JsonSerializable()
class ListQuestionsResponseData {
  const ListQuestionsResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory ListQuestionsResponseData.fromJson(Map<String, dynamic> json) =>
      _$ListQuestionsResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(
    fromJson: _paginatedQuestionsFromJson,
    toJson: _paginatedQuestionsToJson,
  )
  final PaginatedList<QuestionModel> data;

  Map<String, dynamic> toJson() => _$ListQuestionsResponseDataToJson(this);
}

@JsonSerializable()
class GetQuestionResponseData {
  const GetQuestionResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory GetQuestionResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetQuestionResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _questionFromJson)
  final QuestionModel data;

  Map<String, dynamic> toJson() => _$GetQuestionResponseDataToJson(this);
}

@JsonSerializable()
class CreateQuestionResponseData {
  const CreateQuestionResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory CreateQuestionResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateQuestionResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _questionFromJson)
  final QuestionModel data;

  Map<String, dynamic> toJson() => _$CreateQuestionResponseDataToJson(this);
}

@JsonSerializable()
class UpdateQuestionResponseData {
  const UpdateQuestionResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory UpdateQuestionResponseData.fromJson(Map<String, dynamic> json) =>
      _$UpdateQuestionResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _questionFromJson)
  final QuestionModel data;

  Map<String, dynamic> toJson() => _$UpdateQuestionResponseDataToJson(this);
}

@JsonSerializable()
class DeleteQuestionResponseData {
  const DeleteQuestionResponseData({
    required this.state,
    required this.message,
  });

  factory DeleteQuestionResponseData.fromJson(Map<String, dynamic> json) =>
      _$DeleteQuestionResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;

  Map<String, dynamic> toJson() => _$DeleteQuestionResponseDataToJson(this);
}

@JsonSerializable()
class ListQuizzesResponseData {
  const ListQuizzesResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory ListQuizzesResponseData.fromJson(Map<String, dynamic> json) =>
      _$ListQuizzesResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _paginatedQuizzesFromJson, toJson: _paginatedQuizzesToJson)
  final PaginatedList<QuizSummaryModel> data;

  Map<String, dynamic> toJson() => _$ListQuizzesResponseDataToJson(this);
}

@JsonSerializable()
class GetQuizResponseData {
  const GetQuizResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory GetQuizResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetQuizResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _quizFromJson)
  final QuizModel data;

  Map<String, dynamic> toJson() => _$GetQuizResponseDataToJson(this);
}

@JsonSerializable()
class CreateQuizResponseData {
  const CreateQuizResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory CreateQuizResponseData.fromJson(Map<String, dynamic> json) =>
      _$CreateQuizResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _quizFromJson)
  final QuizModel data;

  Map<String, dynamic> toJson() => _$CreateQuizResponseDataToJson(this);
}

@JsonSerializable()
class UpdateQuizResponseData {
  const UpdateQuizResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory UpdateQuizResponseData.fromJson(Map<String, dynamic> json) =>
      _$UpdateQuizResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _quizFromJson)
  final QuizModel data;

  Map<String, dynamic> toJson() => _$UpdateQuizResponseDataToJson(this);
}

@JsonSerializable()
class DeleteQuizResponseData {
  const DeleteQuizResponseData({required this.state, required this.message});

  factory DeleteQuizResponseData.fromJson(Map<String, dynamic> json) =>
      _$DeleteQuizResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;

  Map<String, dynamic> toJson() => _$DeleteQuizResponseDataToJson(this);
}

@JsonSerializable()
class AddQuestionToQuizResponseData {
  const AddQuestionToQuizResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory AddQuestionToQuizResponseData.fromJson(Map<String, dynamic> json) =>
      _$AddQuestionToQuizResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _quizFromJson)
  final QuizModel data;

  Map<String, dynamic> toJson() => _$AddQuestionToQuizResponseDataToJson(this);
}

@JsonSerializable()
class RemoveQuestionFromQuizResponseData {
  const RemoveQuestionFromQuizResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  factory RemoveQuestionFromQuizResponseData.fromJson(
    Map<String, dynamic> json,
  ) => _$RemoveQuestionFromQuizResponseDataFromJson(json);

  @JsonKey(fromJson: _stringFromJson)
  final String state;
  @JsonKey(fromJson: _stringFromJson)
  final String message;
  @JsonKey(fromJson: _quizFromJson)
  final QuizModel data;

  Map<String, dynamic> toJson() =>
      _$RemoveQuestionFromQuizResponseDataToJson(this);
}
