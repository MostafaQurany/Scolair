import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../data/models/homework_mutation_models.dart';
import '../../data/models/list_homeworks_request_data.dart';
import '../../data/models/homework_models.dart';
import '../entities/homework_detail.dart';
import '../entities/homework_list_item.dart';
import '../entities/homework_submission.dart';

abstract class HomeworkRepository {
  Future<ApiResult<List<HomeworkModel>>> listHomework();
  Future<ApiResult<PaginatedList<HomeworkListItem>>> listHomeworkPage(
    ListHomeworksRequestData request,
  );
  Future<ApiResult<HomeworkModel>> createHomework(HomeworkModel homework);
  Future<ApiResult<HomeworkModel>> updateHomework(HomeworkModel homework);
  Future<ApiResult<void>> deleteHomework(String id);
  Future<ApiResult<HomeworkModel>> duplicateHomework(String id);

  Future<ApiResult<HomeworkDetail>> getHomeworkDetails(String homeworkName);
  Future<ApiResult<HomeworkDetail>> createHomeworkRemote(
    CreateHomeworkRequestData request,
  );
  Future<ApiResult<HomeworkDetail>> updateHomeworkRemote(
    UpdateHomeworkRequestData request,
  );
  Future<ApiResult<void>> addQuestion({
    required String homeworkName,
    required String questionName,
    required int marks,
  });
  Future<ApiResult<void>> removeQuestion({
    required String homeworkName,
    required String questionName,
  });
  Future<ApiResult<PaginatedList<HomeworkSubmissionItem>>> getSubmissionsPage({
    required String homeworkName,
    int start = 0,
    int pageSize = 30,
  });
  Future<ApiResult<HomeworkSubmissionDetail>> getSubmissionDetails(
    String submissionName,
  );
  Future<ApiResult<List<int>>> downloadAnswerFile({
    required String submissionName,
    required String questionName,
  });
  Future<ApiResult<HomeworkSubmissionDetail>> gradeSubmission(
    GradeSubmissionRequestData request,
  );
}
