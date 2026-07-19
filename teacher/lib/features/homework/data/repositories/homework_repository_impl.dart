import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../domain/repositories/homework_repository.dart';
import '../datasources/local/homework_mock_datasource.dart';
import '../datasources/remote/homework_remote_datasource.dart';
import '../mappers/homework_list_mapper.dart';
import '../models/list_homeworks_request_data.dart';
import '../models/homework_models.dart';
import '../../domain/entities/homework_list_item.dart';

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
}
