import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/api_result.dart';
import '../../../../../core/usecases/upload_file_usecase.dart';
import '../../../data/models/homework_mutation_models.dart';
import '../../../domain/usecases/homework_usecases.dart';
import 'homework_details_state.dart';

class HomeworkDetailsCubit extends Cubit<HomeworkDetailsState> {
  HomeworkDetailsCubit(
    this._getDetailsUseCase,
    this._updateRemoteUseCase,
    this._deleteUseCase,
    this._addQuestionUseCase,
    this._removeQuestionUseCase,
    this._getSubmissionsUseCase,
    this._uploadFileUseCase,
  ) : super(const HomeworkDetailsState());

  final GetHomeworkDetailsUseCase _getDetailsUseCase;
  final UpdateHomeworkRemoteUseCase _updateRemoteUseCase;
  final DeleteHomeworkUseCase _deleteUseCase;
  final AddHomeworkQuestionUseCase _addQuestionUseCase;
  final RemoveHomeworkQuestionUseCase _removeQuestionUseCase;
  final GetHomeworkSubmissionsUseCase _getSubmissionsUseCase;
  final UploadFileUseCase _uploadFileUseCase;

  // ── Edit mode ────────────────────────────────────────────────────────────────

  void enterEditMode() => emit(state.copyWith(isEditMode: true));
  void cancelEditMode() => emit(state.copyWith(isEditMode: false));

  Future<void> saveEditedFields({
    required String title,
    DateTime? dueDate,
    String? course,
    String? lesson,
    String? instructions,
    bool? allowLateSubmission,
  }) async {
    final current = state.homework;
    if (current == null) return;
    emit(state.copyWith(status: HomeworkDetailsStatus.mutating, errorMessage: null));

    final dueDateStr = dueDate != null ? _formatDate(dueDate) : null;

    final result = await _updateRemoteUseCase(
      UpdateHomeworkRequestData(
        homeworkName: current.name,
        title: title,
        dueDate: dueDateStr,
        course: course,
        lesson: lesson,
        instructions: instructions,
        allowLateSubmission: allowLateSubmission != null ? (allowLateSubmission ? 1 : 0) : null,
      ),
    );

    switch (result) {
      case ApiSuccess(data: final updated):
        emit(state.copyWith(
          status: HomeworkDetailsStatus.success,
          homework: updated,
          isEditMode: false,
          errorMessage: null,
        ));
      case ApiFailure(error: final error):
        emit(state.copyWith(
          status: HomeworkDetailsStatus.failure,
          errorMessage: error.message,
        ));
    }
  }

  // ── Load ─────────────────────────────────────────────────────────────────────

  Future<void> loadHomework(String homeworkName) async {
    emit(state.copyWith(status: HomeworkDetailsStatus.loading, errorMessage: null));

    final result = await _getDetailsUseCase(homeworkName);
    switch (result) {
      case ApiSuccess(data: final homework):
        bool hasSubmissions = false;
        final subResult = await _getSubmissionsUseCase(
          homeworkName: homeworkName,
          start: 0,
          pageSize: 1,
        );
        if (subResult case ApiSuccess(data: final subData)) {
          if (subData.items.isNotEmpty || subData.total > 0) {
            hasSubmissions = true;
          }
        }
        emit(
          state.copyWith(
            status: HomeworkDetailsStatus.success,
            homework: homework,
            hasSubmissions: hasSubmissions,
            errorMessage: null,
          ),
        );
      case ApiFailure(error: final error):
        emit(
          state.copyWith(
            status: HomeworkDetailsStatus.failure,
            errorMessage: error.message,
          ),
        );
    }
  }

  // ── Publish / Unpublish ───────────────────────────────────────────────────────

  Future<void> publishHomework() async {
    final current = state.homework;
    if (current == null) return;
    emit(state.copyWith(status: HomeworkDetailsStatus.mutating, errorMessage: null));

    final result = await _updateRemoteUseCase(
      UpdateHomeworkRequestData(homeworkName: current.name, published: 1),
    );
    switch (result) {
      case ApiSuccess(data: final updated):
        emit(state.copyWith(status: HomeworkDetailsStatus.success, homework: updated));
      case ApiFailure(error: final error):
        emit(state.copyWith(status: HomeworkDetailsStatus.failure, errorMessage: error.message));
    }
  }

