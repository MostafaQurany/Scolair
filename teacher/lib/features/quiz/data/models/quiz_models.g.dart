// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      name: _stringFromJson(json['name']),
      question: _stringFromJson(json['question']),
      type: $enumDecode(_$ApiQuestionTypeEnumMap, json['type']),
      multiple: json['multiple'] == null ? 0 : _intFromJson(json['multiple']),
      option1: _nullableStringFromJson(json['option_1']),
      option2: _nullableStringFromJson(json['option_2']),
      option3: _nullableStringFromJson(json['option_3']),
      option4: _nullableStringFromJson(json['option_4']),
      option5: _nullableStringFromJson(json['option_5']),
      isCorrect1: json['is_correct_1'] == null
          ? 0
          : _intFromJson(json['is_correct_1']),
      isCorrect2: json['is_correct_2'] == null
          ? 0
          : _intFromJson(json['is_correct_2']),
      isCorrect3: json['is_correct_3'] == null
          ? 0
          : _intFromJson(json['is_correct_3']),
      isCorrect4: json['is_correct_4'] == null
          ? 0
          : _intFromJson(json['is_correct_4']),
      isCorrect5: json['is_correct_5'] == null
          ? 0
          : _intFromJson(json['is_correct_5']),
      explanation1: _nullableStringFromJson(json['explanation_1']),
      explanation2: _nullableStringFromJson(json['explanation_2']),
      explanation3: _nullableStringFromJson(json['explanation_3']),
      explanation4: _nullableStringFromJson(json['explanation_4']),
      explanation5: _nullableStringFromJson(json['explanation_5']),
      possibility1: _nullableStringFromJson(json['possibility_1']),
      possibility2: _nullableStringFromJson(json['possibility_2']),
      possibility3: _nullableStringFromJson(json['possibility_3']),
      possibility4: _nullableStringFromJson(json['possibility_4']),
      possibility5: _nullableStringFromJson(json['possibility_5']),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'question': instance.question,
      'type': _$ApiQuestionTypeEnumMap[instance.type]!,
      'multiple': instance.multiple,
      'option_1': instance.option1,
      'option_2': instance.option2,
      'option_3': instance.option3,
      'option_4': instance.option4,
      'option_5': instance.option5,
      'is_correct_1': instance.isCorrect1,
      'is_correct_2': instance.isCorrect2,
      'is_correct_3': instance.isCorrect3,
      'is_correct_4': instance.isCorrect4,
      'is_correct_5': instance.isCorrect5,
      'explanation_1': instance.explanation1,
      'explanation_2': instance.explanation2,
      'explanation_3': instance.explanation3,
      'explanation_4': instance.explanation4,
      'explanation_5': instance.explanation5,
      'possibility_1': instance.possibility1,
      'possibility_2': instance.possibility2,
      'possibility_3': instance.possibility3,
      'possibility_4': instance.possibility4,
      'possibility_5': instance.possibility5,
    };

const _$ApiQuestionTypeEnumMap = {
  ApiQuestionType.choices: 'Choices',
  ApiQuestionType.userInput: 'User Input',
  ApiQuestionType.openEnded: 'Open Ended',
};

QuizQuestionModel _$QuizQuestionModelFromJson(Map<String, dynamic> json) =>
    QuizQuestionModel(
      name: _stringFromJson(json['name']),
      question: _stringFromJson(json['question']),
      questionDetail: _nullableStringFromJson(json['question_detail']),
      type: $enumDecodeNullable(_$ApiQuestionTypeEnumMap, json['type']),
      marks: json['marks'] == null ? 0 : _intFromJson(json['marks']),
      multiple: json['multiple'] == null ? 0 : _intFromJson(json['multiple']),
      option1: _nullableStringFromJson(json['option_1']),
      option2: _nullableStringFromJson(json['option_2']),
      option3: _nullableStringFromJson(json['option_3']),
      option4: _nullableStringFromJson(json['option_4']),
      option5: _nullableStringFromJson(json['option_5']),
      isCorrect1: json['is_correct_1'] == null
          ? 0
          : _intFromJson(json['is_correct_1']),
      isCorrect2: json['is_correct_2'] == null
          ? 0
          : _intFromJson(json['is_correct_2']),
      isCorrect3: json['is_correct_3'] == null
          ? 0
          : _intFromJson(json['is_correct_3']),
      isCorrect4: json['is_correct_4'] == null
          ? 0
          : _intFromJson(json['is_correct_4']),
      isCorrect5: json['is_correct_5'] == null
          ? 0
          : _intFromJson(json['is_correct_5']),
      explanation1: _nullableStringFromJson(json['explanation_1']),
      explanation2: _nullableStringFromJson(json['explanation_2']),
      explanation3: _nullableStringFromJson(json['explanation_3']),
      explanation4: _nullableStringFromJson(json['explanation_4']),
      explanation5: _nullableStringFromJson(json['explanation_5']),
      possibility1: _nullableStringFromJson(json['possibility_1']),
      possibility2: _nullableStringFromJson(json['possibility_2']),
      possibility3: _nullableStringFromJson(json['possibility_3']),
      possibility4: _nullableStringFromJson(json['possibility_4']),
      possibility5: _nullableStringFromJson(json['possibility_5']),
    );

