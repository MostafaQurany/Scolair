import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/api_result.dart';
import '../../../data/models/homework_mutation_models.dart';
import '../../../domain/usecases/homework_usecases.dart';
import 'homework_grading_state.dart';

class HomeworkGradingCubit extends Cubit<HomeworkGradingState> {
  HomeworkGradingCubit(
    this._getDetailsUseCase,
    this._gradeUseCase,
    this._downloadUseCase,
  ) : super(const HomeworkGradingState());

  final GetSubmissionDetailsUseCase _getDetailsUseCase;
  final GradeSubmissionUseCase _gradeUseCase;
  final DownloadAnswerFileUseCase _downloadUseCase;

  Future<void> loadSubmission(String submissionName) async {
    emit(
      state.copyWith(status: HomeworkGradingStatus.loading),
    );

    final result = await _getDetailsUseCase(submissionName);
    switch (result) {
      case ApiSuccess(data: final sub):
        final initialMarks = <String, num>{};
        final initialNotes = <String, String>{};
        for (final q in sub.questions) {
          if (q.isManualGraded) {
            initialMarks[q.question] = q.marksAwarded ?? 0;
            if (q.note != null && q.note!.isNotEmpty) {
              initialNotes[q.question] = q.note!;
            }
          }
        }
        emit(
          state.copyWith(
            status: HomeworkGradingStatus.success,
            submission: sub,
            questionMarks: initialMarks,
            questionNotes: initialNotes,
            overallFeedback: sub.feedback ?? '',
          ),
        );
      case ApiFailure(error: final error):
        emit(
          state.copyWith(
            status: HomeworkGradingStatus.failure,
            errorMessage: error.message,
          ),
        );
    }
  }

  void setMark(String questionName, num mark, num maxMark) {
    if (mark < 0 || mark > maxMark) return;
    final updated = Map<String, num>.from(state.questionMarks);
    updated[questionName] = mark;
    emit(state.copyWith(questionMarks: updated));
  }

  void setNote(String questionName, String note) {
    final updated = Map<String, String>.from(state.questionNotes);
    updated[questionName] = note;
    emit(state.copyWith(questionNotes: updated));
  }

  void setFeedback(String feedback) {
    emit(state.copyWith(overallFeedback: feedback));
  }

  Future<void> submitGrade() async {
    final sub = state.submission;
    if (sub == null || !state.isValidMarks()) return;

    emit(
      state.copyWith(
        status: HomeworkGradingStatus.submitting,
      ),
    );

    final questionMarksPayload = <String, GradeQuestionMarkItem>{};
    for (final q in sub.questions) {
      if (q.isManualGraded) {
        final m = state.questionMarks[q.question] ?? 0;
        final n = state.questionNotes[q.question];
        questionMarksPayload[q.question] = GradeQuestionMarkItem(
          marks: m,
          note: n,
        );
      }
    }

    final request = GradeSubmissionRequestData(
      submissionName: sub.name,
      questionMarks: questionMarksPayload,
      feedback: state.overallFeedback.isEmpty ? null : state.overallFeedback,
    );

    final result = await _gradeUseCase(request);
    switch (result) {
      case ApiSuccess(data: final updated):
        emit(
          state.copyWith(
            status: HomeworkGradingStatus.submittedSuccess,
            submission: updated,
          ),
        );
      case ApiFailure(error: final error):
        emit(
          state.copyWith(
            status: HomeworkGradingStatus.failure,
            errorMessage: error.message,
          ),
        );
    }
  }

  Future<void> downloadFile(String questionName) async {
    final sub = state.submission;
    if (sub == null) return;

    emit(
      state.copyWith(
        status: HomeworkGradingStatus.downloading,
      ),
    );

    final result = await _downloadUseCase(
      submissionName: sub.name,
      questionName: questionName,
    );
    switch (result) {
      case ApiSuccess(data: final bytes):
        emit(
          state.copyWith(
            status: HomeworkGradingStatus.success,
            downloadedFileBytes: bytes,
          ),
        );
      case ApiFailure(error: final error):
        emit(
          state.copyWith(
            status: HomeworkGradingStatus.failure,
            errorMessage: error.message,
          ),
        );
    }
  }
}
