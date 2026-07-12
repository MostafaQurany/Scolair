import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../../quiz/data/models/quiz_models.dart';
import '../../data/models/question_filter_data.dart';
import '../repositories/question_repository.dart';

class ListQuestionsUseCase {
  const ListQuestionsUseCase(this._repository);
  final QuestionRepository _repository;

  Future<ApiResult<PaginatedList<QuestionModel>>> call({
    QuestionFilterData filters = const QuestionFilterData(),
    int start = 0,
    int pageSize = 30,
  }) => _repository.listQuestions(
    filters: filters,
    start: start,
    pageSize: pageSize,
  );
}

class GetQuestionUseCase {
  const GetQuestionUseCase(this._repository);
  final QuestionRepository _repository;

  Future<ApiResult<QuestionModel>> call(String questionName) =>
      _repository.getQuestion(questionName);
}

class CreateQuestionUseCase {
  const CreateQuestionUseCase(this._repository);
  final QuestionRepository _repository;

  Future<ApiResult<QuestionModel>> call(Map<String, dynamic> body) =>
      _repository.createQuestion(body);
}

class UpdateQuestionUseCase {
  const UpdateQuestionUseCase(this._repository);
  final QuestionRepository _repository;

  Future<ApiResult<QuestionModel>> call(Map<String, dynamic> body) =>
      _repository.updateQuestion(body);
}

class DeleteQuestionUseCase {
  const DeleteQuestionUseCase(this._repository);
  final QuestionRepository _repository;

  Future<ApiResult<void>> call(String questionName) =>
      _repository.deleteQuestion(questionName);
}
