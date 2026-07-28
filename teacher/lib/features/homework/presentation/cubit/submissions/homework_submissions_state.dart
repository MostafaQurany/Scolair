import '../../../domain/entities/homework_submission.dart';

enum HomeworkSubmissionsStatus { initial, loading, success, failure }

enum SubmissionFilter { all, submitted, graded, late, needsGrading }

class HomeworkSubmissionsState {
  const HomeworkSubmissionsState({
    this.status = HomeworkSubmissionsStatus.initial,
    this.submissions = const [],
    this.errorMessage,
    this.filter = SubmissionFilter.all,
  });

  final HomeworkSubmissionsStatus status;
  final List<HomeworkSubmissionItem> submissions;
  final String? errorMessage;
  final SubmissionFilter filter;

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

  HomeworkSubmissionsState copyWith({
    HomeworkSubmissionsStatus? status,
    List<HomeworkSubmissionItem>? submissions,
    String? errorMessage,
    SubmissionFilter? filter,
  }) {
    return HomeworkSubmissionsState(
      status: status ?? this.status,
      submissions: submissions ?? this.submissions,
      errorMessage: errorMessage ?? this.errorMessage,
      filter: filter ?? this.filter,
    );
  }
}
