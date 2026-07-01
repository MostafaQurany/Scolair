import 'package:freezed_annotation/freezed_annotation.dart';

part 'homework_form_state.freezed.dart';

@freezed
abstract class HomeworkFormState with _$HomeworkFormState {
  const factory HomeworkFormState.initial() = _Initial;
  const factory HomeworkFormState.submitting() = _Submitting;
  const factory HomeworkFormState.success() = _Success;
  const factory HomeworkFormState.error(String message) = _Error;
}
