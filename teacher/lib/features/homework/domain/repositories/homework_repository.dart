import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../data/models/list_homeworks_request_data.dart';
import '../../data/models/homework_models.dart';
import '../entities/homework_list_item.dart';

abstract class HomeworkRepository {
  Future<ApiResult<List<HomeworkModel>>> listHomework();
  Future<ApiResult<PaginatedList<HomeworkListItem>>> listHomeworkPage(
    ListHomeworksRequestData request,
  );
  Future<ApiResult<HomeworkModel>> createHomework(HomeworkModel homework);
  Future<ApiResult<HomeworkModel>> updateHomework(HomeworkModel homework);
  Future<ApiResult<void>> deleteHomework(String id);
  Future<ApiResult<HomeworkModel>> duplicateHomework(String id);
}
