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
    this._deleteCourseUseCase,
    this._addInstructorUseCase,
    this._removeInstructorUseCase,
  ) : super(const CourseDetailsState());

  final GetCourseUseCase _getCourseUseCase;
  final GetChaptersUseCase _getChaptersUseCase;
  final GetChapterUseCase _getChapterUseCase;
  final CreateChapterUseCase _createChapterUseCase;
  final UpdateChapterUseCase _updateChapterUseCase;
  final DeleteChapterUseCase _deleteChapterUseCase;
  final DeleteLessonUseCase _deleteLessonUseCase;
  final DeleteCourseUseCase _deleteCourseUseCase;
  final AddInstructorUseCase _addInstructorUseCase;
  final RemoveInstructorUseCase _removeInstructorUseCase;
  int _requestId = 0;

  Future<void> loadCourseDetails(String courseName) async {
    final requestId = ++_requestId;
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final courseRes = await _getCourseUseCase(courseName);
    if (requestId != _requestId) return;

    courseRes.when(
      success: (course) async {
        final chaptersRes = await _getChaptersUseCase(courseName);
        if (requestId != _requestId) return;

        chaptersRes.when(
          success: (page) async {
            final result = await _fetchChapterDetails(page.items);
            if (requestId != _requestId) return;

            if (result.errorMessage != null) {
              emit(
                state.copyWith(
                  isLoading: false,
                  course: course,
                  errorMessage: result.errorMessage,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  isLoading: false,
                  course: course,
                  chapters: result.details,
                  chaptersStart: page.start,
                  chaptersPageSize: page.pageSize,
                  chaptersHasNextPage: page.hasNextPage,
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

  Future<void> loadMoreChapters() async {
    final courseName = state.course?.name;
    if (courseName == null ||
        state.isLoadingMoreChapters ||
        !state.chaptersHasNextPage) {
      return;
    }

    final requestId = ++_requestId;
    emit(state.copyWith(isLoadingMoreChapters: true));

    final chaptersRes = await _getChaptersUseCase(
      courseName,
      start: state.chaptersStart + state.chaptersPageSize,
      pageSize: state.chaptersPageSize,
    );
    if (requestId != _requestId) return;

    await chaptersRes.when(
      success: (page) async {
        final result = await _fetchChapterDetails(page.items);
        if (requestId != _requestId) return;

        if (result.errorMessage != null) {
          emit(
            state.copyWith(
              isLoadingMoreChapters: false,
              errorMessage: result.errorMessage,
            ),
          );
        } else {
          emit(
            state.copyWith(
              isLoadingMoreChapters: false,
              chapters: [...state.chapters ?? const [], ...result.details],
              chaptersStart: page.start,
              chaptersPageSize: page.pageSize,
              chaptersHasNextPage: page.hasNextPage,
            ),
          );
        }
      },
      failure: (fail) async {
        emit(
          state.copyWith(
            isLoadingMoreChapters: false,
            errorMessage: fail.message,
          ),
        );
      },
    );
  }

  Future<({List<ChapterDetailModel> details, String? errorMessage})>
  _fetchChapterDetails(List<ChapterSummaryModel> summaries) async {
    final List<ChapterDetailModel> chapterDetails = [];
    String? errorMsg;

    for (final summary in summaries) {
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
      return (details: <ChapterDetailModel>[], errorMessage: errorMsg);
    }

    chapterDetails.sort((a, b) {
      final aIdx = summaries.firstWhere((s) => s.name == a.name).idx;
      final bIdx = summaries.firstWhere((s) => s.name == b.name).idx;
      return aIdx.compareTo(bIdx);
    });

    return (details: chapterDetails, errorMessage: null);
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

  Future<void> deleteLesson(String lessonName, String chapterName) async {
    emit(
      state.copyWith(
        isMutating: true,
        mutationSuccess: null,
        mutationError: null,
      ),
    );

    final result = await _deleteLessonUseCase(
      lessonName: lessonName,
      chapterName: chapterName,
    );
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

  Future<void> addInstructor(String email) async {
    final courseName = state.course?.name;
    if (courseName == null) return;

    emit(
      state.copyWith(
        isMutating: true,
        mutationSuccess: null,
        mutationError: null,
      ),
    );

    final result = await _addInstructorUseCase(
      courseName: courseName,
      instructorEmail: email,
    );

    result.when(
      success: (_) {
        emit(
          state.copyWith(
            isMutating: false,
            mutationSuccess: 'Instructor added successfully',
          ),
        );
        loadCourseDetails(courseName);
      },
      failure: (fail) {
        emit(state.copyWith(isMutating: false, mutationError: fail.message));
      },
    );
  }

  Future<void> removeInstructor(String email) async {
    final courseName = state.course?.name;
    if (courseName == null) return;

    emit(
      state.copyWith(
        isMutating: true,
        mutationSuccess: null,
        mutationError: null,
      ),
    );

    final result = await _removeInstructorUseCase(
      courseName: courseName,
      instructorEmail: email,
    );

    result.when(
      success: (_) {
        emit(
          state.copyWith(
            isMutating: false,
            mutationSuccess: 'Instructor removed successfully',
          ),
        );
        loadCourseDetails(courseName);
      },
      failure: (fail) {
        emit(state.copyWith(isMutating: false, mutationError: fail.message));
      },
    );
  }

  Future<void> deleteCourse() async {
    final courseName = state.course?.name;
    if (courseName == null) return;

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
          state.copyWith(
            isMutating: false,
            mutationSuccess: 'courseDeleted',
          ),
        );
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
