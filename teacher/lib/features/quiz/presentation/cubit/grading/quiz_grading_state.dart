import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/quiz_models.dart';
import '../../../data/models/quiz_submission_models.dart';

part 'quiz_grading_state.freezed.dart';

enum QuizGradingStatus {
  initial,
  loading,
  success,
  failure,
  submitting,
  submittedSuccess,
}

@freezed
abstract class QuizGradingState with _$QuizGradingState {
  const QuizGradingState._();

  const factory QuizGradingState({
    @Default(QuizGradingStatus.initial) QuizGradingStatus status,
    QuizModel? quiz,
    QuizSubmissionItemModel? submission,
    String? errorMessage,
    @Default({}) Map<String, num> questionMarks,
  }) = _QuizGradingState;

  bool isValidMarks() {
    if (quiz == null) return false;
    for (final q in quiz!.questions) {
      if (q.type?.name == 'open_ended' || q.type?.name == 'file_upload') {
        final val = questionMarks[q.name] ?? 0;
        if (val < 0 || val > q.marks) return false;
      }
    }
    return true;
  }
}
