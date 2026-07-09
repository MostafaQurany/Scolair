import '../../../../../core/network/api_client.dart';
import '../../models/quiz_models.dart';

/// Abstracts quiz-related API calls.
abstract class QuizRemoteDataSource {
  // Questions
  Future<ListQuestionsResponseData> listQuestions({
    String? type,
    int start = 0,
    int pageSize = 30,
  });
  Future<GetQuestionResponseData> getQuestion(String questionName);
  Future<CreateQuestionResponseData> createQuestion(Map<String, dynamic> body);
  Future<UpdateQuestionResponseData> updateQuestion(Map<String, dynamic> body);
  Future<DeleteQuestionResponseData> deleteQuestion(Map<String, dynamic> body);

  // Quizzes
  Future<ListQuizzesResponseData> listQuizzes({
    int start = 0,
    int pageSize = 30,
  });
  Future<GetQuizResponseData> getQuiz(String quizName);
  Future<CreateQuizResponseData> createQuiz(Map<String, dynamic> body);
  Future<UpdateQuizResponseData> updateQuiz(Map<String, dynamic> body);
  Future<DeleteQuizResponseData> deleteQuiz(Map<String, dynamic> body);

  // Quiz-Question link
  Future<AddQuestionToQuizResponseData> addQuestionToQuiz(
    Map<String, dynamic> body,
  );
  Future<RemoveQuestionFromQuizResponseData> removeQuestionFromQuiz(
    Map<String, dynamic> body,
  );
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  const QuizRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  // --- Questions ---

  @override
  Future<ListQuestionsResponseData> listQuestions({
    String? type,
    int start = 0,
    int pageSize = 30,
  }) => _apiClient.listQuestions(
    type,
    null,
    null,
    null,
    null,
    null,
    start,
    pageSize,
  );

  @override
  Future<GetQuestionResponseData> getQuestion(String questionName) =>
      _apiClient.getQuestion(questionName);

  @override
  Future<CreateQuestionResponseData> createQuestion(
    Map<String, dynamic> body,
  ) => _apiClient.createQuestion(body);

  @override
  Future<UpdateQuestionResponseData> updateQuestion(
    Map<String, dynamic> body,
  ) => _apiClient.updateQuestion(body);

  @override
  Future<DeleteQuestionResponseData> deleteQuestion(
    Map<String, dynamic> body,
  ) => _apiClient.deleteQuestion(body['question'] as String);

  // --- Quizzes ---

  @override
  Future<ListQuizzesResponseData> listQuizzes({
    int start = 0,
    int pageSize = 30,
  }) => _apiClient.listQuizzes(start, pageSize);

  @override
  Future<GetQuizResponseData> getQuiz(String quizName) =>
      _apiClient.getQuiz(quizName);

  @override
  Future<CreateQuizResponseData> createQuiz(Map<String, dynamic> body) =>
      _apiClient.createQuiz(body);

  @override
  Future<UpdateQuizResponseData> updateQuiz(Map<String, dynamic> body) =>
      _apiClient.updateQuiz(body);

  @override
  Future<DeleteQuizResponseData> deleteQuiz(Map<String, dynamic> body) =>
      _apiClient.deleteQuiz(body);

  // --- Quiz-Question link ---

  @override
  Future<AddQuestionToQuizResponseData> addQuestionToQuiz(
    Map<String, dynamic> body,
  ) => _apiClient.addQuestionToQuiz(body);

  @override
  Future<RemoveQuestionFromQuizResponseData> removeQuestionFromQuiz(
    Map<String, dynamic> body,
  ) => _apiClient.removeQuestionFromQuiz(body);
}
