import '../../../../core/network/api_result.dart';
import '../../data/models/quiz_models.dart';
import '../repositories/quiz_repository.dart';

class ListQuizzesUseCase {
  const ListQuizzesUseCase(this._repository);
  final QuizRepository _repository;
  Future<ApiResult<List<QuizModel>>> call() => _repository.listQuizzes();
}

class GetQuizUseCase {
  const GetQuizUseCase(this._repository);
  final QuizRepository _repository;
  Future<ApiResult<QuizModel>> call(String id) => _repository.getQuiz(id);
}

class CreateQuizUseCase {
  const CreateQuizUseCase(this._repository);
  final QuizRepository _repository;
  Future<ApiResult<QuizModel>> call(QuizModel quiz) =>
      _repository.createQuiz(quiz);
}

class UpdateQuizUseCase {
  const UpdateQuizUseCase(this._repository);
  final QuizRepository _repository;
  Future<ApiResult<QuizModel>> call(QuizModel quiz) =>
      _repository.updateQuiz(quiz);
}

class DeleteQuizUseCase {
  const DeleteQuizUseCase(this._repository);
  final QuizRepository _repository;
  Future<ApiResult<void>> call(String id) => _repository.deleteQuiz(id);
}

class CreateQuestionUseCase {
  const CreateQuestionUseCase(this._repository);
  final QuizRepository _repository;
  Future<ApiResult<QuizModel>> call(String quizId, QuestionModel question) =>
      _repository.createQuestion(quizId, question);
}

class UpdateQuestionUseCase {
  const UpdateQuestionUseCase(this._repository);
  final QuizRepository _repository;
  Future<ApiResult<QuizModel>> call(String quizId, QuestionModel question) =>
      _repository.updateQuestion(quizId, question);
}

class DeleteQuestionUseCase {
  const DeleteQuestionUseCase(this._repository);
  final QuizRepository _repository;
  Future<ApiResult<QuizModel>> call(String quizId, String questionId) =>
      _repository.deleteQuestion(quizId, questionId);
}
