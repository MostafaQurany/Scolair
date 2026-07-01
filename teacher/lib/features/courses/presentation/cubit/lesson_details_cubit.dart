import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/courses_usecases.dart';
import 'lesson_details_state.dart';

class LessonDetailsCubit extends Cubit<LessonDetailsState> {
  LessonDetailsCubit(this._getLessonUseCase, this._deleteLessonUseCase)
    : super(const LessonDetailsState());

  final GetLessonUseCase _getLessonUseCase;
  final DeleteLessonUseCase _deleteLessonUseCase;

  Future<void> loadLessonDetails(String lessonName) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final res = await _getLessonUseCase(lessonName);
    res.when(
      success: (lesson) {
        emit(state.copyWith(isLoading: false, lesson: lesson));
      },
      failure: (fail) {
        emit(state.copyWith(isLoading: false, errorMessage: fail.message));
      },
    );
  }

  Future<void> deleteLesson(String lessonName) async {
    emit(
      state.copyWith(
        isMutating: true,
        mutationSuccess: null,
        mutationError: null,
      ),
    );

    final result = await _deleteLessonUseCase(lessonName);
    result.when(
      success: (_) {
        emit(
          state.copyWith(isMutating: false, mutationSuccess: 'lessonDeleted'),
        );
      },
      failure: (fail) {
        emit(state.copyWith(isMutating: false, mutationError: fail.message));
      },
    );
  }

  void clearMutationState() {
    emit(state.copyWith(mutationSuccess: null, mutationError: null));
  }
}
