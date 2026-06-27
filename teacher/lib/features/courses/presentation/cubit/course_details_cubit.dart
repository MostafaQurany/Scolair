import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/courses_usecases.dart';
import '../../data/models/courses_models.dart';
import 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit(
    this._getCourseUseCase,
    this._getChaptersUseCase,
    this._getChapterUseCase,
  ) : super(const CourseDetailsState());

  final GetCourseUseCase _getCourseUseCase;
  final GetChaptersUseCase _getChaptersUseCase;
  final GetChapterUseCase _getChapterUseCase;

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
              emit(state.copyWith(
                isLoading: false,
                course: course,
                errorMessage: errorMsg,
              ));
            } else {
              // Sort chapters by index if needed
              chapterDetails.sort((a, b) {
                // Parse idx from summary or use index
                final aIdx = chapterSummaries.firstWhere((s) => s.name == a.name).idx;
                final bIdx = chapterSummaries.firstWhere((s) => s.name == b.name).idx;
                return aIdx.compareTo(bIdx);
              });

              emit(state.copyWith(
                isLoading: false,
                course: course,
                chapters: chapterDetails,
              ));
            }
          },
          failure: (fail) {
            emit(state.copyWith(
              isLoading: false,
              course: course,
              errorMessage: fail.message,
            ));
          },
        );
      },
      failure: (fail) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: fail.message,
        ));
      },
    );
  }
}
