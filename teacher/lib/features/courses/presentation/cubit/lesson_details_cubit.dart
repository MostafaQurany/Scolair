import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/courses_usecases.dart';
import 'lesson_details_state.dart';

import '../widgets/lesson_content/editor_js_content_parser.dart';

class LessonDetailsCubit extends Cubit<LessonDetailsState> {
  LessonDetailsCubit(
    this._getLessonUseCase,
    this._deleteLessonUseCase,
    this._updateLessonUseCase,
  ) : super(const LessonDetailsState());

  final GetLessonUseCase _getLessonUseCase;
  final DeleteLessonUseCase _deleteLessonUseCase;
  final UpdateLessonUseCase _updateLessonUseCase;

  Future<void> removeQuizFromLesson(String quizName) async {
    final lesson = state.lesson;
    if (lesson == null) return;

    final parsed = EditorJsContentParser.parse(lesson.content);
    final updatedBlocks = parsed.blocks
        .where(
          (block) => !(block.type == 'quiz' && block.data['quiz'] == quizName),
        )
        .map((block) => {'type': block.type, 'data': block.data})
        .toList();

    final updatedContent = {
      'time': DateTime.now().millisecondsSinceEpoch,
      'blocks': updatedBlocks,
    };

    emit(state.copyWith(isLoading: true));

    final result = await _updateLessonUseCase.call(
      lessonName: lesson.name,
      title: lesson.title,
      includeInPreview: lesson.includeInPreview == 1,
      content: updatedContent,
    );

    result.when(
      success: (_) {
        loadLessonDetails(lesson.name);
      },
      failure: (fail) {
        emit(state.copyWith(isLoading: false, errorMessage: fail.message));
      },
    );
  }

  Future<void> loadLessonDetails(String lessonName) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final res = await _getLessonUseCase(lessonName);
    res.when(
      success: (lesson) {
        emit(state.copyWith(isLoading: false, lesson: lesson));
      },
      failure: (fail) {
        emit(state.copyWith(isLoading: false, errorMessage: fail.message));
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
