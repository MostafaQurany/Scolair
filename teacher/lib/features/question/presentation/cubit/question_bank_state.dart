import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../courses/data/models/courses_models.dart';
import '../../../homework/data/models/homework_models.dart';
import '../../../quiz/data/models/quiz_models.dart';
import '../../data/models/question_filter_data.dart';

part 'question_bank_state.freezed.dart';

@freezed
abstract class QuestionBankState with _$QuestionBankState {
  const factory QuestionBankState({
    @Default(false) bool isInitialLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isFiltering,
    @Default(false) bool isRefreshing,
    @Default(false) bool isMutating,
    @Default(<QuestionModel>[]) List<QuestionModel> loadedQuestions,
    @Default(<QuestionModel>[]) List<QuestionModel> visibleQuestions,
    @Default(<String, QuestionModel>{})
    Map<String, QuestionModel> selectedQuestions,
    @Default(0) int start,
    @Default(30) int pageSize,
    @Default(false) bool hasNextPage,
    @Default('') String searchText,
    @Default(QuestionFilterData()) QuestionFilterData filters,
    @Default(<CourseModel>[]) List<CourseModel> courses,
    @Default(<ChapterSummaryModel>[]) List<ChapterSummaryModel> chapters,
    @Default(<LessonSummaryModel>[]) List<LessonSummaryModel> lessons,
    @Default(<QuizSummaryModel>[]) List<QuizSummaryModel> quizzes,
    @Default(<HomeworkModel>[]) List<HomeworkModel> homework,
    String? errorMessage,
    String? mutationSuccess,
    String? mutationError,
  }) = _QuestionBankState;
}
