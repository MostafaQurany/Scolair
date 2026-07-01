import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_form_state.freezed.dart';

@freezed
abstract class QuizFormState with _$QuizFormState {
  const factory QuizFormState.initial() = _Initial;
  const factory QuizFormState.submitting() = _Submitting;
  const factory QuizFormState.success() = _Success;
  const factory QuizFormState.error(String message) = _Error;
}
