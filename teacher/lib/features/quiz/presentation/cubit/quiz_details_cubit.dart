import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/upload_file_usecase.dart';
import '../../domain/usecases/quiz_usecases.dart';
import 'quiz_details_state.dart';

class QuizDetailsCubit extends Cubit<QuizDetailsState> {
  QuizDetailsCubit(
    this._getQuizUseCase,
    this._updateQuizUseCase,
    this._addQuestionToQuizUseCase,
    this._removeQuestionFromQuizUseCase,
    this._uploadFileUseCase,
  ) : super(const QuizDetailsState());

  final GetQuizUseCase _getQuizUseCase;
  final UpdateQuizUseCase _updateQuizUseCase;
  final AddQuestionToQuizUseCase _addQuestionToQuizUseCase;
  final RemoveQuestionFromQuizUseCase _removeQuestionFromQuizUseCase;
  final UploadFileUseCase _uploadFileUseCase;

  Future<void> loadQuiz(String quizName) async {
    emit(
      state.copyWith(isLoading: true, errorMessage: null, mutationError: null),
    );
    final result = await _getQuizUseCase(quizName);
    result.when(
      success: (quiz) => emit(
        state.copyWith(isLoading: false, quiz: quiz, mutationError: null),
      ),
      failure: (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          mutationError: null,
        ),
      ),
    );
  }

  Future<void> addQuestion({
    required String questionName,
    required int marks,
  }) async {
    final quiz = state.quiz;
    if (quiz == null) return;
    emit(state.copyWith(isUpdating: true, mutationError: null));
    final result = await _addQuestionToQuizUseCase(
      quiz: quiz.name,
      question: questionName,
      marks: marks,
    );
    result.when(
      success: (updated) => emit(
        state.copyWith(isUpdating: false, quiz: updated, mutationError: null),
      ),
      failure: (failure) => emit(
        state.copyWith(isUpdating: false, mutationError: failure.message),
      ),
    );
  }

  Future<void> removeQuestion(String questionName) async {
    final quiz = state.quiz;
    if (quiz == null) return;
    emit(state.copyWith(isUpdating: true, mutationError: null));
    final result = await _removeQuestionFromQuizUseCase(
      quiz: quiz.name,
      question: questionName,
    );
    result.when(
      success: (updated) => emit(
        state.copyWith(isUpdating: false, quiz: updated, mutationError: null),
      ),
      failure: (failure) => emit(
        state.copyWith(isUpdating: false, mutationError: failure.message),
      ),
    );
  }

  Future<void> bulkRemoveQuestions(List<String> questionNames) async {
    final currentQuiz = state.quiz;
    if (currentQuiz == null || questionNames.isEmpty) return;

    // Optimistically update the UI
    final newQuestions = currentQuiz.questions
        .where((q) => !questionNames.contains(q.name))
        .toList();
    final updatedQuiz = currentQuiz.copyWith(questions: newQuestions);

    emit(state.copyWith(quiz: updatedQuiz, mutationError: null));

    var hasError = false;
    // Perform deletions in the background silently
    for (final questionName in questionNames) {
      final result = await _removeQuestionFromQuizUseCase(
        quiz: currentQuiz.name,
        question: questionName,
      );
      result.when(
        success: (_) {},
        failure: (_) {
          hasError = true;
        },
      );
    }

    if (hasError) {
      // Show error and reload from server to restore correct state
      emit(
        state.copyWith(
          mutationError: 'Failed to delete some questions. Re-syncing...',
        ),
      );
      unawaited(loadQuiz(currentQuiz.name));
    }
  }

  Future<void> updateSettings(Map<String, dynamic> settings) async {
    final quiz = state.quiz;
    if (quiz == null) return;

    // Add the quiz name and title to the body so the API knows which quiz to update
    final body = {'quiz': quiz.name, 'title': quiz.title, ...settings};

    emit(
      state.copyWith(isUpdating: true, errorMessage: null, mutationError: null),
    );
    final result = await _updateQuizUseCase(body);
    result.when(
      success: (updated) => emit(
        state.copyWith(isUpdating: false, quiz: updated, mutationError: null),
      ),
      failure: (failure) => emit(
        state.copyWith(isUpdating: false, mutationError: failure.message),
      ),
    );
  }

  Future<void> saveQuizQuestions(
    List<Map<String, dynamic>> additions,
    Set<String> deletions, {
    List<Map<String, dynamic>> marksUpdates = const [],
  }) async {
    final currentQuiz = state.quiz;
    if (currentQuiz == null) return;

    emit(
      state.copyWith(
        isBatchSaving: true,
        batchDeleteTotal: deletions.length,
        batchDeleteCompleted: 0,
        batchDeleteFailures: [],
        mutationError: null,
      ),
    );

    final allQuestionUpdates = [...marksUpdates, ...additions];

    // Phase 1: Question Updates & Additions (Update Quiz)
    if (allQuestionUpdates.isNotEmpty) {
      for (final update in allQuestionUpdates) {
        if (update.containsKey('inline')) {
          final inlineData = update['inline'] as Map<String, dynamic>;
          if (inlineData.containsKey('local_attachment_path')) {
            final path = inlineData.remove('local_attachment_path') as String;
            final uploadResult = await _uploadFileUseCase(file: File(path), isPrivate: 0);
            var hasError = false;
            uploadResult.when(
              success: (url) {
                inlineData['attachment'] = url;
              },
              failure: (failure) {
                hasError = true;
                emit(
                  state.copyWith(
                    isBatchSaving: false,
                    mutationError: 'Failed to upload attachment: ${failure.message}',
                  ),
                );
              },
            );
            if (hasError) return;
          }
        }
      }

      final body = {
        'quiz': currentQuiz.name,
        'title': currentQuiz.title,
        'questions': allQuestionUpdates,
      };

      final updateResult = await _updateQuizUseCase(body);
      var addFailed = false;
      updateResult.when(
        success: (_) {},
        failure: (failure) {
          addFailed = true;
          emit(
            state.copyWith(
              isBatchSaving: false,
              mutationError: 'Failed to update questions: ${failure.message}',
            ),
          );
        },
      );

      if (addFailed) return;
    }

    // Phase 2: Deletions
    final failures = <String>[];
    var completed = 0;
    for (final questionName in deletions) {
      final result = await _removeQuestionFromQuizUseCase(
        quiz: currentQuiz.name,
        question: questionName,
      );
      result.when(
        success: (_) {
          completed++;
          emit(state.copyWith(batchDeleteCompleted: completed));
        },
        failure: (_) {
          completed++; // Still counts as an attempted deletion for progress
          failures.add(questionName);
          emit(
            state.copyWith(
              batchDeleteCompleted: completed,
              batchDeleteFailures: List.of(failures),
            ),
          );
        },
      );
    }

    // Phase 3: Reload
    await loadQuiz(currentQuiz.name);

    emit(state.copyWith(isBatchSaving: false));
  }
}
