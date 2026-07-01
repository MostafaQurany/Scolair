import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/quiz_models.dart';
import '../../domain/usecases/quiz_usecases.dart';
import 'quizzes_state.dart';

class QuizzesCubit extends Cubit<QuizzesState> {
  QuizzesCubit(this._listQuizzesUseCase) : super(const QuizzesState());

  final ListQuizzesUseCase _listQuizzesUseCase;

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

  void filterByType(QuizType? type) {
    emit(state.copyWith(typeFilter: type));
  }
}
