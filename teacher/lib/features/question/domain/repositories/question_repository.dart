import '../../../../core/network/api_result.dart';
import '../../../../core/network/paginated_list.dart';
import '../../../quiz/data/models/quiz_models.dart';
import '../../data/models/question_filter_data.dart';

abstract class QuestionRepository {
  Future<ApiResult<PaginatedList<QuestionModel>>> listQuestions({
    QuestionFilterData filters = const QuestionFilterData(),
    int start = 0,
    int pageSize = 30,
  });

  Future<ApiResult<QuestionModel>> getQuestion(String questionName);
  Future<ApiResult<QuestionModel>> createQuestion(Map<String, dynamic> body);
  Future<ApiResult<QuestionModel>> updateQuestion(Map<String, dynamic> body);
  Future<ApiResult<void>> deleteQuestion(String questionName);
}
