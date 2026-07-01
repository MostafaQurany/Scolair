import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/quiz_models.dart';
import '../../domain/usecases/quiz_usecases.dart';
import 'question_form_state.dart';

class QuestionFormCubit extends Cubit<QuestionFormState> {
  QuestionFormCubit(this._createQuestionUseCase, this._updateQuestionUseCase)
    : super(const QuestionFormState.initial());

  final CreateQuestionUseCase _createQuestionUseCase;
  final UpdateQuestionUseCase _updateQuestionUseCase;

  Future<void> createQuestion(String quizId, QuestionModel question) async {
    emit(const QuestionFormState.submitting());
    final result = await _createQuestionUseCase(quizId, question);
    result.when(
      success: (_) => emit(const QuestionFormState.success()),
      failure: (failure) => emit(QuestionFormState.error(failure.message)),
    );
  }

  Future<void> updateQuestion(String quizId, QuestionModel question) async {
    emit(const QuestionFormState.submitting());
    final result = await _updateQuestionUseCase(quizId, question);
    result.when(
      success: (_) => emit(const QuestionFormState.success()),
      failure: (failure) => emit(QuestionFormState.error(failure.message)),
    );
  }
}
