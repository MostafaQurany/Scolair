import '../../../../core/network/api_result.dart';
import '../../data/models/quiz_models.dart';

abstract class QuizRepository {
  Future<ApiResult<List<QuizModel>>> listQuizzes();
  Future<ApiResult<QuizModel>> getQuiz(String id);
  Future<ApiResult<QuizModel>> createQuiz(QuizModel quiz);
  Future<ApiResult<QuizModel>> updateQuiz(QuizModel quiz);
  Future<ApiResult<void>> deleteQuiz(String id);
  Future<ApiResult<QuizModel>> createQuestion(
    String quizId,
    QuestionModel question,
  );
  Future<ApiResult<QuizModel>> updateQuestion(
    String quizId,
    QuestionModel question,
  );
  Future<ApiResult<QuizModel>> deleteQuestion(String quizId, String questionId);
}
