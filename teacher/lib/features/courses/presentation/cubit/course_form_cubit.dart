import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/courses_models.dart';
import '../../domain/usecases/courses_usecases.dart';
import 'course_form_state.dart';

class CourseFormCubit extends Cubit<CourseFormState> {
  CourseFormCubit(this._createCourseUseCase, this._updateCourseUseCase)
    : super(const CourseFormState.initial());

  final CreateCourseUseCase _createCourseUseCase;
  final UpdateCourseUseCase _updateCourseUseCase;

  Future<void> createCourse({
    required String title,
    required String description,
    required String shortIntroduction,
    required String tags,
    required bool published,
    required String videoLink,
    required bool enableCertification,
  }) async {
    emit(const CourseFormState.submitting());

    final result = await _createCourseUseCase(
      title: title,
      description: description,
      shortIntroduction: shortIntroduction,
      tags: tags,
      published: published,
      videoLink: videoLink,
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
    bool? enableCertification,
  }) async {
    emit(const CourseFormState.submitting());

    final result = await _updateCourseUseCase(
      courseName: courseName,
      title: title,
      description: description,
      shortIntroduction: shortIntroduction,
      tags: tags,
      published: published,
      videoLink: videoLink,
      enableCertification: enableCertification,
    );

    result.when(
      success: (_) => emit(const CourseFormState.success()),
      failure: (fail) => emit(CourseFormState.error(fail.message)),
    );
  }

  /// Convenience accessor for the existing course when editing.
  CourseModel? editingCourse;

  void setEditingCourse(CourseModel? course) {
    editingCourse = course;
  }
}
