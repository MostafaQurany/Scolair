import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/quiz_submission_models.dart';

part 'quiz_submissions_state.freezed.dart';

enum QuizSubmissionsStatus { initial, loading, success, failure }

enum QuizSubmissionFilter { all, needsGrading }

@freezed
abstract class QuizSubmissionsState with _$QuizSubmissionsState {
  const QuizSubmissionsState._();

  const factory QuizSubmissionsState({
    @Default(QuizSubmissionsStatus.initial) QuizSubmissionsStatus status,
    @Default([]) List<QuizSubmissionItemModel> submissions,
    String? errorMessage,
    @Default(QuizSubmissionFilter.all) QuizSubmissionFilter filter,
  }) = _QuizSubmissionsState;

  List<QuizSubmissionItemModel> get filteredSubmissions {
    switch (filter) {
      case QuizSubmissionFilter.all:
        return submissions;
      case QuizSubmissionFilter.needsGrading:
        return submissions.where((s) => s.requiresManualGrading).toList();
    }
  }
}
