import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/upload_file_usecase.dart';
import '../../domain/usecases/question_usecases.dart';
import 'question_form_state.dart';

class QuestionFormCubit extends Cubit<QuestionFormState> {
  QuestionFormCubit(this._createQuestionUseCase, this._updateQuestionUseCase, this._uploadFileUseCase)
    : super(const QuestionFormState.initial());

  final CreateQuestionUseCase _createQuestionUseCase;
  final UpdateQuestionUseCase _updateQuestionUseCase;
  final UploadFileUseCase _uploadFileUseCase;

  Future<void> createQuestion(Map<String, dynamic> body) async {
    emit(const QuestionFormState.submitting());

    if (body.containsKey('local_attachment_path')) {
      final path = body.remove('local_attachment_path') as String;
      final uploadResult = await _uploadFileUseCase(file: File(path), isPrivate: 0);
      var hasError = false;
      uploadResult.when(
        success: (url) {
          body['attachment'] = url;
        },
        failure: (f) {
          hasError = true;
          emit(QuestionFormState.error(f.message));
        },
      );
      if (hasError) return;
    }
    final result = await _createQuestionUseCase(body);
    result.when(
      success: (question) => emit(QuestionFormState.success(question)),
      failure: (failure) => emit(QuestionFormState.error(failure.message)),
    );
  }

  Future<void> updateQuestion(Map<String, dynamic> body) async {
    emit(const QuestionFormState.submitting());

    if (body.containsKey('local_attachment_path')) {
      final path = body.remove('local_attachment_path') as String;
      final uploadResult = await _uploadFileUseCase(file: File(path), isPrivate: 0);
      var hasError = false;
      uploadResult.when(
        success: (url) {
          body['attachment'] = url;
        },
        failure: (f) {
          hasError = true;
          emit(QuestionFormState.error(f.message));
        },
      );
      if (hasError) return;
    }

    final result = await _updateQuestionUseCase(body);
    result.when(
      success: (question) => emit(QuestionFormState.success(question)),
      failure: (failure) => emit(QuestionFormState.error(failure.message)),
    );
  }
}
