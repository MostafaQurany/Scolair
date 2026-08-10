import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/homework_submission.dart';

part 'homework_grading_state.freezed.dart';

enum HomeworkGradingStatus {
  initial,
  loading,
  success,
  failure,
  submitting,
  downloading,
  submittedSuccess,
}

@freezed
abstract class HomeworkGradingState with _$HomeworkGradingState {
  const HomeworkGradingState._();

  const factory HomeworkGradingState({
    @Default(HomeworkGradingStatus.initial) HomeworkGradingStatus status,
    HomeworkSubmissionDetail? submission,
    String? errorMessage,
    @Default({}) Map<String, num> questionMarks,
    @Default({}) Map<String, String> questionNotes,
    @Default('') String overallFeedback,
    List<int>? downloadedFileBytes,
  }) = _HomeworkGradingState;

  bool isValidMarks() {
    if (submission == null) return false;
    for (final q in submission!.questions) {
      if (q.isManualGraded) {
        final val = questionMarks[q.question] ?? 0;
        if (val < 0 || val > q.maxMarks) return false;
      }
    }
    return true;
  }
}
