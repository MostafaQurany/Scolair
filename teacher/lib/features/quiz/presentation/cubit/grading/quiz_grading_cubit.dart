import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/api_result.dart';
import '../../../domain/usecases/quiz_submissions_usecases.dart';
import '../../../domain/usecases/quiz_usecases.dart';
import '../../../data/models/quiz_submission_models.dart';
import 'quiz_grading_state.dart';

class QuizGradingCubit extends Cubit<QuizGradingState> {
  QuizGradingCubit(this._getQuizUseCase, this._gradeQuizSubmissionUseCase)
    : super(const QuizGradingState());

  final GetQuizUseCase _getQuizUseCase;
  final GradeQuizSubmissionUseCase _gradeQuizSubmissionUseCase;

  Future<void> loadSubmission(
    String quizName,
    QuizSubmissionItemModel submission,
  ) async {
    emit(
      state.copyWith(status: QuizGradingStatus.loading, submission: submission),
    );

    final result = await _getQuizUseCase(quizName);
    switch (result) {
      case ApiSuccess(data: final quiz):
        final initialMarks = <String, num>{};
        for (final q in quiz.questions) {
          if (q.type?.name == 'open_ended' || q.type?.name == 'file_upload') {
            initialMarks[q.name] =
                0; // Default to 0, since we don't know the current marks
          }
        }
        emit(
          state.copyWith(
            status: QuizGradingStatus.success,
            quiz: quiz,
            questionMarks: initialMarks,
          ),
        );
      case ApiFailure(error: final error):
        emit(
          state.copyWith(
            status: QuizGradingStatus.failure,
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

  Future<void> submitGrade() async {
    final sub = state.submission;
    if (sub == null || !state.isValidMarks()) return;

    emit(state.copyWith(status: QuizGradingStatus.submitting));

    final questionMarksPayload = <String, dynamic>{};
    for (final q in state.quiz!.questions) {
      if (q.type?.name == 'open_ended' || q.type?.name == 'file_upload') {
        final m = state.questionMarks[q.name] ?? 0;
        questionMarksPayload[q.name] = {'marks': m};
      }
    }

    final result = await _gradeQuizSubmissionUseCase(
      submissionName: sub.name,
      questionMarks: questionMarksPayload,
    );

    switch (result) {
      case ApiSuccess(data: final _):
        emit(state.copyWith(status: QuizGradingStatus.submittedSuccess));
      case ApiFailure(error: final error):
        emit(
          state.copyWith(
            status: QuizGradingStatus.failure,
            errorMessage: error.message,
          ),
        );
    }
  }
}
