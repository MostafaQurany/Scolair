import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/courses_models.dart';

part 'courses_state.freezed.dart';

@freezed
abstract class CoursesState with _$CoursesState {
  const factory CoursesState({
    @Default(false) bool isLoading,
    List<CourseModel>? allCourses,
    List<CourseModel>? myCourses,
    String? errorMessage,
  }) = _CoursesState;
}
