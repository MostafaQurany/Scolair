import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../../quiz/data/models/quiz_models.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasources/remote/question_remote_datasource.dart';
import '../models/question_filter_data.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  const QuestionRepositoryImpl(this._remoteDataSource);

  final QuestionRemoteDataSource _remoteDataSource;

  Future<ApiResult<T>> _getResult<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return ApiSuccess(result);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<PaginatedList<QuestionModel>>> listQuestions({
    QuestionFilterData filters = const QuestionFilterData(),
    int start = 0,
    int pageSize = 30,
  }) => _getResult(
      () async => (await _remoteDataSource.listQuestions(
        filters: filters,
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
  Future<ApiResult<void>> deleteQuestion(String questionName) =>
      _getResult(() async {
        await _remoteDataSource.deleteQuestion(questionName);
      });
}
