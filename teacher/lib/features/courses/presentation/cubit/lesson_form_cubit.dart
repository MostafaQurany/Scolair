import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/courses_usecases.dart';
import '../widgets/lesson_content/editor_js_content_builder.dart';
import 'lesson_form_state.dart';

class LessonFormCubit extends Cubit<LessonFormState> {
  LessonFormCubit(
    this._createLessonUseCase,
    this._updateLessonUseCase,
    this._uploadFileUseCase,
  ) : super(const LessonFormState.initial());

  final CreateLessonUseCase _createLessonUseCase;
  final UpdateLessonUseCase _updateLessonUseCase;
  final UploadFileUseCase _uploadFileUseCase;

  Future<void> createLesson({
    required String title,
    required String chapterName,
    required bool includeInPreview,
    required String contentType,
    String? textContent,
    String? youtubeUrl,
    String? quizName,
    String? codeContent,
    String? codeLanguage,
    File? uploadFile,
  }) async {
    Map<String, dynamic>? content;

    // Handle file upload first if needed.
    if (uploadFile != null &&
        (contentType == 'video' || contentType == 'pdf')) {
      emit(const LessonFormState.uploading());

      final uploadResult = await _uploadFileUseCase(
        file: uploadFile,
        isPrivate: 1,
        doctype: 'Course Lesson',
        docname: '',
        fieldname: 'content',
      );

      final fileUrl = uploadResult.when(
        success: (url) => url,
        failure: (fail) {
          emit(LessonFormState.error(fail.message));
          return null;
        },
      );
      if (fileUrl == null) return;

      final fileType = contentType == 'pdf'
          ? 'pdf'
          : _detectFileType(uploadFile.path);
      content = EditorJsContentBuilder.uploadBlock(
        fileUrl: fileUrl,
        fileType: fileType,
      );
    } else {
      content = _buildContent(
        contentType: contentType,
        textContent: textContent,
        youtubeUrl: youtubeUrl,
        quizName: quizName,
        codeContent: codeContent,
        codeLanguage: codeLanguage,
      );
    }

    emit(const LessonFormState.submitting());

    final result = await _createLessonUseCase(
      title: title,
      chapterName: chapterName,
      includeInPreview: includeInPreview,
      content: content,
    );

    result.when(
      success: (_) => emit(const LessonFormState.success()),
      failure: (fail) => emit(LessonFormState.error(fail.message)),
    );
  }

  Future<void> updateLesson({
    required String lessonName,
    required String title,
    required bool includeInPreview,
    required String contentType,
    String? textContent,
    String? youtubeUrl,
    String? quizName,
    String? codeContent,
    String? codeLanguage,
    File? uploadFile,
  }) async {
    Map<String, dynamic>? content;

    if (uploadFile != null &&
        (contentType == 'video' || contentType == 'pdf')) {
      emit(const LessonFormState.uploading());

      final uploadResult = await _uploadFileUseCase(
        file: uploadFile,
        isPrivate: 1,
        doctype: 'Course Lesson',
        docname: lessonName,
        fieldname: 'content',
      );

      final fileUrl = uploadResult.when(
        success: (url) => url,
        failure: (fail) {
          emit(LessonFormState.error(fail.message));
          return null;
        },
      );
      if (fileUrl == null) return;

      final fileType = contentType == 'pdf'
          ? 'pdf'
          : _detectFileType(uploadFile.path);
      content = EditorJsContentBuilder.uploadBlock(
        fileUrl: fileUrl,
        fileType: fileType,
      );
    } else {
      content = _buildContent(
        contentType: contentType,
        textContent: textContent,
        youtubeUrl: youtubeUrl,
        quizName: quizName,
        codeContent: codeContent,
        codeLanguage: codeLanguage,
      );
    }

    emit(const LessonFormState.submitting());

    final result = await _updateLessonUseCase(
      lessonName: lessonName,
      title: title,
      includeInPreview: includeInPreview,
      content: content,
    );

    result.when(
      success: (_) => emit(const LessonFormState.success()),
      failure: (fail) => emit(LessonFormState.error(fail.message)),
    );
  }

  Map<String, dynamic>? _buildContent({
    required String contentType,
    String? textContent,
    String? youtubeUrl,
    String? quizName,
    String? codeContent,
    String? codeLanguage,
  }) {
    switch (contentType) {
      case 'text':
        if (textContent == null || textContent.isEmpty) return null;
        return EditorJsContentBuilder.textBlock(textContent);
      case 'youtube':
        if (youtubeUrl == null || youtubeUrl.isEmpty) return null;
        return EditorJsContentBuilder.youtubeBlock(youtubeUrl);
      case 'quiz':
        if (quizName == null || quizName.isEmpty) return null;
        return EditorJsContentBuilder.quizBlock(quizName);
      case 'code':
        if (codeContent == null || codeContent.isEmpty) return null;
        return EditorJsContentBuilder.codeBlock(
          codeContent,
          language: codeLanguage ?? 'text',
        );
      default:
        return null;
    }
  }

  String _detectFileType(String filePath) {
    final ext = filePath.split('.').last.toLowerCase();
    return switch (ext) {
      'mp4' || 'mov' || 'm4v' || 'webm' => ext,
      _ => 'mp4',
    };
  }
}
