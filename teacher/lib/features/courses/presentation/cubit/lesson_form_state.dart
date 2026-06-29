import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_form_state.freezed.dart';

@freezed
abstract class LessonFormState with _$LessonFormState {
  const factory LessonFormState.initial() = _Initial;
  const factory LessonFormState.submitting() = _Submitting;
  const factory LessonFormState.uploading() = _Uploading;
  const factory LessonFormState.success() = _Success;
  const factory LessonFormState.error(String message) = _Error;
}
