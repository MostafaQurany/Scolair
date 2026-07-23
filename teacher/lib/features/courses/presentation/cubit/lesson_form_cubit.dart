import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/upload_file_usecase.dart';
import '../../domain/usecases/courses_usecases.dart';
import '../widgets/lesson_content/editor_js_content_builder.dart';
import '../widgets/lesson_form/lesson_part_data.dart';
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
    required List<LessonPartData> parts,
  }) async {
    final content = await _buildContent(parts: parts, lessonName: '');
    if (content == null) return;

    emit(const LessonFormState.submitting());
    final result = await _createLessonUseCase(
      title: title,
      chapterName: chapterName,
      includeInPreview: includeInPreview,
      content: content,
    );
    result.when(
      success: (_) => emit(const LessonFormState.success()),
      failure: (failure) => emit(LessonFormState.error(failure.message)),
    );
  }

  Future<void> updateLesson({
    required String lessonName,
    required String title,
    required bool includeInPreview,
    required List<LessonPartData> parts,
  }) async {
    final content = await _buildContent(parts: parts, lessonName: lessonName);
    if (content == null) return;

    emit(const LessonFormState.submitting());
    final result = await _updateLessonUseCase(
      lessonName: lessonName,
      title: title,
      includeInPreview: includeInPreview,
      content: content,
    );
    result.when(
      success: (_) => emit(const LessonFormState.success()),
      failure: (failure) => emit(LessonFormState.error(failure.message)),
    );
  }

  Future<Map<String, dynamic>?> _buildContent({
    required List<LessonPartData> parts,
    required String lessonName,
  }) async {
    final blocks = <Map<String, dynamic>>[];
    for (final part in parts) {
      switch (part.type) {
        case LessonPartType.markdown:
          blocks.add(EditorJsContentBuilder.markdownBlockData(part.text ?? ''));
          break;
        case LessonPartType.youtube:
          blocks.add(EditorJsContentBuilder.youtubeBlockData(part.text ?? ''));
          break;
        case LessonPartType.quiz:
          blocks.add(EditorJsContentBuilder.quizBlockData(part.text ?? ''));
          break;
        case LessonPartType.video:
        case LessonPartType.pdf:
          final fileUrl = await _resolveUpload(part, lessonName);
          if (fileUrl == null) return null;
          blocks.add(
            EditorJsContentBuilder.uploadBlockData(
              fileUrl: fileUrl,
              fileType: _fileTypeForPart(part),
            ),
          );
          break;
      }
    }

    return EditorJsContentBuilder.fromBlocks(blocks);
  }

  Future<String?> _resolveUpload(LessonPartData part, String lessonName) async {
    if (part.uploadFile == null) return part.existingFileUrl;

    emit(const LessonFormState.uploading());
    final result = await _uploadFileUseCase(
      file: part.uploadFile!,
      isPrivate: 1,
    );

    return result.when(
      success: (url) => url,
      failure: (failure) {
        emit(LessonFormState.error(failure.message));
        return null;
      },
    );
  }

  String _fileTypeForPart(LessonPartData part) {
    if (part.type == LessonPartType.pdf) return 'pdf';
    return _detectFileType(part.uploadFile, part.existingFileType);
  }

  String _detectFileType(File? file, String? existingFileType) {
    if (file == null) return existingFileType ?? 'mp4';
    final extension = file.path.split('.').last.toLowerCase();
    return switch (extension) {
      'mp4' || 'mov' || 'm4v' || 'webm' => extension,
      _ => 'mp4',
    };
  }
}
