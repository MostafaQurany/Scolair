import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/courses_usecases.dart';
import 'lesson_details_state.dart';

class LessonDetailsCubit extends Cubit<LessonDetailsState> {
  LessonDetailsCubit(this._getLessonUseCase)
      : super(const LessonDetailsState());

  final GetLessonUseCase _getLessonUseCase;

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
}
