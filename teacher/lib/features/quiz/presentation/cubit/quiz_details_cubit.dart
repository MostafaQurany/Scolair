import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/quiz_usecases.dart';
import 'quiz_details_state.dart';

class QuizDetailsCubit extends Cubit<QuizDetailsState> {
  QuizDetailsCubit(
    this._getQuizUseCase,
    this._updateQuizUseCase,
    this._addQuestionToQuizUseCase,
    this._removeQuestionFromQuizUseCase,
  ) : super(const QuizDetailsState());

  final GetQuizUseCase _getQuizUseCase;
  final UpdateQuizUseCase _updateQuizUseCase;
  final AddQuestionToQuizUseCase _addQuestionToQuizUseCase;
  final RemoveQuestionFromQuizUseCase _removeQuestionFromQuizUseCase;

  Future<void> loadQuiz(String quizName) async {
    emit(
      state.copyWith(isLoading: true, errorMessage: null, mutationError: null),
    );
    final result = await _getQuizUseCase(quizName);
    result.when(
      success: (quiz) => emit(
        state.copyWith(isLoading: false, quiz: quiz, mutationError: null),
      ),
      failure: (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          mutationError: null,
        ),
      ),
    );
  }

  Future<void> addQuestion({
    required String questionName,
    required int marks,
  }) async {
    final quiz = state.quiz;
    if (quiz == null) return;
    emit(state.copyWith(isUpdating: true, mutationError: null));
    final result = await _addQuestionToQuizUseCase(
      quiz: quiz.name,
      question: questionName,
      marks: marks,
    );
    result.when(
      success: (updated) => emit(
        state.copyWith(isUpdating: false, quiz: updated, mutationError: null),
      ),
      failure: (failure) => emit(
        state.copyWith(isUpdating: false, mutationError: failure.message),
      ),
    );
  }

  Future<void> removeQuestion(String questionName) async {
    final quiz = state.quiz;
    if (quiz == null) return;
    emit(state.copyWith(isUpdating: true, mutationError: null));
    final result = await _removeQuestionFromQuizUseCase(
      quiz: quiz.name,
      question: questionName,
    );
    result.when(
      success: (updated) => emit(
        state.copyWith(isUpdating: false, quiz: updated, mutationError: null),
      ),
      failure: (failure) => emit(
        state.copyWith(isUpdating: false, mutationError: failure.message),
      ),
    );
  }

  Future<void> updateSettings(Map<String, dynamic> settings) async {
    final quiz = state.quiz;
    if (quiz == null) return;

    // Add the quiz name and title to the body so the API knows which quiz to update
    final body = {'quiz': quiz.name, 'title': quiz.title, ...settings};

    emit(
      state.copyWith(isUpdating: true, errorMessage: null, mutationError: null),
    );
    final result = await _updateQuizUseCase(body);
    result.when(
      success: (updated) => emit(
        state.copyWith(isUpdating: false, quiz: updated, mutationError: null),
      ),
      failure: (failure) => emit(
        state.copyWith(isUpdating: false, mutationError: failure.message),
      ),
    );
  }
}
