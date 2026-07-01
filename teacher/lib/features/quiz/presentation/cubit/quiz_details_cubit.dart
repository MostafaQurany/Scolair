import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/quiz_models.dart';
import '../../domain/usecases/quiz_usecases.dart';
import 'quiz_details_state.dart';

class QuizDetailsCubit extends Cubit<QuizDetailsState> {
  QuizDetailsCubit(
    this._getQuizUseCase,
    this._createQuestionUseCase,
    this._updateQuestionUseCase,
    this._deleteQuestionUseCase,
  ) : super(const QuizDetailsState());

  final GetQuizUseCase _getQuizUseCase;
  final CreateQuestionUseCase _createQuestionUseCase;
  final UpdateQuestionUseCase _updateQuestionUseCase;
  final DeleteQuestionUseCase _deleteQuestionUseCase;

  Future<void> loadQuiz(String quizId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _getQuizUseCase(quizId);
    result.when(
      success: (quiz) => emit(state.copyWith(isLoading: false, quiz: quiz)),
      failure: (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
    );
  }

  Future<void> addQuestion(QuestionModel question) async {
    final quiz = state.quiz;
    if (quiz == null) return;
    final result = await _createQuestionUseCase(quiz.id, question);
    result.when(
      success: (updated) => emit(state.copyWith(quiz: updated)),
      failure: (failure) =>
          emit(state.copyWith(mutationError: failure.message)),
    );
  }

  Future<void> updateQuestion(QuestionModel question) async {
    final quiz = state.quiz;
    if (quiz == null) return;
    final result = await _updateQuestionUseCase(quiz.id, question);
    result.when(
      success: (updated) => emit(state.copyWith(quiz: updated)),
      failure: (failure) =>
          emit(state.copyWith(mutationError: failure.message)),
    );
  }

  Future<void> deleteQuestion(String questionId) async {
    final quiz = state.quiz;
    if (quiz == null) return;
    final result = await _deleteQuestionUseCase(quiz.id, questionId);
    result.when(
      success: (updated) => emit(state.copyWith(quiz: updated)),
      failure: (failure) =>
          emit(state.copyWith(mutationError: failure.message)),
    );
  }

  Future<void> duplicateQuestion(QuestionModel question) async {
    final duplicated = QuestionModel(
      id: 'q_${DateTime.now().microsecondsSinceEpoch}',
      type: question.type,
      text: question.text,
      points: question.points,
      difficulty: question.difficulty,
      required: question.required,
      options: question.options,
      correctBoolAnswer: question.correctBoolAnswer,
      acceptedAnswer: question.acceptedAnswer,
      explanation: question.explanation,
    );
    await addQuestion(duplicated);
  }
}
