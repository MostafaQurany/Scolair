import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../domain/entities/homework_detail.dart';
import '../../domain/entities/homework_list_item.dart';
import '../../domain/entities/homework_submission.dart';
import '../../domain/repositories/homework_repository.dart';
import '../datasources/local/homework_mock_datasource.dart';
import '../datasources/remote/homework_remote_datasource.dart';
import '../mappers/homework_detail_mapper.dart';
import '../mappers/homework_list_mapper.dart';
import '../mappers/homework_submission_mapper.dart';
import '../models/homework_mutation_models.dart';
import '../models/list_homeworks_request_data.dart';
import '../models/homework_models.dart';

class HomeworkRepositoryImpl implements HomeworkRepository {
  const HomeworkRepositoryImpl(this._dataSource, this._remoteDataSource);

  final HomeworkMockDataSource _dataSource;
  final HomeworkRemoteDataSource _remoteDataSource;

  Future<ApiResult<T>> _getResult<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return ApiSuccess(result);
    } on Object catch (e) {
      return ApiFailure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<HomeworkModel>>> listHomework() =>
      _getResult(_dataSource.listHomework);

  @override
  Future<ApiResult<PaginatedList<HomeworkListItem>>> listHomeworkPage(
    ListHomeworksRequestData request,
  ) => _getResult(
    () async =>
        (await _remoteDataSource.listHomeworks(request)).data.toDomain(),
  );

  @override
  Future<ApiResult<HomeworkModel>> createHomework(HomeworkModel homework) =>
      _getResult(() => _dataSource.createHomework(homework));

  @override
  Future<ApiResult<HomeworkModel>> updateHomework(HomeworkModel homework) =>
      _getResult(() => _dataSource.updateHomework(homework));

  @override
  Future<ApiResult<void>> deleteHomework(String id) =>
      _getResult(() => _remoteDataSource.deleteHomework(id));

  @override
  Future<ApiResult<HomeworkModel>> duplicateHomework(String id) =>
      _getResult(() => _dataSource.duplicateHomework(id));

  @override
  Future<ApiResult<HomeworkDetail>> getHomeworkDetails(
    String homeworkName,
  ) => _getResult(
    () async =>
        (await _remoteDataSource.getHomework(homeworkName)).data.toDomain(),
  );

  @override
  Future<ApiResult<HomeworkDetail>> createHomeworkRemote(
    CreateHomeworkRequestData request,
  ) => _getResult(
    () async =>
        (await _remoteDataSource.createHomework(request)).data.toDomain(),
  );

  @override
  Future<ApiResult<HomeworkDetail>> updateHomeworkRemote(
    UpdateHomeworkRequestData request,
  ) => _getResult(
    () async =>
        (await _remoteDataSource.updateHomework(request)).data.toDomain(),
  );

  @override
  Future<ApiResult<void>> addQuestion({
    required String homeworkName,
    required String questionName,
    required int marks,
  }) => _getResult(
    () => _remoteDataSource.addQuestion(
      AddHomeworkQuestionRequestData(
        homeworkName: homeworkName,
        questionName: questionName,
        marks: marks,
      ),
    ),
  );

  @override
  Future<ApiResult<void>> removeQuestion({
    required String homeworkName,
    required String questionName,
  }) => _getResult(
    () => _remoteDataSource.removeQuestion(
      homeworkName: homeworkName,
      questionName: questionName,
    ),
  );

  @override
  Future<ApiResult<PaginatedList<HomeworkSubmissionItem>>> getSubmissionsPage({
    required String homeworkName,
    int start = 0,
    int pageSize = 30,
  }) => _getResult(
    () async => (await _remoteDataSource.getSubmissions(
      homeworkName: homeworkName,
      start: start,
      pageSize: pageSize,
    )).data.toDomain(),
  );

  @override
  Future<ApiResult<HomeworkSubmissionDetail>> getSubmissionDetails(
    String submissionName,
  ) => _getResult(
    () async => (await _remoteDataSource.getSubmission(
      submissionName,
    )).data.toDomain(),
  );

  @override
  Future<ApiResult<List<int>>> downloadAnswerFile({
    required String submissionName,
    required String questionName,
  }) => _getResult(
    () => _remoteDataSource.downloadAnswerFile(
      submissionName: submissionName,
      questionName: questionName,
    ),
  );

  @override
  Future<ApiResult<HomeworkSubmissionDetail>> gradeSubmission(
    GradeSubmissionRequestData request,
  ) => _getResult(
    () async =>
        (await _remoteDataSource.gradeSubmission(request)).data.toDomain(),
  );
}
