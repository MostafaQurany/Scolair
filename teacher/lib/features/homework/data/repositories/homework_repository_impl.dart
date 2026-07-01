import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repositories/homework_repository.dart';
import '../datasources/local/homework_mock_datasource.dart';
import '../models/homework_models.dart';

class HomeworkRepositoryImpl implements HomeworkRepository {
  const HomeworkRepositoryImpl(this._dataSource);

  final HomeworkMockDataSource _dataSource;

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
  Future<ApiResult<HomeworkModel>> createHomework(HomeworkModel homework) =>
      _getResult(() => _dataSource.createHomework(homework));

  @override
  Future<ApiResult<HomeworkModel>> updateHomework(HomeworkModel homework) =>
      _getResult(() => _dataSource.updateHomework(homework));

  @override
  Future<ApiResult<void>> deleteHomework(String id) =>
      _getResult(() => _dataSource.deleteHomework(id));

  @override
  Future<ApiResult<HomeworkModel>> duplicateHomework(String id) =>
      _getResult(() => _dataSource.duplicateHomework(id));
}
