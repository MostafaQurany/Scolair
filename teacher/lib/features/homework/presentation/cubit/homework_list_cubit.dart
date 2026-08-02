import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../courses/domain/repositories/courses_repository.dart';

import '../../data/models/list_homeworks_request_data.dart';
import '../../domain/usecases/homework_usecases.dart';
import 'homework_list_state.dart';

class HomeworkListCubit extends Cubit<HomeworkListState> {
  HomeworkListCubit(
    this._listHomeworkPageUseCase,
    this._deleteHomeworkUseCase,
    this._coursesRepository,
  ) : super(const HomeworkListState());

  final ListHomeworkPageUseCase _listHomeworkPageUseCase;
  final DeleteHomeworkUseCase _deleteHomeworkUseCase;
  final CoursesRepository _coursesRepository;
  int _requestId = 0;

  Future<void> loadInitial() => _loadFirstPage(refresh: false);

  Future<void> refresh() => _loadFirstPage(refresh: true);

  Future<void> retry() => _loadFirstPage(refresh: false);

  void changeFilter(HomeworkPublishedFilter filter) {
    if (filter == state.filter) return;
    emit(state.copyWith(filter: filter));
  }

  void changeSearchQuery(String query) {
    if (query == state.searchQuery) return;
    emit(state.copyWith(searchQuery: query));
  }

  Future<void> loadCourses() async {
    if (state.courses.isNotEmpty || state.isLoadingCourses) return;
    emit(state.copyWith(isLoadingCourses: true));
    final result = await _coursesRepository.listCourses(pageSize: 300);
    result.when(
      success: (page) => emit(
        state.copyWith(courses: page.items, isLoadingCourses: false),
      ),
      failure: (_) => emit(state.copyWith(isLoadingCourses: false)),
    );
  }

  Future<void> selectCourse(String? course) async {
    if (course == state.selectedCourse) return;
    emit(
      state.copyWith(
        selectedCourse: course,
        clearCourse: course == null,
        clearChapter: true,
        clearLesson: true,
        chapters: const [],
        lessons: const [],
      ),
    );
    await _loadFirstPage(refresh: false);

    if (course != null) {
      emit(state.copyWith(isLoadingChapters: true));
      final result = await _coursesRepository.getChapters(course, pageSize: 300);
      result.when(
        success: (page) => emit(
          state.copyWith(chapters: page.items, isLoadingChapters: false),
        ),
        failure: (_) => emit(state.copyWith(isLoadingChapters: false)),
      );
    }
  }

  Future<void> selectChapter(String? chapter) async {
    if (chapter == state.selectedChapter) return;
    emit(
      state.copyWith(
        selectedChapter: chapter,
        clearChapter: chapter == null,
        clearLesson: true,
        lessons: const [],
      ),
    );
    await _loadFirstPage(refresh: false);

    if (chapter != null) {
      emit(state.copyWith(isLoadingLessons: true));
      final result = await _coursesRepository.getLessons(chapter, pageSize: 300);
      result.when(
        success: (page) => emit(
          state.copyWith(lessons: page.items, isLoadingLessons: false),
        ),
        failure: (_) => emit(state.copyWith(isLoadingLessons: false)),
      );
    }
  }

  Future<void> selectLesson(String? lesson) async {
    if (lesson == state.selectedLesson) return;
    emit(
      state.copyWith(
        selectedLesson: lesson,
        clearLesson: lesson == null,
      ),
    );
    await _loadFirstPage(refresh: false);
  }

  void clearFilters() {
    emit(
      state.copyWith(
        clearCourse: true,
        clearChapter: true,
        clearLesson: true,
        chapters: const [],
        lessons: const [],
      ),
    );
    _loadFirstPage(refresh: false);
  }

  Future<void> _loadFirstPage({required bool refresh}) async {
    final requestId = ++_requestId;
    emit(
      state.copyWith(
        isInitialLoading: !refresh,
        isRefreshing: refresh,
        clearError: true,
        clearPaginationError: true,
      ),
    );
    final result = await _listHomeworkPageUseCase(
      start: 0,
      pageSize: state.pageSize,
      publishedFilter: HomeworkPublishedFilter.all,
      course: state.selectedCourse,
      chapter: state.selectedChapter,
      lesson: state.selectedLesson,
    );
    if (requestId != _requestId) return;
    result.when(
      success: (page) => emit(
        state.copyWith(
          items: page.items,
          start: page.start,
          total: page.total,
          hasNextPage: page.hasNextPage,
          isInitialLoading: false,
          isRefreshing: false,
          clearError: true,
        ),
      ),
      failure: (failure) => emit(
        state.copyWith(
          isInitialLoading: false,
          isRefreshing: false,
          errorMessage: failure.message,
          errorSerial: state.errorSerial + 1,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isInitialLoading ||
        state.isRefreshing ||
        state.isLoadingMore ||
        !state.hasNextPage) {
      return;
    }
    emit(state.copyWith(isLoadingMore: true, clearPaginationError: true));
    final result = await _listHomeworkPageUseCase(
      start: state.items.length,
      pageSize: state.pageSize,
      publishedFilter: HomeworkPublishedFilter.all,
      course: state.selectedCourse,
      chapter: state.selectedChapter,
      lesson: state.selectedLesson,
    );
    result.when(
      success: (page) {
        final byName = {for (final item in state.items) item.name: item};
        for (final item in page.items) {
          byName[item.name] = item;
        }
        emit(
          state.copyWith(
            items: byName.values.toList(growable: false),
            start: page.start,
            total: page.total,
            hasNextPage: page.hasNextPage,
            isLoadingMore: false,
          ),
        );
      },
      failure: (failure) => emit(
        state.copyWith(
          isLoadingMore: false,
          paginationErrorMessage: failure.message,
          errorSerial: state.errorSerial + 1,
        ),
      ),
    );
  }

  Future<bool> deleteHomework(String homeworkName) async {
    if (state.deletingNames.contains(homeworkName)) return false;
    emit(
      state.copyWith(
        deletingNames: {...state.deletingNames, homeworkName},
        clearError: true,
      ),
    );
    final result = await _deleteHomeworkUseCase(homeworkName);
    return result.when(
      success: (_) {
        final updatedItems = state.items
            .where((item) => item.name != homeworkName)
            .toList(growable: false);
        emit(
          state.copyWith(
            items: updatedItems,
            total: state.total > 0 ? state.total - 1 : 0,
            deletingNames: {...state.deletingNames}..remove(homeworkName),
          ),
        );
        return true;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            deletingNames: {...state.deletingNames}..remove(homeworkName),
            errorMessage: failure.message,
            errorSerial: state.errorSerial + 1,
          ),
        );
        return false;
      },
    );
  }
}
