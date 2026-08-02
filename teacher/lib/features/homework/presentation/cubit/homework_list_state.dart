import '../../../courses/data/models/courses_models.dart';
import '../../data/models/list_homeworks_request_data.dart';
import '../../domain/entities/homework_list_item.dart';

class HomeworkListState {
  const HomeworkListState({
    this.items = const [],
    this.start = 0,
    this.pageSize = 30,
    this.total = 0,
    this.hasNextPage = false,
    this.filter = HomeworkPublishedFilter.all,
    this.isInitialLoading = false,
    this.isRefreshing = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.paginationErrorMessage,
    this.deletingNames = const <String>{},
    this.errorSerial = 0,
    this.searchQuery = '',
    this.selectedCourse,
    this.selectedChapter,
    this.selectedLesson,
    this.courses = const [],
    this.chapters = const [],
    this.lessons = const [],
    this.isLoadingCourses = false,
    this.isLoadingChapters = false,
    this.isLoadingLessons = false,
  });

  final List<HomeworkListItem> items;
  final int start;
  final int pageSize;
  final int total;
  final bool hasNextPage;
  final HomeworkPublishedFilter filter;
  final bool isInitialLoading;
  final bool isRefreshing;
  final bool isLoadingMore;
  final String? errorMessage;
  final String? paginationErrorMessage;
  final Set<String> deletingNames;
  final int errorSerial;
  final String searchQuery;
  final String? selectedCourse;
  final String? selectedChapter;
  final String? selectedLesson;
  final List<CourseModel> courses;
  final List<ChapterSummaryModel> chapters;
  final List<LessonSummaryModel> lessons;
  final bool isLoadingCourses;
  final bool isLoadingChapters;
  final bool isLoadingLessons;

  bool get hasBlockingError => errorMessage != null && items.isEmpty;

  HomeworkListState copyWith({
    List<HomeworkListItem>? items,
    int? start,
    int? pageSize,
    int? total,
    bool? hasNextPage,
    HomeworkPublishedFilter? filter,
    bool? isInitialLoading,
    bool? isRefreshing,
    bool? isLoadingMore,
    String? errorMessage,
    bool clearError = false,
    String? paginationErrorMessage,
    bool clearPaginationError = false,
    Set<String>? deletingNames,
    int? errorSerial,
    String? searchQuery,
    String? selectedCourse,
    bool clearCourse = false,
    String? selectedChapter,
    bool clearChapter = false,
    String? selectedLesson,
    bool clearLesson = false,
    List<CourseModel>? courses,
    List<ChapterSummaryModel>? chapters,
    List<LessonSummaryModel>? lessons,
    bool? isLoadingCourses,
    bool? isLoadingChapters,
    bool? isLoadingLessons,
  }) => HomeworkListState(
    items: items ?? this.items,
    start: start ?? this.start,
    pageSize: pageSize ?? this.pageSize,
    total: total ?? this.total,
    hasNextPage: hasNextPage ?? this.hasNextPage,
    filter: filter ?? this.filter,
    isInitialLoading: isInitialLoading ?? this.isInitialLoading,
    isRefreshing: isRefreshing ?? this.isRefreshing,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    paginationErrorMessage: clearPaginationError
        ? null
        : paginationErrorMessage ?? this.paginationErrorMessage,
    deletingNames: deletingNames ?? this.deletingNames,
    errorSerial: errorSerial ?? this.errorSerial,
    searchQuery: searchQuery ?? this.searchQuery,
    selectedCourse: clearCourse ? null : selectedCourse ?? this.selectedCourse,
    selectedChapter: clearChapter ? null : selectedChapter ?? this.selectedChapter,
    selectedLesson: clearLesson ? null : selectedLesson ?? this.selectedLesson,
    courses: courses ?? this.courses,
    chapters: chapters ?? this.chapters,
    lessons: lessons ?? this.lessons,
    isLoadingCourses: isLoadingCourses ?? this.isLoadingCourses,
    isLoadingChapters: isLoadingChapters ?? this.isLoadingChapters,
    isLoadingLessons: isLoadingLessons ?? this.isLoadingLessons,
  );
}
