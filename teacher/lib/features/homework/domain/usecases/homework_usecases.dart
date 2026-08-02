import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../data/models/homework_mutation_models.dart';
import '../../data/models/list_homeworks_request_data.dart';
import '../../data/models/homework_models.dart';
import '../entities/homework_detail.dart';
import '../entities/homework_list_item.dart';
import '../entities/homework_submission.dart';
import '../repositories/homework_repository.dart';

class ListHomeworkUseCase {
  const ListHomeworkUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<List<HomeworkModel>>> call() => _repository.listHomework();
}

class ListHomeworkPageUseCase {
  const ListHomeworkPageUseCase(this._repository);
  final HomeworkRepository _repository;

  Future<ApiResult<PaginatedList<HomeworkListItem>>> call({
    required int start,
    required int pageSize,
    required HomeworkPublishedFilter publishedFilter,
    String? course,
    String? chapter,
    String? lesson,
  }) => _repository.listHomeworkPage(
    ListHomeworksRequestData(
      start: start,
      pageSize: pageSize,
      publishedFilter: publishedFilter,
      course: course,
      chapter: chapter,
      lesson: lesson,
    ),
  );
}

class CreateHomeworkUseCase {
  const CreateHomeworkUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<HomeworkModel>> call(HomeworkModel homework) =>
      _repository.createHomework(homework);
}

class UpdateHomeworkUseCase {
  const UpdateHomeworkUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<HomeworkModel>> call(HomeworkModel homework) =>
      _repository.updateHomework(homework);
}

class DeleteHomeworkUseCase {
  const DeleteHomeworkUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<void>> call(String id) => _repository.deleteHomework(id);
}

class DuplicateHomeworkUseCase {
  const DuplicateHomeworkUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<HomeworkModel>> call(String id) =>
      _repository.duplicateHomework(id);
}

class GetHomeworkDetailsUseCase {
  const GetHomeworkDetailsUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<HomeworkDetail>> call(String homeworkName) =>
      _repository.getHomeworkDetails(homeworkName);
}

class CreateHomeworkRemoteUseCase {
  const CreateHomeworkRemoteUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<HomeworkDetail>> call(CreateHomeworkRequestData request) =>
      _repository.createHomeworkRemote(request);
}

class UpdateHomeworkRemoteUseCase {
  const UpdateHomeworkRemoteUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<HomeworkDetail>> call(UpdateHomeworkRequestData request) =>
      _repository.updateHomeworkRemote(request);
}

class AddHomeworkQuestionUseCase {
  const AddHomeworkQuestionUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<void>> call({
    required String homeworkName,
    required String questionName,
    required int marks,
  }) => _repository.addQuestion(
    homeworkName: homeworkName,
    questionName: questionName,
    marks: marks,
  );
}

class RemoveHomeworkQuestionUseCase {
  const RemoveHomeworkQuestionUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<void>> call({
    required String homeworkName,
    required String questionName,
  }) => _repository.removeQuestion(
    homeworkName: homeworkName,
    questionName: questionName,
  );
}

class GetHomeworkSubmissionsUseCase {
  const GetHomeworkSubmissionsUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<PaginatedList<HomeworkSubmissionItem>>> call({
    required String homeworkName,
    int start = 0,
    int pageSize = 30,
  }) => _repository.getSubmissionsPage(
    homeworkName: homeworkName,
    start: start,
    pageSize: pageSize,
  );
}

class GetSubmissionDetailsUseCase {
  const GetSubmissionDetailsUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<HomeworkSubmissionDetail>> call(String submissionName) =>
      _repository.getSubmissionDetails(submissionName);
}

class DownloadAnswerFileUseCase {
  const DownloadAnswerFileUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<List<int>>> call({
    required String submissionName,
    required String questionName,
  }) => _repository.downloadAnswerFile(
    submissionName: submissionName,
    questionName: questionName,
  );
}

class GradeSubmissionUseCase {
  const GradeSubmissionUseCase(this._repository);
  final HomeworkRepository _repository;
  Future<ApiResult<HomeworkSubmissionDetail>> call(
    GradeSubmissionRequestData request,
  ) => _repository.gradeSubmission(request);
}
