import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../data/models/quiz_models.dart';
import '../repositories/quiz_repository.dart';

// --- Question Use Cases ---

class ListQuestionsUseCase {
  const ListQuestionsUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<PaginatedList<QuestionModel>>> call({
    String? type,
    int start = 0,
    int pageSize = 30,
  }) => _repository.listQuestions(type: type, start: start, pageSize: pageSize);
}

class GetQuestionUseCase {
  const GetQuestionUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<QuestionModel>> call(String questionName) =>
      _repository.getQuestion(questionName);
}

class CreateQuestionUseCase {
  const CreateQuestionUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<QuestionModel>> call(Map<String, dynamic> body) =>
      _repository.createQuestion(body);
}

class UpdateQuestionUseCase {
  const UpdateQuestionUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<QuestionModel>> call(Map<String, dynamic> body) =>
      _repository.updateQuestion(body);
}

class DeleteQuestionUseCase {
  const DeleteQuestionUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<void>> call(String questionName) =>
      _repository.deleteQuestion(questionName);
}

// --- Quiz Use Cases ---

class ListQuizzesUseCase {
  const ListQuizzesUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<PaginatedList<QuizSummaryModel>>> call({
    int start = 0,
    int pageSize = 30,
  }) =>
      _repository.listQuizzes(start: start, pageSize: pageSize);
}

class GetQuizUseCase {
  const GetQuizUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<QuizModel>> call(String quizName) =>
      _repository.getQuiz(quizName);
}

class CreateQuizUseCase {
  const CreateQuizUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<QuizModel>> call(Map<String, dynamic> body) =>
      _repository.createQuiz(body);
}

class UpdateQuizUseCase {
  const UpdateQuizUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<QuizModel>> call(Map<String, dynamic> body) =>
      _repository.updateQuiz(body);
}

class DeleteQuizUseCase {
  const DeleteQuizUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<void>> call(String quizName) =>
      _repository.deleteQuiz(quizName);
}

// --- Quiz-Question Link Use Cases ---

class AddQuestionToQuizUseCase {
  const AddQuestionToQuizUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<QuizModel>> call({
    required String quiz,
    required String question,
    required int marks,
  }) => _repository.addQuestionToQuiz(
    quiz: quiz,
    question: question,
    marks: marks,
  );
}

class RemoveQuestionFromQuizUseCase {
  const RemoveQuestionFromQuizUseCase(this._repository);
  final QuizRepository _repository;

  Future<ApiResult<QuizModel>> call({
    required String quiz,
    required String question,
  }) => _repository.removeQuestionFromQuiz(quiz: quiz, question: question);
}
