import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/quiz_models.dart';

part 'question_bank_state.freezed.dart';

@freezed
class QuestionBankState with _$QuestionBankState {
  const factory QuestionBankState.initial() = _Initial;
  const factory QuestionBankState.loading() = _Loading;
  const factory QuestionBankState.loaded({
    required List<QuestionModel> questions,
    required bool hasReachedMax,
  }) = _Loaded;
  const factory QuestionBankState.error(String message) = _Error;
}
