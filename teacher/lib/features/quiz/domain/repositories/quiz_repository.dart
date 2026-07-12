import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../data/models/quiz_models.dart';

/// Quiz feature repository contract.
abstract class QuizRepository {
  // Questions
  Future<ApiResult<PaginatedList<QuestionModel>>> listQuestions({
    String? type,
    int start = 0,
    int pageSize = 30,
  });
  Future<ApiResult<QuestionModel>> getQuestion(String questionName);
  Future<ApiResult<QuestionModel>> createQuestion(Map<String, dynamic> body);
  Future<ApiResult<QuestionModel>> updateQuestion(Map<String, dynamic> body);
  Future<ApiResult<void>> deleteQuestion(String questionName);

  // Quizzes
  Future<ApiResult<PaginatedList<QuizSummaryModel>>> listQuizzes({
    int start = 0,
    int pageSize = 30,
  });
  Future<ApiResult<QuizModel>> getQuiz(String quizName);
  Future<ApiResult<QuizModel>> createQuiz(Map<String, dynamic> body);
  Future<ApiResult<QuizModel>> updateQuiz(Map<String, dynamic> body);
  Future<ApiResult<void>> deleteQuiz(String quizName);

  // Quiz-Question link
  Future<ApiResult<QuizModel>> addQuestionToQuiz({
    required String quiz,
    required String question,
    required int marks,
  });
  Future<ApiResult<QuizModel>> removeQuestionFromQuiz({
    required String quiz,
    required String question,
  });
}
