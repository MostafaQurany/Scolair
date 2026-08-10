import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../courses/data/models/courses_models.dart';

part 'add_to_lesson_state.freezed.dart';

@freezed
abstract class AddToLessonState with _$AddToLessonState {
  const factory AddToLessonState({
    @Default(true) bool isLoadingCourses,
    @Default(false) bool isLoadingChapters,
    @Default(false) bool isLoadingLessons,
    @Default(false) bool isSubmitting,
    @Default([]) List<CourseModel> courses,
    @Default([]) List<ChapterSummaryModel> chapters,
    @Default([]) List<LessonSummaryModel> lessons,
    CourseModel? selectedCourse,
    ChapterSummaryModel? selectedChapter,
    LessonSummaryModel? selectedLesson,
    String? errorMessage,
    @Default(false) bool isSuccess,
  }) = _AddToLessonState;
}
