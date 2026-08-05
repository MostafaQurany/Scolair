import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../courses/domain/usecases/courses_usecases.dart' as courses;
import '../../../homework/domain/usecases/homework_usecases.dart' as homework;
import '../../../quiz/data/models/quiz_models.dart';
import '../../../quiz/domain/usecases/quiz_usecases.dart' as quiz;
import '../../data/models/question_filter_data.dart';
import '../../domain/usecases/question_usecases.dart' as question;
import 'question_bank_state.dart';

class QuestionBankCubit extends Cubit<QuestionBankState> {
  QuestionBankCubit(
    this._listQuestionsUseCase,
    this._deleteQuestionUseCase,
    this._listCoursesUseCase,
    this._getChaptersUseCase,
    this._getLessonsUseCase,
    this._listQuizzesUseCase,
    this._listHomeworkUseCase,
  ) : super(const QuestionBankState());

  final question.ListQuestionsUseCase _listQuestionsUseCase;
  final question.DeleteQuestionUseCase _deleteQuestionUseCase;
  final courses.ListCoursesUseCase _listCoursesUseCase;
  final courses.GetChaptersUseCase _getChaptersUseCase;
  final courses.GetLessonsUseCase _getLessonsUseCase;
  final quiz.ListQuizzesUseCase _listQuizzesUseCase;
  final homework.ListHomeworkUseCase _listHomeworkUseCase;

  int _requestId = 0;

  Future<void> loadInitial() async {
    final requestId = ++_requestId;
    emit(state.copyWith(isInitialLoading: true, errorMessage: null));
    await _loadFilterOptions(requestId);
    await _loadFirstPage(requestId, isInitial: true);
  }

  Future<void> refresh() async {
    final requestId = ++_requestId;
    emit(state.copyWith(isRefreshing: true, errorMessage: null));
    await _loadFirstPage(requestId, isRefresh: true);
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasNextPage) return;
    final requestId = ++_requestId;
    emit(state.copyWith(isLoadingMore: true, errorMessage: null));

    final result = await _listQuestionsUseCase(
      filters: state.filters,
      start: state.start + state.pageSize,
      pageSize: state.pageSize,
    );
    if (requestId != _requestId) return;

    result.when(
      success: (page) {
        final nextLoaded = [...state.loadedQuestions, ...page.items];
        emit(
          state.copyWith(
            isLoadingMore: false,
            loadedQuestions: nextLoaded,
            visibleQuestions: _applySearch(nextLoaded, state.searchText),
            start: page.start,
            pageSize: page.pageSize,
            hasNextPage: page.hasNextPage,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(isLoadingMore: false, errorMessage: failure.message),
        );
      },
    );
  }

  void search(String value) {
    final nextSearch = value.trim();
    emit(
      state.copyWith(
        searchText: nextSearch,
        visibleQuestions: _applySearch(state.loadedQuestions, nextSearch),
      ),
    );
  }

  Future<void> updateType(ApiQuestionType? type) async {
    await _applyFilters(state.filters.copyWith(type: type));
  }

  Future<void> updateQuiz(String? quiz) async {
    await _applyFilters(state.filters.copyWith(quiz: quiz));
  }

  Future<void> updateHomework(String? homework) async {
    await _applyFilters(state.filters.copyWith(homework: homework));
  }

  Future<void> updateCourse(String? course) async {
    final nextFilters = state.filters.copyWith(
      course: course,
      chapter: null,
      lesson: null,
    );
    emit(
      state.copyWith(
        filters: nextFilters,
        chapters: const [],
        lessons: const [],
      ),
    );
    if (course != null) {
      await _loadChapters(course);
    }
    await _applyFilters(nextFilters);
  }

  Future<void> updateChapter(String? chapter) async {
    final nextFilters = state.filters.copyWith(chapter: chapter, lesson: null);
    emit(state.copyWith(filters: nextFilters, lessons: const []));
    if (chapter != null) {
      await _loadLessons(chapter);
    }
    await _applyFilters(nextFilters);
  }

  Future<void> updateLesson(String? lesson) async {
    await _applyFilters(state.filters.copyWith(lesson: lesson));
  }

  Future<void> clearFilters() async {
    emit(state.copyWith(chapters: const [], lessons: const []));
    await _applyFilters(const QuestionFilterData());
  }

