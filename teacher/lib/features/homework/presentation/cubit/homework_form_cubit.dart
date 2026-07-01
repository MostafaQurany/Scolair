import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/homework_models.dart';
import '../../domain/usecases/homework_usecases.dart';
import 'homework_form_state.dart';

class HomeworkFormCubit extends Cubit<HomeworkFormState> {
  HomeworkFormCubit(this._createHomeworkUseCase, this._updateHomeworkUseCase)
    : super(const HomeworkFormState.initial());

  final CreateHomeworkUseCase _createHomeworkUseCase;
  final UpdateHomeworkUseCase _updateHomeworkUseCase;

  Future<void> createHomework(HomeworkModel homework) async {
    emit(const HomeworkFormState.submitting());
    final result = await _createHomeworkUseCase(homework);
    result.when(
      success: (_) => emit(const HomeworkFormState.success()),
      failure: (failure) => emit(HomeworkFormState.error(failure.message)),
    );
  }

  Future<void> updateHomework(HomeworkModel homework) async {
    emit(const HomeworkFormState.submitting());
    final result = await _updateHomeworkUseCase(homework);
    result.when(
      success: (_) => emit(const HomeworkFormState.success()),
      failure: (failure) => emit(HomeworkFormState.error(failure.message)),
    );
  }
}
