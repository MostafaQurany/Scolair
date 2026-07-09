import '../../../../../core/network/api_client.dart';
import '../../../../quiz/data/models/quiz_models.dart';
import '../../models/question_filter_data.dart';

abstract class QuestionRemoteDataSource {
  Future<ListQuestionsResponseData> listQuestions({
    QuestionFilterData filters = const QuestionFilterData(),
    int start = 0,
    int pageSize = 30,
  });

  Future<GetQuestionResponseData> getQuestion(String questionName);
  Future<CreateQuestionResponseData> createQuestion(Map<String, dynamic> body);
  Future<UpdateQuestionResponseData> updateQuestion(Map<String, dynamic> body);
  Future<DeleteQuestionResponseData> deleteQuestion(String questionName);
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  const QuestionRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<ListQuestionsResponseData> listQuestions({
    QuestionFilterData filters = const QuestionFilterData(),
    int start = 0,
    int pageSize = 30,
  }) {
    return _apiClient.listQuestions(
      apiQuestionTypeValue(filters.type),
      filters.quiz,
      filters.homework,
      filters.lesson,
      filters.chapter,
      filters.course,
      start,
      pageSize,
    );
  }

  @override
  Future<GetQuestionResponseData> getQuestion(String questionName) =>
      _apiClient.getQuestion(questionName);

  @override
  Future<CreateQuestionResponseData> createQuestion(
    Map<String, dynamic> body,
  ) => _apiClient.createQuestion(body);

  @override
  Future<UpdateQuestionResponseData> updateQuestion(
    Map<String, dynamic> body,
  ) => _apiClient.updateQuestion(body);

  @override
  Future<DeleteQuestionResponseData> deleteQuestion(String questionName) =>
      _apiClient.deleteQuestion(questionName);
}
