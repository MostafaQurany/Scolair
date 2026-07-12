import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/question_usecases.dart';
import 'question_form_state.dart';

class QuestionFormCubit extends Cubit<QuestionFormState> {
  QuestionFormCubit(this._createQuestionUseCase, this._updateQuestionUseCase)
    : super(const QuestionFormState.initial());

  final CreateQuestionUseCase _createQuestionUseCase;
  final UpdateQuestionUseCase _updateQuestionUseCase;

  Future<void> createQuestion(Map<String, dynamic> body) async {
    emit(const QuestionFormState.submitting());
    final result = await _createQuestionUseCase(body);
    result.when(
      success: (question) => emit(QuestionFormState.success(question)),
      failure: (failure) => emit(QuestionFormState.error(failure.message)),
    );
  }

  Future<void> updateQuestion(Map<String, dynamic> body) async {
    emit(const QuestionFormState.submitting());
    final result = await _updateQuestionUseCase(body);
    result.when(
      success: (question) => emit(QuestionFormState.success(question)),
      failure: (failure) => emit(QuestionFormState.error(failure.message)),
    );
  }
}
