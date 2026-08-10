import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../data/models/quiz_submission_models.dart';
import '../repositories/quiz_repository.dart';

class GetQuizSubmissionsUseCase {
  const GetQuizSubmissionsUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<PaginatedList<QuizSubmissionItemModel>>> call({
    String? quizName,
    bool? pendingGrading,
    int start = 0,
    int pageSize = 30,
  }) => _repository.getQuizSubmissions(
    quizName: quizName,
    pendingGrading: pendingGrading,
    start: start,
    pageSize: pageSize,
  );
}

class GetStudentQuizSubmissionsUseCase {
  const GetStudentQuizSubmissionsUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<PaginatedList<QuizSubmissionItemModel>>> call({
    String? member,
    String? quizName,
    bool? pendingGrading,
    int start = 0,
    int pageSize = 30,
  }) => _repository.getStudentQuizSubmissions(
    member: member,
    quizName: quizName,
    pendingGrading: pendingGrading,
    start: start,
    pageSize: pageSize,
  );
}

class GradeQuizSubmissionUseCase {
  const GradeQuizSubmissionUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<GradeQuizSubmissionResponseData>> call({
    required String submissionName,
    required Map<String, dynamic> questionMarks,
  }) => _repository.gradeQuizSubmission(
    submissionName: submissionName,
    questionMarks: questionMarks,
  );
}
