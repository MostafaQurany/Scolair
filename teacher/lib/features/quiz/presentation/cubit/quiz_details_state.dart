import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/quiz_models.dart';

part 'quiz_details_state.freezed.dart';

@freezed
abstract class QuizDetailsState with _$QuizDetailsState {
  const factory QuizDetailsState({
    @Default(true) bool isLoading,
    QuizModel? quiz,
    String? errorMessage,
    String? mutationError,
  }) = _QuizDetailsState;
}
