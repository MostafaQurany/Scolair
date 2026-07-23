import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/courses_models.dart';

part 'course_students_state.freezed.dart';

@freezed
abstract class CourseStudentsState with _$CourseStudentsState {
  const factory CourseStudentsState({
    String? courseName,
    @Default(false) bool isLoading,
    @Default(false) bool isAdding,
    @Default(false) bool isRemoving,
    @Default([]) List<StudentModel> students,
    String? errorMessage,
    String? successMessage,
  }) = _CourseStudentsState;
}
