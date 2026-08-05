import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/api_result.dart';
import '../../../domain/usecases/homework_usecases.dart';
import 'homework_submissions_state.dart';

class HomeworkSubmissionsCubit extends Cubit<HomeworkSubmissionsState> {
  HomeworkSubmissionsCubit(this._getSubmissionsUseCase)
      : super(const HomeworkSubmissionsState());

  final GetHomeworkSubmissionsUseCase _getSubmissionsUseCase;

  void setFilter(SubmissionFilter filter) {
    if (state.filter == filter) return;
    emit(state.copyWith(filter: filter));
  }

  Future<void> loadSubmissions(String homeworkName) async {
    emit(
      state.copyWith(
        status: HomeworkSubmissionsStatus.loading,
      ),
    );

    final result = await _getSubmissionsUseCase(
      homeworkName: homeworkName,
      pageSize: 100,
    );
    switch (result) {
      case ApiSuccess(data: final page):
        emit(
          state.copyWith(
            status: HomeworkSubmissionsStatus.success,
            submissions: page.items,
          ),
        );
      case ApiFailure(error: final error):
        emit(
          state.copyWith(
            status: HomeworkSubmissionsStatus.failure,
            errorMessage: error.message,
          ),
        );
    }
  }
}
