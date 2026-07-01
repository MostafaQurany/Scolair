import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/courses_models.dart';

part 'chapter_lessons_state.freezed.dart';

@freezed
abstract class ChapterLessonsState with _$ChapterLessonsState {
  const factory ChapterLessonsState({
    String? chapterName,
    @Default(false) bool isInitialLoading,
    @Default(false) bool isLoadingMore,
    List<LessonSummaryModel>? lessons,
    @Default(0) int start,
    @Default(30) int pageSize,
    @Default(false) bool hasNextPage,
    String? errorMessage,
  }) = _ChapterLessonsState;
}
