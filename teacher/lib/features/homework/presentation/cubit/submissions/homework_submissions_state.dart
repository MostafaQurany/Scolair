import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/homework_submission.dart';

part 'homework_submissions_state.freezed.dart';

enum HomeworkSubmissionsStatus { initial, loading, success, failure }

enum SubmissionFilter { all, submitted, graded, late, needsGrading }

@freezed
abstract class HomeworkSubmissionsState with _$HomeworkSubmissionsState {
  const HomeworkSubmissionsState._();

  const factory HomeworkSubmissionsState({
    @Default(HomeworkSubmissionsStatus.initial) HomeworkSubmissionsStatus status,
    @Default([]) List<HomeworkSubmissionItem> submissions,
    String? errorMessage,
    @Default(SubmissionFilter.all) SubmissionFilter filter,
  }) = _HomeworkSubmissionsState;

  List<HomeworkSubmissionItem> get filteredSubmissions {
    switch (filter) {
      case SubmissionFilter.all:
        return submissions;
      case SubmissionFilter.submitted:
        return submissions.where((s) => s.status.toLowerCase() == 'submitted').toList();
      case SubmissionFilter.graded:
        return submissions.where((s) => s.status.toLowerCase() == 'graded').toList();
      case SubmissionFilter.late:
        return submissions.where((s) => s.isLate).toList();
      case SubmissionFilter.needsGrading:
        return submissions.where((s) => s.status.toLowerCase() != 'graded').toList();
    }
  }
}
