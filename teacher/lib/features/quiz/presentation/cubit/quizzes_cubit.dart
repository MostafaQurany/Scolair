import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/quiz_usecases.dart';
import 'quizzes_state.dart';

class QuizzesCubit extends Cubit<QuizzesState> {
  QuizzesCubit(this._listQuizzesUseCase, this._deleteQuizUseCase)
    : super(const QuizzesState());

  final ListQuizzesUseCase _listQuizzesUseCase;
  final DeleteQuizUseCase _deleteQuizUseCase;

  Future<void> loadQuizzes() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await _listQuizzesUseCase();
    result.when(
      success: (quizzes) =>
          emit(state.copyWith(isLoading: false, quizzes: quizzes)),
      failure: (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
    );
  }

  Future<void> deleteQuiz(String quizName) async {
    final result = await _deleteQuizUseCase(quizName);
    result.when(
      success: (_) => loadQuizzes(),
      failure: (failure) => emit(state.copyWith(errorMessage: failure.message)),
    );
  }
}
