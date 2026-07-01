import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_form_state.freezed.dart';

@freezed
abstract class QuestionFormState with _$QuestionFormState {
  const factory QuestionFormState.initial() = _Initial;
  const factory QuestionFormState.submitting() = _Submitting;
  const factory QuestionFormState.success() = _Success;
  const factory QuestionFormState.error(String message) = _Error;
}
