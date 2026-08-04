import '../../../domain/entities/homework_submission.dart';

enum HomeworkGradingStatus {
  initial,
  loading,
  success,
  failure,
  submitting,
  downloading,
  submittedSuccess,
}

class HomeworkGradingState {
  const HomeworkGradingState({
    this.status = HomeworkGradingStatus.initial,
    this.submission,
    this.errorMessage,
    this.questionMarks = const {},
    this.questionNotes = const {},
    this.overallFeedback = '',
    this.downloadedFileBytes,
  });

  final HomeworkGradingStatus status;
  final HomeworkSubmissionDetail? submission;
  final String? errorMessage;
  final Map<String, num> questionMarks;
  final Map<String, String> questionNotes;
  final String overallFeedback;
  final List<int>? downloadedFileBytes;

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

  HomeworkGradingState copyWith({
    HomeworkGradingStatus? status,
    HomeworkSubmissionDetail? submission,
    String? errorMessage,
    Map<String, num>? questionMarks,
    Map<String, String>? questionNotes,
    String? overallFeedback,
    List<int>? downloadedFileBytes,
  }) {
    return HomeworkGradingState(
      status: status ?? this.status,
      submission: submission ?? this.submission,
      errorMessage: errorMessage ?? this.errorMessage,
      questionMarks: questionMarks ?? this.questionMarks,
      questionNotes: questionNotes ?? this.questionNotes,
      overallFeedback: overallFeedback ?? this.overallFeedback,
      downloadedFileBytes: downloadedFileBytes ?? this.downloadedFileBytes,
    );
  }
}
