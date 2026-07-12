import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/paginated_list.dart';
import '../../data/models/quiz_models.dart';

part 'quizzes_state.freezed.dart';

@freezed
abstract class QuizzesState with _$QuizzesState {
  const factory QuizzesState({
    @Default(true) bool isLoading,
    PaginatedList<QuizSummaryModel>? quizzes,
    String? errorMessage,
  }) = _QuizzesState;
}