  Future<void> unpublishHomework() async {
    final current = state.homework;
    if (current == null) return;
    emit(state.copyWith(status: HomeworkDetailsStatus.mutating, errorMessage: null));

    final result = await _updateRemoteUseCase(
      UpdateHomeworkRequestData(homeworkName: current.name, published: 0),
    );
    switch (result) {
      case ApiSuccess(data: final updated):
        emit(state.copyWith(status: HomeworkDetailsStatus.success, homework: updated));
      case ApiFailure(error: final error):
        emit(state.copyWith(status: HomeworkDetailsStatus.failure, errorMessage: error.message));
    }
  }

  // ── Delete ────────────────────────────────────────────────────────────────────

  Future<bool> deleteHomework() async {
    final current = state.homework;
    if (current == null) return false;
    emit(state.copyWith(status: HomeworkDetailsStatus.mutating, errorMessage: null));

    final result = await _deleteUseCase(current.name);
    switch (result) {
      case ApiSuccess():
        return true;
      case ApiFailure(error: final error):
        emit(state.copyWith(status: HomeworkDetailsStatus.failure, errorMessage: error.message));
        return false;
    }
  }

  // ── Batch Question Save (from slider) ─────────────────────────────────────────

  /// Called by HomeworkQuestionsSliderScreen on "Done".
  /// [additions] — list of payloads to add (bank ref or inline).
  /// [deletions] — set of existing question names to remove.
  /// [marksUpdates] — list of {question, marks} for mark-only changes.
  Future<void> saveHomeworkQuestions(
    List<Map<String, dynamic>> additions,
    Set<String> deletions, {
    List<Map<String, dynamic>> marksUpdates = const [],
  }) async {
    final current = state.homework;
    if (current == null) return;

    final total = additions.length + deletions.length + marksUpdates.length;
    final errors = <String>[];
    int progress = 0;

    emit(state.copyWith(
      isBatchSaving: true,
      batchTotal: total,
      batchProgress: 0,
      batchErrors: const [],
    ));

    // 1. Deletions
    for (final qName in deletions) {
      final result = await _removeQuestionUseCase(
        homeworkName: current.name,
        questionName: qName,
      );
      if (result case ApiFailure(error: final e)) {
        errors.add('Remove $qName: ${e.message}');
      }
      progress++;
      emit(state.copyWith(batchProgress: progress, batchErrors: List.of(errors)));
    }

    // 2. Additions and marks updates via update_homework
    final allQuestionUpdates = [...marksUpdates, ...additions];
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
                errors.add('Upload attachment failed: ${failure.message}');
              },
            );
            if (hasError) break;
          }
        }
      }

      if (errors.isEmpty) {
        final result = await _updateRemoteUseCase(
          UpdateHomeworkRequestData(
            homeworkName: current.name,
            questions: allQuestionUpdates,
          ),
        );
        if (result case ApiFailure(error: final e)) {
          errors.add('Update questions: ${e.message}');
        }
      }
      progress += allQuestionUpdates.length;
      emit(state.copyWith(batchProgress: progress, batchErrors: List.of(errors)));
    }

    // Reload fresh data
    await loadHomework(current.name);

    emit(state.copyWith(
      isBatchSaving: false,
      batchErrors: List.of(errors),
    ));
  }

  // ── Legacy individual question methods (kept for compatibility) ───────────────

  Future<void> addBankQuestion(String questionName, int marks) async {
    final current = state.homework;
    if (current == null) return;
    emit(state.copyWith(status: HomeworkDetailsStatus.mutating, errorMessage: null));

    final result = await _addQuestionUseCase(
      homeworkName: current.name,
      questionName: questionName,
      marks: marks,
    );
    switch (result) {
      case ApiSuccess():
        await loadHomework(current.name);
      case ApiFailure(error: final error):
        emit(state.copyWith(status: HomeworkDetailsStatus.failure, errorMessage: error.message));
    }
  }

  Future<void> removeQuestion(String questionName) async {
    final current = state.homework;
    if (current == null) return;
    emit(state.copyWith(status: HomeworkDetailsStatus.mutating, errorMessage: null));

    final result = await _removeQuestionUseCase(
      homeworkName: current.name,
      questionName: questionName,
    );
    switch (result) {
      case ApiSuccess():
        await loadHomework(current.name);
      case ApiFailure(error: final error):
        emit(state.copyWith(status: HomeworkDetailsStatus.failure, errorMessage: error.message));
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────────

  String _formatDate(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
