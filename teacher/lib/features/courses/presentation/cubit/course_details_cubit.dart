import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/courses_usecases.dart';
import '../../data/models/courses_models.dart';
import 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit(
    this._getCourseUseCase,
    this._getChaptersUseCase,
    this._getChapterUseCase,
    this._createChapterUseCase,
    this._updateChapterUseCase,
    this._deleteChapterUseCase,
    this._deleteLessonUseCase,
  ) : super(const CourseDetailsState());

  final GetCourseUseCase _getCourseUseCase;
  final GetChaptersUseCase _getChaptersUseCase;
  final GetChapterUseCase _getChapterUseCase;
  final CreateChapterUseCase _createChapterUseCase;
  final UpdateChapterUseCase _updateChapterUseCase;
  final DeleteChapterUseCase _deleteChapterUseCase;
  final DeleteLessonUseCase _deleteLessonUseCase;

  Future<void> loadCourseDetails(String courseName) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final courseRes = await _getCourseUseCase(courseName);

    courseRes.when(
      success: (course) async {
        final chaptersRes = await _getChaptersUseCase(courseName);

        chaptersRes.when(
          success: (chapterSummaries) async {
            final List<ChapterDetailModel> chapterDetails = [];
            String? errorMsg;

            for (final summary in chapterSummaries) {
              final chapterDetailRes = await _getChapterUseCase(summary.name);
              chapterDetailRes.when(
                success: (detail) {
                  chapterDetails.add(detail);
                },
                failure: (fail) {
                  errorMsg = fail.message;
                },
              );
              if (errorMsg != null) break;
            }

            if (errorMsg != null) {
              emit(
                state.copyWith(
                  isLoading: false,
                  course: course,
                  errorMessage: errorMsg,
                ),
              );
            } else {
              chapterDetails.sort((a, b) {
                final aIdx = chapterSummaries
                    .firstWhere((s) => s.name == a.name)
                    .idx;
                final bIdx = chapterSummaries
                    .firstWhere((s) => s.name == b.name)
                    .idx;
                return aIdx.compareTo(bIdx);
              });

              emit(
                state.copyWith(
                  isLoading: false,
                  course: course,
                  chapters: chapterDetails,
                ),
              );
            }
          },
          failure: (fail) {
            emit(
              state.copyWith(
                isLoading: false,
                course: course,
                errorMessage: fail.message,
              ),
            );
          },
        );
      },
      failure: (fail) {
        emit(state.copyWith(isLoading: false, errorMessage: fail.message));
      },
    );
  }

  Future<void> createChapter({
    required String title,
    required String courseName,
    bool isScormPackage = false,
  }) async {
    emit(
      state.copyWith(
        isMutating: true,
        mutationSuccess: null,
        mutationError: null,
      ),
    );

    final result = await _createChapterUseCase(
      title: title,
      courseName: courseName,
      isScormPackage: isScormPackage,
    );
    result.when(
      success: (_) {
        emit(
          state.copyWith(isMutating: false, mutationSuccess: 'chapterCreated'),
        );
        loadCourseDetails(courseName);
      },
      failure: (fail) {
        emit(state.copyWith(isMutating: false, mutationError: fail.message));
      },
    );
  }

  Future<void> updateChapter({
    required String chapterName,
    required String title,
  }) async {
    emit(
      state.copyWith(
        isMutating: true,
        mutationSuccess: null,
        mutationError: null,
      ),
    );

    final result = await _updateChapterUseCase(
      chapterName: chapterName,
      title: title,
    );
    result.when(
      success: (_) {
        emit(
          state.copyWith(isMutating: false, mutationSuccess: 'chapterUpdated'),
        );
        if (state.course != null) {
          loadCourseDetails(state.course!.name);
        }
      },
      failure: (fail) {
        emit(state.copyWith(isMutating: false, mutationError: fail.message));
      },
    );
  }

  Future<void> deleteChapter(String chapterName) async {
    emit(
      state.copyWith(
        isMutating: true,
        mutationSuccess: null,
        mutationError: null,
      ),
    );

    final result = await _deleteChapterUseCase(chapterName);
    result.when(
      success: (_) {
        emit(
          state.copyWith(isMutating: false, mutationSuccess: 'chapterDeleted'),
        );
        if (state.course != null) {
          loadCourseDetails(state.course!.name);
        }
      },
      failure: (fail) {
        emit(state.copyWith(isMutating: false, mutationError: fail.message));
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
        if (state.course != null) {
          loadCourseDetails(state.course!.name);
        }
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
