import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/courses_models.dart';

part 'course_details_state.freezed.dart';

@freezed
abstract class CourseDetailsState with _$CourseDetailsState {
  const factory CourseDetailsState({
    @Default(false) bool isLoading,
    @Default(false) bool isMutating,
    CourseModel? course,
    List<ChapterDetailModel>? chapters,
    @Default(0) int chaptersStart,
    @Default(30) int chaptersPageSize,
    @Default(false) bool chaptersHasNextPage,
    @Default(false) bool isLoadingMoreChapters,
    String? errorMessage,
    String? mutationSuccess,
    String? mutationError,
  }) = _CourseDetailsState;
}