  void toggleSelection(QuestionModel question) {
    final selected = Map<String, QuestionModel>.of(state.selectedQuestions);
    if (selected.containsKey(question.name)) {
      selected.remove(question.name);
    } else {
      selected[question.name] = question;
    }
    emit(state.copyWith(selectedQuestions: selected));
  }

  void clearSelection() {
    emit(state.copyWith(selectedQuestions: const {}));
  }

  Future<void> deleteQuestion(String questionName) async {
    emit(
      state.copyWith(
        isMutating: true,
        mutationError: null,
        mutationSuccess: null,
      ),
    );
    final result = await _deleteQuestionUseCase(questionName);
    result.when(
      success: (_) {
        final nextLoaded = state.loadedQuestions
            .where((question) => question.name != questionName)
            .toList();
        final nextSelected = Map<String, QuestionModel>.of(
          state.selectedQuestions,
        )..remove(questionName);
        emit(
          state.copyWith(
            isMutating: false,
            loadedQuestions: nextLoaded,
            visibleQuestions: _applySearch(nextLoaded, state.searchText),
            selectedQuestions: nextSelected,
            mutationSuccess: 'questionDeleted',
          ),
        );
      },
      failure: (failure) {
        emit(state.copyWith(isMutating: false, mutationError: failure.message));
      },
    );
  }

  void clearMutationState() {
    emit(state.copyWith(mutationError: null, mutationSuccess: null));
  }

  Future<void> _applyFilters(QuestionFilterData filters) async {
    final requestId = ++_requestId;
    emit(
      state.copyWith(filters: filters, isFiltering: true, errorMessage: null),
    );
    await _loadFirstPage(requestId, filters: filters, isFiltering: true);
  }

  Future<void> _loadFirstPage(
    int requestId, {
    QuestionFilterData? filters,
    bool isInitial = false,
    bool isRefresh = false,
    bool isFiltering = false,
  }) async {
    final nextFilters = filters ?? state.filters;
    final result = await _listQuestionsUseCase(
      filters: nextFilters,
      pageSize: state.pageSize,
    );
    if (requestId != _requestId) return;

    result.when(
      success: (page) {
        emit(
          state.copyWith(
            isInitialLoading: false,
            isRefreshing: false,
            isFiltering: false,
            loadedQuestions: page.items,
            visibleQuestions: _applySearch(page.items, state.searchText),
            start: page.start,
            pageSize: page.pageSize,
            hasNextPage: page.hasNextPage,
            filters: nextFilters,
            errorMessage: null,
          ),
        );
      },
      failure: (failure) {
        emit(
          state.copyWith(
            isInitialLoading: false,
            isRefreshing: false,
            isFiltering: false,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> _loadFilterOptions(int requestId) async {
    final coursesResult = await _listCoursesUseCase(pageSize: 100);
    if (requestId != _requestId) return;
    coursesResult.when(
      success: (page) => emit(state.copyWith(courses: page.items)),
      failure: (_) {},
    );

    final quizzesResult = await _listQuizzesUseCase(pageSize: 100);
    if (requestId != _requestId) return;
    quizzesResult.when(
      success: (page) => emit(state.copyWith(quizzes: page.items)),
      failure: (_) {},
    );

    final homeworkResult = await _listHomeworkUseCase();
    if (requestId != _requestId) return;
    homeworkResult.when(
      success: (items) => emit(state.copyWith(homework: items)),
      failure: (_) {},
    );
  }

  Future<void> _loadChapters(String courseName) async {
    final result = await _getChaptersUseCase(courseName, pageSize: 100);
    result.when(
      success: (page) => emit(state.copyWith(chapters: page.items)),
      failure: (failure) => emit(state.copyWith(errorMessage: failure.message)),
    );
  }

  Future<void> _loadLessons(String chapterName) async {
    final result = await _getLessonsUseCase(chapterName, pageSize: 100);
    result.when(
      success: (page) => emit(state.copyWith(lessons: page.items)),
      failure: (failure) => emit(state.copyWith(errorMessage: failure.message)),
    );
  }

  List<QuestionModel> _applySearch(
    List<QuestionModel> questions,
    String searchText,
  ) {
    final normalized = searchText.trim().toLowerCase();
    if (normalized.isEmpty) return questions;
    return questions
        .where(
          (question) =>
              question.name.toLowerCase().contains(normalized) ||
              question.question.toLowerCase().contains(normalized),
        )
        .toList();
  }
}
