import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/quiz_models.dart';

part 'quiz_details_state.freezed.dart';

@freezed
abstract class QuizDetailsState with _$QuizDetailsState {
  const factory QuizDetailsState({
    @Default(true) bool isLoading,
    @Default(false) bool isUpdating,
    @Default(false) bool isBatchSaving,
    @Default(0) int batchDeleteTotal,
    @Default(0) int batchDeleteCompleted,
    @Default([]) List<String> batchDeleteFailures,
    QuizModel? quiz,
    String? errorMessage,
    String? mutationError,
  }) = _QuizDetailsState;
}
