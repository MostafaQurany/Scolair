import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/courses_models.dart';

part 'lesson_details_state.freezed.dart';

@freezed
abstract class LessonDetailsState with _$LessonDetailsState {
  const factory LessonDetailsState({
    @Default(false) bool isLoading,
    LessonDetailModel? lesson,
    String? errorMessage,
  }) = _LessonDetailsState;
}
