import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/courses_usecases.dart';
import 'course_form_state.dart';

class CourseFormCubit extends Cubit<CourseFormState> {
  CourseFormCubit(
    this._createCourseUseCase,
    this._updateCourseUseCase,
    this._uploadFileUseCase,
  ) : super(const CourseFormState.initial());

  final CreateCourseUseCase _createCourseUseCase;
  final UpdateCourseUseCase _updateCourseUseCase;
  final UploadFileUseCase _uploadFileUseCase;

  Future<void> createCourse({
    required String title,
    required String description,
    required String shortIntroduction,
    required String tags,
    required bool published,
    required String videoLink,
    required String image,
    File? imageFile,
    required bool enableCertification,
  }) async {
    emit(const CourseFormState.submitting());
    final resolvedImage = await _resolveImage(
      image: image,
      imageFile: imageFile,
      courseName: '',
    );
    if (resolvedImage == null) return;

    final result = await _createCourseUseCase(
      title: title,
      description: description,
      shortIntroduction: shortIntroduction,
      tags: tags,
      published: published,
      videoLink: videoLink,
      image: resolvedImage,
      enableCertification: enableCertification,
    );

    result.when(
      success: (_) => emit(const CourseFormState.success()),
      failure: (fail) => emit(CourseFormState.error(fail.message)),
    );
  }

  Future<void> updateCourse({
    required String courseName,
    required String title,
    String? description,
    String? shortIntroduction,
    String? tags,
    bool? published,
    String? videoLink,
    String? image,
    File? imageFile,
    bool? enableCertification,
  }) async {
    emit(const CourseFormState.submitting());
    final resolvedImage = await _resolveImage(
      image: image ?? '',
      imageFile: imageFile,
      courseName: courseName,
    );
    if (resolvedImage == null) return;

    final result = await _updateCourseUseCase(
      courseName: courseName,
      title: title,
      description: description,
      shortIntroduction: shortIntroduction,
      tags: tags,
      published: published,
      videoLink: videoLink,
      image: resolvedImage,
      enableCertification: enableCertification,
    );

    result.when(
      success: (_) => emit(const CourseFormState.success()),
      failure: (fail) => emit(CourseFormState.error(fail.message)),
    );
  }

  Future<String?> _resolveImage({
    required String image,
    required File? imageFile,
    required String courseName,
  }) async {
    if (imageFile == null) return image.trim();

    final result = await _uploadFileUseCase(
      file: imageFile,
      isPrivate: 0,
      doctype: 'LMS Course',
      docname: courseName,
      fieldname: 'image',
    );

    return result.when(
      success: (url) => url,
      failure: (fail) {
        emit(CourseFormState.error(fail.message));
        return null;
      },
    );
  }
}
