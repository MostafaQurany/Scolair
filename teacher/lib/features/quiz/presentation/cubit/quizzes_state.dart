import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/quiz_models.dart';

part 'quizzes_state.freezed.dart';

@freezed
abstract class QuizzesState with _$QuizzesState {
  const factory QuizzesState({
    @Default(true) bool isLoading,
    QuizType? typeFilter,
    List<QuizModel>? quizzes,
    String? errorMessage,
  }) = _QuizzesState;
}
