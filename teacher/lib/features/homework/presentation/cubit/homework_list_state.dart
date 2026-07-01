import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/homework_models.dart';

part 'homework_list_state.freezed.dart';

@freezed
abstract class HomeworkListState with _$HomeworkListState {
  const factory HomeworkListState({
    @Default(true) bool isLoading,
    List<HomeworkModel>? homework,
    String? errorMessage,
  }) = _HomeworkListState;
}
