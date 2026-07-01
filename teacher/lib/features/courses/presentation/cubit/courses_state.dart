import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/courses_models.dart';

part 'courses_state.freezed.dart';

@freezed
abstract class CoursesState with _$CoursesState {
  const factory CoursesState({
    @Default('') String searchText,
    bool? publishedFilter,
    @Default(false) bool isInitialLoading,
    @Default(false) bool isRefreshing,
    @Default(false) bool isFiltering,
    @Default(false) bool isMutating,
    List<CourseModel>? allCourses,
    @Default(0) int coursesStart,
    @Default(30) int coursesPageSize,
    @Default(false) bool coursesHasNextPage,
    @Default(false) bool isLoadingMoreCourses,
    List<CourseModel>? myCourses,
    String? errorMessage,
    String? mutationSuccess,
    String? mutationError,
  }) = _CoursesState;
}
