import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/quiz_usecases.dart';
import 'quiz_form_state.dart';

class QuizFormCubit extends Cubit<QuizFormState> {
  QuizFormCubit(this._createQuizUseCase, this._updateQuizUseCase)
    : super(const QuizFormState.initial());

  final CreateQuizUseCase _createQuizUseCase;
  final UpdateQuizUseCase _updateQuizUseCase;

  Future<void> createQuiz(Map<String, dynamic> body) async {
    emit(const QuizFormState.submitting());
    final result = await _createQuizUseCase(body);
    result.when(
      success: (_) => emit(const QuizFormState.success()),
      failure: (failure) => emit(QuizFormState.error(failure.message)),
    );
  }

  Future<void> updateQuiz(Map<String, dynamic> body) async {
    emit(const QuizFormState.submitting());
    final result = await _updateQuizUseCase(body);
    result.when(
      success: (_) => emit(const QuizFormState.success()),
      failure: (failure) => emit(QuizFormState.error(failure.message)),
    );
  }
}
