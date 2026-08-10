import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/api_result.dart';
import '../../../domain/usecases/quiz_submissions_usecases.dart';
import 'quiz_submissions_state.dart';

class QuizSubmissionsCubit extends Cubit<QuizSubmissionsState> {
  QuizSubmissionsCubit(this._getSubmissionsUseCase)
    : super(const QuizSubmissionsState());

  final GetQuizSubmissionsUseCase _getSubmissionsUseCase;

  Future<void> fetchSubmissions(String quizName) async {
    emit(state.copyWith(status: QuizSubmissionsStatus.loading));

    final result = await _getSubmissionsUseCase(
      quizName: quizName,
      pageSize: 100, // Load up to 100
    );

    switch (result) {
      case ApiSuccess(data: final paginatedList):
        emit(
          state.copyWith(
            status: QuizSubmissionsStatus.success,
            submissions: paginatedList.items,
          ),
        );
      case ApiFailure(error: final error):
        emit(
          state.copyWith(
            status: QuizSubmissionsStatus.failure,
            errorMessage: error.message,
          ),
        );
    }
  }

  void setFilter(QuizSubmissionFilter filter) {
    emit(state.copyWith(filter: filter));
  }
}
