import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/courses_usecases.dart';
import 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit(
    this._listCoursesUseCase,
    this._getMyCoursesUseCase,
    this._deleteCourseUseCase,
  ) : super(const CoursesState());

  final ListCoursesUseCase _listCoursesUseCase;
  final GetMyCoursesUseCase _getMyCoursesUseCase;
  final DeleteCourseUseCase _deleteCourseUseCase;
  int _requestId = 0;

  Future<void> loadCourses() async {
    final requestId = ++_requestId;
    emit(state.copyWith(isInitialLoading: true, errorMessage: null));

    final allRes = await _listCoursesUseCase(
      searchText: state.searchText,
      publishedFilter: state.publishedFilter,
      pageSize: 2,
    );
    final myRes = await _getMyCoursesUseCase();
    if (requestId != _requestId) return;

    allRes.when(
      success: (page) {
        myRes.when(
          success: (myCoursesData) {
            emit(
              state.copyWith(
                isInitialLoading: false,
                allCourses: page.items,
                coursesStart: page.start,
                coursesPageSize: page.pageSize,
                coursesHasNextPage: page.hasNextPage,
                myCourses: myCoursesData.courses,
                errorMessage: null,
              ),
            );
          },
          failure: (fail) {
            emit(
              state.copyWith(
                isInitialLoading: false,
                allCourses: page.items,
                coursesStart: page.start,
                coursesPageSize: page.pageSize,
                coursesHasNextPage: page.hasNextPage,
                myCourses: const [],
                errorMessage: page.items.isEmpty ? fail.message : null,
              ),
            );
          },
        );
      },
      failure: (fail) {
        emit(
          state.copyWith(isInitialLoading: false, errorMessage: fail.message),
        );
      },
    );
  }

  Future<void> loadMoreCourses() async {
    if (state.isLoadingMoreCourses || !state.coursesHasNextPage) return;

    final requestId = ++_requestId;
    emit(state.copyWith(isLoadingMoreCourses: true));

    final result = await _listCoursesUseCase(
      searchText: state.searchText,
      publishedFilter: state.publishedFilter,
      start: state.coursesStart + state.coursesPageSize,
      pageSize: state.coursesPageSize,
    );
    if (requestId != _requestId) return;

    result.when(
      success: (page) {
        emit(
          state.copyWith(
            isLoadingMoreCourses: false,
            allCourses: [...state.allCourses ?? const [], ...page.items],
            coursesStart: page.start,
            coursesPageSize: page.pageSize,
            coursesHasNextPage: page.hasNextPage,
          ),
        );
      },
      failure: (fail) {
        emit(
          state.copyWith(
            isLoadingMoreCourses: false,
            errorMessage: fail.message,
          ),
        );
      },
    );
  }

  Future<void> refreshCourses() async {
    final requestId = ++_requestId;
    emit(state.copyWith(isRefreshing: true, errorMessage: null));

    final allRes = await _listCoursesUseCase(
      searchText: state.searchText,
      publishedFilter: state.publishedFilter,
      pageSize: 2,
    );
    final myRes = await _getMyCoursesUseCase();
    if (requestId != _requestId) return;

    allRes.when(
      success: (page) {
        myRes.when(
          success: (myCoursesData) {
            emit(
              state.copyWith(
                isRefreshing: false,
                allCourses: page.items,
                coursesStart: page.start,
                coursesPageSize: page.pageSize,
                coursesHasNextPage: page.hasNextPage,
                myCourses: myCoursesData.courses,
                errorMessage: null,
              ),
            );
          },
          failure: (fail) {
            emit(
              state.copyWith(
                isRefreshing: false,
                allCourses: page.items,
                coursesStart: page.start,
                coursesPageSize: page.pageSize,
                coursesHasNextPage: page.hasNextPage,
                errorMessage: fail.message,
              ),
            );
          },
        );
      },
      failure: (fail) {
        emit(state.copyWith(isRefreshing: false, errorMessage: fail.message));
      },
    );
  }

  Future<void> searchCourses(String searchText) async {
    await _loadFilteredCourses(searchText: searchText);
  }

  Future<void> filterByPublished(bool? publishedFilter) async {
    await _loadFilteredCourses(
      publishedFilter: publishedFilter,
      updatePublishedFilter: true,
    );
  }

  Future<void> deleteCourse(String courseName) async {
    emit(
      state.copyWith(
        isMutating: true,
        mutationSuccess: null,
        mutationError: null,
      ),
    );

    final result = await _deleteCourseUseCase(courseName);
    result.when(
      success: (_) {
        emit(
          state.copyWith(isMutating: false, mutationSuccess: 'courseDeleted'),
        );
        loadCourses();
      },
      failure: (fail) {
        emit(state.copyWith(isMutating: false, mutationError: fail.message));
      },
    );
  }

  void clearMutationState() {
    emit(state.copyWith(mutationSuccess: null, mutationError: null));
  }

  Future<void> _loadFilteredCourses({
    String? searchText,
    bool? publishedFilter,
    bool updatePublishedFilter = false,
  }) async {
    final nextSearchText = searchText ?? state.searchText;
    final nextPublishedFilter = updatePublishedFilter
        ? publishedFilter
        : state.publishedFilter;
    final requestId = ++_requestId;

    emit(
      state.copyWith(
        searchText: nextSearchText,
        publishedFilter: nextPublishedFilter,
        isFiltering: true,
        errorMessage: null,
      ),
    );

    final result = await _listCoursesUseCase(
      searchText: nextSearchText,
      publishedFilter: nextPublishedFilter,
    );
    if (requestId != _requestId) return;

    result.when(
      success: (page) {
        emit(
          state.copyWith(
            isFiltering: false,
            allCourses: page.items,
            coursesStart: page.start,
            coursesPageSize: page.pageSize,
            coursesHasNextPage: page.hasNextPage,
            errorMessage: null,
          ),
        );
      },
      failure: (fail) {
        emit(state.copyWith(isFiltering: false, errorMessage: fail.message));
      },
    );
  }
}
