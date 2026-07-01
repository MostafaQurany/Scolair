import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/quiz_models.dart';
import '../../domain/usecases/quiz_usecases.dart';
import 'quiz_form_state.dart';

class QuizFormCubit extends Cubit<QuizFormState> {
  QuizFormCubit(this._createQuizUseCase, this._updateQuizUseCase)
    : super(const QuizFormState.initial());

  final CreateQuizUseCase _createQuizUseCase;
  final UpdateQuizUseCase _updateQuizUseCase;

  Future<void> createQuiz(QuizModel quiz) async {
    emit(const QuizFormState.submitting());
    final result = await _createQuizUseCase(quiz);
    result.when(
      success: (_) => emit(const QuizFormState.success()),
      failure: (failure) => emit(QuizFormState.error(failure.message)),
    );
  }

  Future<void> updateQuiz(QuizModel quiz) async {
    emit(const QuizFormState.submitting());
    final result = await _updateQuizUseCase(quiz);
    result.when(
      success: (_) => emit(const QuizFormState.success()),
      failure: (failure) => emit(QuizFormState.error(failure.message)),
    );
  }
}
