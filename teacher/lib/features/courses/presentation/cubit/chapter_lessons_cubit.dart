import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/courses_usecases.dart';
import 'chapter_lessons_state.dart';

class ChapterLessonsCubit extends Cubit<ChapterLessonsState> {
  ChapterLessonsCubit(this._getLessonsUseCase)
    : super(const ChapterLessonsState());

  final GetLessonsUseCase _getLessonsUseCase;
  int _requestId = 0;

  Future<void> loadLessons(String chapterName) async {
    final requestId = ++_requestId;
    emit(ChapterLessonsState(chapterName: chapterName, isInitialLoading: true));

    final result = await _getLessonsUseCase(chapterName);
    if (requestId != _requestId) return;

    result.when(
      success: (page) {
        emit(
          state.copyWith(
            isInitialLoading: false,
            lessons: page.items,
            start: page.start,
            pageSize: page.pageSize,
            hasNextPage: page.hasNextPage,
            errorMessage: null,
          ),
        );
      },
      failure: (fail) {
        emit(
          state.copyWith(isInitialLoading: false, errorMessage: fail.message),
        );
      },
    );
  }

  Future<void> loadMoreLessons() async {
    final chapterName = state.chapterName;
    if (chapterName == null || state.isLoadingMore || !state.hasNextPage) {
      return;
    }

    final requestId = ++_requestId;
    emit(state.copyWith(isLoadingMore: true));

    final result = await _getLessonsUseCase(
      chapterName,
      start: state.start + state.pageSize,
      pageSize: state.pageSize,
    );
    if (requestId != _requestId) return;

    result.when(
      success: (page) {
        emit(
          state.copyWith(
            isLoadingMore: false,
            lessons: [...state.lessons ?? const [], ...page.items],
            start: page.start,
            pageSize: page.pageSize,
            hasNextPage: page.hasNextPage,
          ),
        );
      },
      failure: (fail) {
        emit(state.copyWith(isLoadingMore: false, errorMessage: fail.message));
      },
    );
  }
}
