import '../../../../core/network/api_result.dart';
import '../../data/models/homework_models.dart';

abstract class HomeworkRepository {
  Future<ApiResult<List<HomeworkModel>>> listHomework();
  Future<ApiResult<HomeworkModel>> createHomework(HomeworkModel homework);
  Future<ApiResult<HomeworkModel>> updateHomework(HomeworkModel homework);
  Future<ApiResult<void>> deleteHomework(String id);
  Future<ApiResult<HomeworkModel>> duplicateHomework(String id);
}
