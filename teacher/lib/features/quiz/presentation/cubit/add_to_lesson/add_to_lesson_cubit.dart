import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../courses/data/models/courses_models.dart';
import '../../../../courses/domain/usecases/courses_usecases.dart';
import '../../../../courses/presentation/widgets/lesson_content/editor_js_content_builder.dart';
import 'add_to_lesson_state.dart';

class AddToLessonCubit extends Cubit<AddToLessonState> {
  AddToLessonCubit(
    this._getMyCoursesUseCase,
    this._getChaptersUseCase,
    this._getLessonsUseCase,
    this._getLessonUseCase,
    this._updateLessonUseCase,
  ) : super(const AddToLessonState()) {
    loadCourses();
  }

  final GetMyCoursesUseCase _getMyCoursesUseCase;
  final GetChaptersUseCase _getChaptersUseCase;
  final GetLessonsUseCase _getLessonsUseCase;
  final GetLessonUseCase _getLessonUseCase;
  final UpdateLessonUseCase _updateLessonUseCase;

  Future<void> loadCourses() async {
    emit(state.copyWith(isLoadingCourses: true, errorMessage: null));
    final result = await _getMyCoursesUseCase();
    result.when(
      success: (data) {
        emit(state.copyWith(isLoadingCourses: false, courses: data.courses));
      },
      failure: (failure) {
        emit(state.copyWith(
          isLoadingCourses: false,
          errorMessage: failure.message,
        ));
      },
    );
  }

  Future<void> selectCourse(CourseModel? course) async {
    if (course == null) {
      emit(state.copyWith(
        selectedCourse: null,
        selectedChapter: null,
        selectedLesson: null,
        chapters: [],
        lessons: [],
      ));
      return;
    }
    emit(state.copyWith(
      selectedCourse: course,
      selectedChapter: null,
      selectedLesson: null,
      chapters: [],
      lessons: [],
      isLoadingChapters: true,
      errorMessage: null,
    ));

    final result = await _getChaptersUseCase(course.name);
    result.when(
      success: (paginated) {
        emit(state.copyWith(
          isLoadingChapters: false,
          chapters: paginated.items,
        ));
      },
      failure: (failure) {
        emit(state.copyWith(
          isLoadingChapters: false,
          errorMessage: failure.message,
        ));
      },
    );
  }

  Future<void> selectChapter(ChapterSummaryModel? chapter) async {
    if (chapter == null) {
      emit(state.copyWith(
        selectedChapter: null,
        selectedLesson: null,
        lessons: [],
      ));
      return;
    }
    emit(state.copyWith(
      selectedChapter: chapter,
      selectedLesson: null,
      lessons: [],
      isLoadingLessons: true,
      errorMessage: null,
    ));

    final result = await _getLessonsUseCase(chapter.name);
    result.when(
      success: (paginated) {
        emit(state.copyWith(
          isLoadingLessons: false,
          lessons: paginated.items,
        ));
      },
      failure: (failure) {
        emit(state.copyWith(
          isLoadingLessons: false,
          errorMessage: failure.message,
        ));
      },
    );
  }

  void selectLesson(LessonSummaryModel? lesson) {
    emit(state.copyWith(selectedLesson: lesson, errorMessage: null));
  }

  Future<void> addQuizToLesson(String quizName) async {
    final lesson = state.selectedLesson;
    if (lesson == null) return;

    emit(state.copyWith(
      isSubmitting: true,
      errorMessage: null,
      isSuccess: false,
    ));

    // 1. Fetch full lesson details
    final detailResult = await _getLessonUseCase(lesson.name);
    LessonDetailModel? lessonDetail;
    detailResult.when(
      success: (detail) => lessonDetail = detail,
      failure: (failure) {
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: failure.message,
        ));
      },
    );

    if (lessonDetail == null) return;

    // 2. Parse existing content blocks
    final blocks = <Map<String, dynamic>>[];
    final rawContent = lessonDetail!.content;
    if (rawContent != null && rawContent.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawContent);
        if (decoded is Map<String, dynamic> && decoded['blocks'] is List) {
          for (final b in (decoded['blocks'] as List)) {
            if (b is Map<String, dynamic>) {
              blocks.add(Map<String, dynamic>.from(b));
            }
          }
        }
      } catch (_) {}
    }

    // 3. Append quiz block
    blocks.add(EditorJsContentBuilder.quizBlockData(quizName));
    final updatedContent = EditorJsContentBuilder.fromBlocks(blocks);

    // 4. Call update lesson
    final updateResult = await _updateLessonUseCase(
      lessonName: lessonDetail!.name,
      title: lessonDetail!.title,
      includeInPreview: lessonDetail!.includeInPreview == 1,
      content: updatedContent,
    );

    updateResult.when(
      success: (_) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      },
      failure: (failure) {
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: failure.message,
        ));
      },
    );
  }
}
