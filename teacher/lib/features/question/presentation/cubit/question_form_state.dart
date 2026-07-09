import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../quiz/data/models/quiz_models.dart';

part 'question_form_state.freezed.dart';

@freezed
abstract class QuestionFormState with _$QuestionFormState {
  const factory QuestionFormState.initial() = _Initial;
  const factory QuestionFormState.submitting() = _Submitting;
  const factory QuestionFormState.success(QuestionModel question) = _Success;
  const factory QuestionFormState.error(String message) = _Error;
}