Map<String, dynamic> _$QuizQuestionModelToJson(QuizQuestionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'question': instance.question,
      'question_detail': instance.questionDetail,
      'type': _$ApiQuestionTypeEnumMap[instance.type],
      'marks': instance.marks,
      'multiple': instance.multiple,
      'option_1': instance.option1,
      'option_2': instance.option2,
      'option_3': instance.option3,
      'option_4': instance.option4,
      'option_5': instance.option5,
      'is_correct_1': instance.isCorrect1,
      'is_correct_2': instance.isCorrect2,
      'is_correct_3': instance.isCorrect3,
      'is_correct_4': instance.isCorrect4,
      'is_correct_5': instance.isCorrect5,
      'explanation_1': instance.explanation1,
      'explanation_2': instance.explanation2,
      'explanation_3': instance.explanation3,
      'explanation_4': instance.explanation4,
      'explanation_5': instance.explanation5,
      'possibility_1': instance.possibility1,
      'possibility_2': instance.possibility2,
      'possibility_3': instance.possibility3,
      'possibility_4': instance.possibility4,
      'possibility_5': instance.possibility5,
    };

QuizSummaryModel _$QuizSummaryModelFromJson(Map<String, dynamic> json) =>
    QuizSummaryModel(
      name: _stringFromJson(json['name']),
      title: _stringFromJson(json['title']),
      maxAttempts: json['max_attempts'] == null
          ? 0
          : _intFromJson(json['max_attempts']),
      showAnswers: json['show_answers'] == null
          ? 1
          : _intFromJson(json['show_answers']),
      showSubmissionHistory: json['show_submission_history'] == null
          ? 0
          : _intFromJson(json['show_submission_history']),
      totalMarks: json['total_marks'] == null
          ? 0
          : _intFromJson(json['total_marks']),
      passingPercentage: json['passing_percentage'] == null
          ? 0
          : _intFromJson(json['passing_percentage']),
      duration: _nullableStringFromJson(json['duration']),
      shuffleQuestions: json['shuffle_questions'] == null
          ? 0
          : _intFromJson(json['shuffle_questions']),
      limitQuestionsTo: json['limit_questions_to'] == null
          ? 0
          : _intFromJson(json['limit_questions_to']),
      enableNegativeMarking: json['enable_negative_marking'] == null
          ? 0
          : _intFromJson(json['enable_negative_marking']),
      marksToCut: json['marks_to_cut'] == null
          ? 1
          : _intFromJson(json['marks_to_cut']),
      lesson: _nullableStringFromJson(json['lesson']),
      course: _nullableStringFromJson(json['course']),
      owner: _nullableStringFromJson(json['owner']),
      creation: _nullableStringFromJson(json['creation']),
      modified: _nullableStringFromJson(json['modified']),
    );

Map<String, dynamic> _$QuizSummaryModelToJson(QuizSummaryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'max_attempts': instance.maxAttempts,
      'show_answers': instance.showAnswers,
      'show_submission_history': instance.showSubmissionHistory,
      'total_marks': instance.totalMarks,
      'passing_percentage': instance.passingPercentage,
      'duration': instance.duration,
      'shuffle_questions': instance.shuffleQuestions,
      'limit_questions_to': instance.limitQuestionsTo,
      'enable_negative_marking': instance.enableNegativeMarking,
      'marks_to_cut': instance.marksToCut,
      'lesson': instance.lesson,
      'course': instance.course,
      'owner': instance.owner,
      'creation': instance.creation,
      'modified': instance.modified,
    };

QuizModel _$QuizModelFromJson(Map<String, dynamic> json) => QuizModel(
  name: _stringFromJson(json['name']),
  title: _stringFromJson(json['title']),
  maxAttempts: json['max_attempts'] == null
      ? 0
      : _intFromJson(json['max_attempts']),
  showAnswers: json['show_answers'] == null
      ? 1
      : _intFromJson(json['show_answers']),
  showSubmissionHistory: json['show_submission_history'] == null
      ? 0
      : _intFromJson(json['show_submission_history']),
  totalMarks: json['total_marks'] == null
      ? 0
      : _intFromJson(json['total_marks']),
  passingPercentage: json['passing_percentage'] == null
      ? 0
      : _intFromJson(json['passing_percentage']),
  duration: _nullableStringFromJson(json['duration']),
  shuffleQuestions: json['shuffle_questions'] == null
      ? 0
      : _intFromJson(json['shuffle_questions']),
  limitQuestionsTo: json['limit_questions_to'] == null
      ? 0
      : _intFromJson(json['limit_questions_to']),
  enableNegativeMarking: json['enable_negative_marking'] == null
      ? 0
      : _intFromJson(json['enable_negative_marking']),
  marksToCut: json['marks_to_cut'] == null
      ? 1
      : _intFromJson(json['marks_to_cut']),
  lesson: _nullableStringFromJson(json['lesson']),
  course: _nullableStringFromJson(json['course']),
  owner: _nullableStringFromJson(json['owner']),
  creation: _nullableStringFromJson(json['creation']),
  modified: _nullableStringFromJson(json['modified']),
  questions: json['questions'] == null
      ? const []
      : _quizQuestionsFromJson(json['questions']),
);

