import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/local/quiz_mock_datasource.dart';
import '../models/quiz_models.dart';

class QuizRepositoryImpl implements QuizRepository {
  const QuizRepositoryImpl(this._dataSource);

  final QuizMockDataSource _dataSource;

  Future<ApiResult<T>> _getResult<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return ApiSuccess(result);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<QuizModel>>> listQuizzes() =>
      _getResult(_dataSource.listQuizzes);

  @override
  Future<ApiResult<QuizModel>> getQuiz(String id) =>
      _getResult(() => _dataSource.getQuiz(id));

  @override
  Future<ApiResult<QuizModel>> createQuiz(QuizModel quiz) =>
      _getResult(() => _dataSource.createQuiz(quiz));

  @override
  Future<ApiResult<QuizModel>> updateQuiz(QuizModel quiz) =>
      _getResult(() => _dataSource.updateQuiz(quiz));

  @override
  Future<ApiResult<void>> deleteQuiz(String id) =>
      _getResult(() => _dataSource.deleteQuiz(id));

  @override
  Future<ApiResult<QuizModel>> createQuestion(
    String quizId,
    QuestionModel question,
  ) => _getResult(() => _dataSource.createQuestion(quizId, question));

  @override
  Future<ApiResult<QuizModel>> updateQuestion(
    String quizId,
    QuestionModel question,
  ) => _getResult(() => _dataSource.updateQuestion(quizId, question));

  @override
  Future<ApiResult<QuizModel>> deleteQuestion(
    String quizId,
    String questionId,
  ) => _getResult(() => _dataSource.deleteQuestion(quizId, questionId));
}
