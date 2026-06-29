import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_form_state.freezed.dart';

@freezed
abstract class CourseFormState with _$CourseFormState {
  const factory CourseFormState.initial() = _Initial;
  const factory CourseFormState.submitting() = _Submitting;
  const factory CourseFormState.success() = _Success;
  const factory CourseFormState.error(String message) = _Error;
}