Map<String, dynamic> _$QuizModelToJson(QuizModel instance) => <String, dynamic>{
  'name': instance.name,
  'title': instance.title,
  'max_attempts': instance.maxAttempts,
  'show_answers': instance.showAnswers,
  'show_submission_history': instance.showSubmissionHistory,
  'total_marks': instance.totalMarks,
  'passing_percentage': instance.passingPercentage,
  'duration': instance.duration,
  'shuffle_questions': instance.shuffleQuestions,
  'limit_questions_to': instance.limitQuestionsTo,
  'enable_negative_marking': instance.enableNegativeMarking,
  'marks_to_cut': instance.marksToCut,
  'lesson': instance.lesson,
  'course': instance.course,
  'owner': instance.owner,
  'creation': instance.creation,
  'modified': instance.modified,
  'questions': instance.questions,
};

ListQuestionsResponseData _$ListQuestionsResponseDataFromJson(
  Map<String, dynamic> json,
) => ListQuestionsResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _paginatedQuestionsFromJson(json['data']),
);

Map<String, dynamic> _$ListQuestionsResponseDataToJson(
  ListQuestionsResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': _paginatedQuestionsToJson(instance.data),
};

GetQuestionResponseData _$GetQuestionResponseDataFromJson(
  Map<String, dynamic> json,
) => GetQuestionResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _questionFromJson(json['data']),
);

Map<String, dynamic> _$GetQuestionResponseDataToJson(
  GetQuestionResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

CreateQuestionResponseData _$CreateQuestionResponseDataFromJson(
  Map<String, dynamic> json,
) => CreateQuestionResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _questionFromJson(json['data']),
);

Map<String, dynamic> _$CreateQuestionResponseDataToJson(
  CreateQuestionResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

UpdateQuestionResponseData _$UpdateQuestionResponseDataFromJson(
  Map<String, dynamic> json,
) => UpdateQuestionResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _questionFromJson(json['data']),
);

Map<String, dynamic> _$UpdateQuestionResponseDataToJson(
  UpdateQuestionResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

DeleteQuestionResponseData _$DeleteQuestionResponseDataFromJson(
  Map<String, dynamic> json,
) => DeleteQuestionResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
);

Map<String, dynamic> _$DeleteQuestionResponseDataToJson(
  DeleteQuestionResponseData instance,
) => <String, dynamic>{'state': instance.state, 'message': instance.message};

ListQuizzesResponseData _$ListQuizzesResponseDataFromJson(
  Map<String, dynamic> json,
) => ListQuizzesResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _paginatedQuizzesFromJson(json['data']),
);

Map<String, dynamic> _$ListQuizzesResponseDataToJson(
  ListQuizzesResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': _paginatedQuizzesToJson(instance.data),
};

GetQuizResponseData _$GetQuizResponseDataFromJson(Map<String, dynamic> json) =>
    GetQuizResponseData(
      state: _stringFromJson(json['state']),
      message: _stringFromJson(json['message']),
      data: _quizFromJson(json['data']),
    );

Map<String, dynamic> _$GetQuizResponseDataToJson(
  GetQuizResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

CreateQuizResponseData _$CreateQuizResponseDataFromJson(
  Map<String, dynamic> json,
) => CreateQuizResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _quizFromJson(json['data']),
);

Map<String, dynamic> _$CreateQuizResponseDataToJson(
  CreateQuizResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

UpdateQuizResponseData _$UpdateQuizResponseDataFromJson(
  Map<String, dynamic> json,
) => UpdateQuizResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _quizFromJson(json['data']),
);

Map<String, dynamic> _$UpdateQuizResponseDataToJson(
  UpdateQuizResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

DeleteQuizResponseData _$DeleteQuizResponseDataFromJson(
  Map<String, dynamic> json,
) => DeleteQuizResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
);

Map<String, dynamic> _$DeleteQuizResponseDataToJson(
  DeleteQuizResponseData instance,
) => <String, dynamic>{'state': instance.state, 'message': instance.message};

AddQuestionToQuizResponseData _$AddQuestionToQuizResponseDataFromJson(
  Map<String, dynamic> json,
) => AddQuestionToQuizResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _quizFromJson(json['data']),
);

Map<String, dynamic> _$AddQuestionToQuizResponseDataToJson(
  AddQuestionToQuizResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};

RemoveQuestionFromQuizResponseData _$RemoveQuestionFromQuizResponseDataFromJson(
  Map<String, dynamic> json,
) => RemoveQuestionFromQuizResponseData(
  state: _stringFromJson(json['state']),
  message: _stringFromJson(json['message']),
  data: _quizFromJson(json['data']),
);

Map<String, dynamic> _$RemoveQuestionFromQuizResponseDataToJson(
  RemoveQuestionFromQuizResponseData instance,
) => <String, dynamic>{
  'state': instance.state,
  'message': instance.message,
  'data': instance.data,
};
