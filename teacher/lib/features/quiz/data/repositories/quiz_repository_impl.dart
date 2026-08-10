import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/remote/quiz_remote_datasource.dart';
import '../models/quiz_models.dart';
import '../models/quiz_submission_models.dart';

class QuizRepositoryImpl implements QuizRepository {
  const QuizRepositoryImpl(this._remoteDataSource);

  final QuizRemoteDataSource _remoteDataSource;

  Future<ApiResult<T>> _getResult<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return ApiSuccess(result);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  // --- Questions ---

  @override
  Future<ApiResult<PaginatedList<QuestionModel>>> listQuestions({
    String? type,
    int start = 0,
    int pageSize = 30,
  }) => _getResult(
    () async => (await _remoteDataSource.listQuestions(
      type: type,
      start: start,
      pageSize: pageSize,
    )).data,
  );

  @override
  Future<ApiResult<QuestionModel>> getQuestion(String questionName) =>
      _getResult(
        () async => (await _remoteDataSource.getQuestion(questionName)).data,
      );

  @override
  Future<ApiResult<QuestionModel>> createQuestion(Map<String, dynamic> body) =>
      _getResult(
        () async => (await _remoteDataSource.createQuestion(body)).data,
      );

  @override
  Future<ApiResult<QuestionModel>> updateQuestion(Map<String, dynamic> body) =>
      _getResult(
        () async => (await _remoteDataSource.updateQuestion(body)).data,
      );

  @override
  Future<ApiResult<void>> deleteQuestion(String questionName) => _getResult(
    () => _remoteDataSource.deleteQuestion({'question': questionName}),
  );

  // --- Quizzes ---

  @override
  Future<ApiResult<PaginatedList<QuizSummaryModel>>> listQuizzes({
    int start = 0,
    int pageSize = 30,
  }) => _getResult(
    () async => (await _remoteDataSource.listQuizzes(
      start: start,
      pageSize: pageSize,
    )).data,
  );

  @override
  Future<ApiResult<QuizModel>> getQuiz(String quizName) =>
      _getResult(() async => (await _remoteDataSource.getQuiz(quizName)).data);

  @override
  Future<ApiResult<QuizModel>> createQuiz(Map<String, dynamic> body) =>
      _getResult(() async => (await _remoteDataSource.createQuiz(body)).data);

  @override
  Future<ApiResult<QuizModel>> updateQuiz(Map<String, dynamic> body) =>
      _getResult(() async => (await _remoteDataSource.updateQuiz(body)).data);

  @override
  Future<ApiResult<void>> deleteQuiz(String quizName) =>
      _getResult(() => _remoteDataSource.deleteQuiz({'quiz': quizName}));

  // --- Quiz-Question link ---

  @override
  Future<ApiResult<QuizModel>> addQuestionToQuiz({
    required String quiz,
    required String question,
    required int marks,
  }) => _getResult(
    () async => (await _remoteDataSource.addQuestionToQuiz({
      'quiz': quiz,
      'question': question,
      'marks': marks,
    })).data,
  );

  @override
  Future<ApiResult<QuizModel>> removeQuestionFromQuiz({
    required String quiz,
    required String question,
  }) => _getResult(
    () async => (await _remoteDataSource.removeQuestionFromQuiz({
      'quiz': quiz,
      'question': question,
    })).data,
  );

  // --- Submissions ---

  @override
  Future<ApiResult<PaginatedList<QuizSubmissionItemModel>>> getQuizSubmissions({
    String? quizName,
    bool? pendingGrading,
    int start = 0,
    int pageSize = 30,
  }) => _getResult(() async {
    final response = await _remoteDataSource.getQuizSubmissions(
      quizName: quizName,
      pendingGrading: pendingGrading,
      start: start,
      pageSize: pageSize,
    );
    final data = response.data;
    return PaginatedList(
      items: data.items,
      total: data.total,
      start: data.start,
      pageSize: data.pageSize,
      hasNextPage: data.hasNextPage,
    );
  });

  @override
  Future<ApiResult<PaginatedList<QuizSubmissionItemModel>>>
  getStudentQuizSubmissions({
    String? member,
    String? quizName,
    bool? pendingGrading,
    int start = 0,
    int pageSize = 30,
  }) => _getResult(() async {
    final response = await _remoteDataSource.getStudentQuizSubmissions(
      member: member,
      quizName: quizName,
      pendingGrading: pendingGrading,
      start: start,
      pageSize: pageSize,
    );
    final data = response.data;
    return PaginatedList(
      items: data.items,
      total: data.total,
      start: data.start,
      pageSize: data.pageSize,
      hasNextPage: data.hasNextPage,
    );
  });

  @override
  Future<ApiResult<GradeQuizSubmissionResponseData>> gradeQuizSubmission({
    required String submissionName,
    required Map<String, dynamic> questionMarks,
  }) => _getResult(() async {
    final response = await _remoteDataSource.gradeQuizSubmission({
      'submission': submissionName,
      'question_marks': questionMarks,
    });
    return response;
  });
}
