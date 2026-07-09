// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_bank_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionBankState {

 bool get isInitialLoading; bool get isLoadingMore; bool get isFiltering; bool get isRefreshing; bool get isMutating; List<QuestionModel> get loadedQuestions; List<QuestionModel> get visibleQuestions; Map<String, QuestionModel> get selectedQuestions; int get start; int get pageSize; bool get hasNextPage; String get searchText; QuestionFilterData get filters; List<CourseModel> get courses; List<ChapterSummaryModel> get chapters; List<LessonSummaryModel> get lessons; List<QuizSummaryModel> get quizzes; List<HomeworkModel> get homework; String? get errorMessage; String? get mutationSuccess; String? get mutationError;
/// Create a copy of QuestionBankState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionBankStateCopyWith<QuestionBankState> get copyWith => _$QuestionBankStateCopyWithImpl<QuestionBankState>(this as QuestionBankState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionBankState&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isFiltering, isFiltering) || other.isFiltering == isFiltering)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isMutating, isMutating) || other.isMutating == isMutating)&&const DeepCollectionEquality().equals(other.loadedQuestions, loadedQuestions)&&const DeepCollectionEquality().equals(other.visibleQuestions, visibleQuestions)&&const DeepCollectionEquality().equals(other.selectedQuestions, selectedQuestions)&&(identical(other.start, start) || other.start == start)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.filters, filters) || other.filters == filters)&&const DeepCollectionEquality().equals(other.courses, courses)&&const DeepCollectionEquality().equals(other.chapters, chapters)&&const DeepCollectionEquality().equals(other.lessons, lessons)&&const DeepCollectionEquality().equals(other.quizzes, quizzes)&&const DeepCollectionEquality().equals(other.homework, homework)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.mutationSuccess, mutationSuccess) || other.mutationSuccess == mutationSuccess)&&(identical(other.mutationError, mutationError) || other.mutationError == mutationError));
}


@override
int get hashCode => Object.hashAll([runtimeType,isInitialLoading,isLoadingMore,isFiltering,isRefreshing,isMutating,const DeepCollectionEquality().hash(loadedQuestions),const DeepCollectionEquality().hash(visibleQuestions),const DeepCollectionEquality().hash(selectedQuestions),start,pageSize,hasNextPage,searchText,filters,const DeepCollectionEquality().hash(courses),const DeepCollectionEquality().hash(chapters),const DeepCollectionEquality().hash(lessons),const DeepCollectionEquality().hash(quizzes),const DeepCollectionEquality().hash(homework),errorMessage,mutationSuccess,mutationError]);

@override
String toString() {
  return 'QuestionBankState(isInitialLoading: $isInitialLoading, isLoadingMore: $isLoadingMore, isFiltering: $isFiltering, isRefreshing: $isRefreshing, isMutating: $isMutating, loadedQuestions: $loadedQuestions, visibleQuestions: $visibleQuestions, selectedQuestions: $selectedQuestions, start: $start, pageSize: $pageSize, hasNextPage: $hasNextPage, searchText: $searchText, filters: $filters, courses: $courses, chapters: $chapters, lessons: $lessons, quizzes: $quizzes, homework: $homework, errorMessage: $errorMessage, mutationSuccess: $mutationSuccess, mutationError: $mutationError)';
}


}

/// @nodoc
abstract mixin class $QuestionBankStateCopyWith<$Res>  {
  factory $QuestionBankStateCopyWith(QuestionBankState value, $Res Function(QuestionBankState) _then) = _$QuestionBankStateCopyWithImpl;
@useResult
$Res call({
 bool isInitialLoading, bool isLoadingMore, bool isFiltering, bool isRefreshing, bool isMutating, List<QuestionModel> loadedQuestions, List<QuestionModel> visibleQuestions, Map<String, QuestionModel> selectedQuestions, int start, int pageSize, bool hasNextPage, String searchText, QuestionFilterData filters, List<CourseModel> courses, List<ChapterSummaryModel> chapters, List<LessonSummaryModel> lessons, List<QuizSummaryModel> quizzes, List<HomeworkModel> homework, String? errorMessage, String? mutationSuccess, String? mutationError
});




}
/// @nodoc
class _$QuestionBankStateCopyWithImpl<$Res>
    implements $QuestionBankStateCopyWith<$Res> {
  _$QuestionBankStateCopyWithImpl(this._self, this._then);

  final QuestionBankState _self;
  final $Res Function(QuestionBankState) _then;

/// Create a copy of QuestionBankState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isInitialLoading = null,Object? isLoadingMore = null,Object? isFiltering = null,Object? isRefreshing = null,Object? isMutating = null,Object? loadedQuestions = null,Object? visibleQuestions = null,Object? selectedQuestions = null,Object? start = null,Object? pageSize = null,Object? hasNextPage = null,Object? searchText = null,Object? filters = null,Object? courses = null,Object? chapters = null,Object? lessons = null,Object? quizzes = null,Object? homework = null,Object? errorMessage = freezed,Object? mutationSuccess = freezed,Object? mutationError = freezed,}) {
  return _then(QuestionBankState(
isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isFiltering: null == isFiltering ? _self.isFiltering : isFiltering // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isMutating: null == isMutating ? _self.isMutating : isMutating // ignore: cast_nullable_to_non_nullable
as bool,loadedQuestions: null == loadedQuestions ? _self.loadedQuestions : loadedQuestions // ignore: cast_nullable_to_non_nullable
as List<QuestionModel>,visibleQuestions: null == visibleQuestions ? _self.visibleQuestions : visibleQuestions // ignore: cast_nullable_to_non_nullable
as List<QuestionModel>,selectedQuestions: null == selectedQuestions ? _self.selectedQuestions : selectedQuestions // ignore: cast_nullable_to_non_nullable
as Map<String, QuestionModel>,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as QuestionFilterData,courses: null == courses ? _self.courses : courses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterSummaryModel>,lessons: null == lessons ? _self.lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonSummaryModel>,quizzes: null == quizzes ? _self.quizzes : quizzes // ignore: cast_nullable_to_non_nullable
as List<QuizSummaryModel>,homework: null == homework ? _self.homework : homework // ignore: cast_nullable_to_non_nullable
as List<HomeworkModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,mutationSuccess: freezed == mutationSuccess ? _self.mutationSuccess : mutationSuccess // ignore: cast_nullable_to_non_nullable
as String?,mutationError: freezed == mutationError ? _self.mutationError : mutationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionBankState].
extension QuestionBankStatePatterns on QuestionBankState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionBankState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionBankState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionBankState value)  $default,){
final _that = this;
switch (_that) {
case _QuestionBankState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionBankState value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionBankState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isInitialLoading,  bool isLoadingMore,  bool isFiltering,  bool isRefreshing,  bool isMutating,  List<QuestionModel> loadedQuestions,  List<QuestionModel> visibleQuestions,  Map<String, QuestionModel> selectedQuestions,  int start,  int pageSize,  bool hasNextPage,  String searchText,  QuestionFilterData filters,  List<CourseModel> courses,  List<ChapterSummaryModel> chapters,  List<LessonSummaryModel> lessons,  List<QuizSummaryModel> quizzes,  List<HomeworkModel> homework,  String? errorMessage,  String? mutationSuccess,  String? mutationError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionBankState() when $default != null:
return $default(_that.isInitialLoading,_that.isLoadingMore,_that.isFiltering,_that.isRefreshing,_that.isMutating,_that.loadedQuestions,_that.visibleQuestions,_that.selectedQuestions,_that.start,_that.pageSize,_that.hasNextPage,_that.searchText,_that.filters,_that.courses,_that.chapters,_that.lessons,_that.quizzes,_that.homework,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isInitialLoading,  bool isLoadingMore,  bool isFiltering,  bool isRefreshing,  bool isMutating,  List<QuestionModel> loadedQuestions,  List<QuestionModel> visibleQuestions,  Map<String, QuestionModel> selectedQuestions,  int start,  int pageSize,  bool hasNextPage,  String searchText,  QuestionFilterData filters,  List<CourseModel> courses,  List<ChapterSummaryModel> chapters,  List<LessonSummaryModel> lessons,  List<QuizSummaryModel> quizzes,  List<HomeworkModel> homework,  String? errorMessage,  String? mutationSuccess,  String? mutationError)  $default,) {final _that = this;
switch (_that) {
case _QuestionBankState():
return $default(_that.isInitialLoading,_that.isLoadingMore,_that.isFiltering,_that.isRefreshing,_that.isMutating,_that.loadedQuestions,_that.visibleQuestions,_that.selectedQuestions,_that.start,_that.pageSize,_that.hasNextPage,_that.searchText,_that.filters,_that.courses,_that.chapters,_that.lessons,_that.quizzes,_that.homework,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isInitialLoading,  bool isLoadingMore,  bool isFiltering,  bool isRefreshing,  bool isMutating,  List<QuestionModel> loadedQuestions,  List<QuestionModel> visibleQuestions,  Map<String, QuestionModel> selectedQuestions,  int start,  int pageSize,  bool hasNextPage,  String searchText,  QuestionFilterData filters,  List<CourseModel> courses,  List<ChapterSummaryModel> chapters,  List<LessonSummaryModel> lessons,  List<QuizSummaryModel> quizzes,  List<HomeworkModel> homework,  String? errorMessage,  String? mutationSuccess,  String? mutationError)?  $default,) {final _that = this;
switch (_that) {
case _QuestionBankState() when $default != null:
return $default(_that.isInitialLoading,_that.isLoadingMore,_that.isFiltering,_that.isRefreshing,_that.isMutating,_that.loadedQuestions,_that.visibleQuestions,_that.selectedQuestions,_that.start,_that.pageSize,_that.hasNextPage,_that.searchText,_that.filters,_that.courses,_that.chapters,_that.lessons,_that.quizzes,_that.homework,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionBankState implements QuestionBankState {
  const _QuestionBankState({this.isInitialLoading = false, this.isLoadingMore = false, this.isFiltering = false, this.isRefreshing = false, this.isMutating = false,  List<QuestionModel> loadedQuestions = const <QuestionModel>[],  List<QuestionModel> visibleQuestions = const <QuestionModel>[],  Map<String, QuestionModel> selectedQuestions = const <String, QuestionModel>{}, this.start = 0, this.pageSize = 30, this.hasNextPage = false, this.searchText = '', this.filters = const QuestionFilterData(),  List<CourseModel> courses = const <CourseModel>[],  List<ChapterSummaryModel> chapters = const <ChapterSummaryModel>[],  List<LessonSummaryModel> lessons = const <LessonSummaryModel>[],  List<QuizSummaryModel> quizzes = const <QuizSummaryModel>[],  List<HomeworkModel> homework = const <HomeworkModel>[], this.errorMessage, this.mutationSuccess, this.mutationError}): _loadedQuestions = loadedQuestions,_visibleQuestions = visibleQuestions,_selectedQuestions = selectedQuestions,_courses = courses,_chapters = chapters,_lessons = lessons,_quizzes = quizzes,_homework = homework;
  

@override@JsonKey() final  bool isInitialLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool isFiltering;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool isMutating;
 final  List<QuestionModel> _loadedQuestions;
@override@JsonKey() List<QuestionModel> get loadedQuestions {
  if (_loadedQuestions is EqualUnmodifiableListView) return _loadedQuestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_loadedQuestions);
}

 final  List<QuestionModel> _visibleQuestions;
@override@JsonKey() List<QuestionModel> get visibleQuestions {
  if (_visibleQuestions is EqualUnmodifiableListView) return _visibleQuestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visibleQuestions);
}

 final  Map<String, QuestionModel> _selectedQuestions;
@override@JsonKey() Map<String, QuestionModel> get selectedQuestions {
  if (_selectedQuestions is EqualUnmodifiableMapView) return _selectedQuestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selectedQuestions);
}

@override@JsonKey() final  int start;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  bool hasNextPage;
@override@JsonKey() final  String searchText;
@override@JsonKey() final  QuestionFilterData filters;
 final  List<CourseModel> _courses;
@override@JsonKey() List<CourseModel> get courses {
  if (_courses is EqualUnmodifiableListView) return _courses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_courses);
}

 final  List<ChapterSummaryModel> _chapters;
@override@JsonKey() List<ChapterSummaryModel> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}

 final  List<LessonSummaryModel> _lessons;
@override@JsonKey() List<LessonSummaryModel> get lessons {
  if (_lessons is EqualUnmodifiableListView) return _lessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessons);
}

 final  List<QuizSummaryModel> _quizzes;
@override@JsonKey() List<QuizSummaryModel> get quizzes {
  if (_quizzes is EqualUnmodifiableListView) return _quizzes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_quizzes);
}

 final  List<HomeworkModel> _homework;
@override@JsonKey() List<HomeworkModel> get homework {
  if (_homework is EqualUnmodifiableListView) return _homework;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_homework);
}

@override final  String? errorMessage;
@override final  String? mutationSuccess;
@override final  String? mutationError;

/// Create a copy of QuestionBankState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionBankStateCopyWith<_QuestionBankState> get copyWith => __$QuestionBankStateCopyWithImpl<_QuestionBankState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionBankState&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isFiltering, isFiltering) || other.isFiltering == isFiltering)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isMutating, isMutating) || other.isMutating == isMutating)&&const DeepCollectionEquality().equals(other._loadedQuestions, _loadedQuestions)&&const DeepCollectionEquality().equals(other._visibleQuestions, _visibleQuestions)&&const DeepCollectionEquality().equals(other._selectedQuestions, _selectedQuestions)&&(identical(other.start, start) || other.start == start)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.filters, filters) || other.filters == filters)&&const DeepCollectionEquality().equals(other._courses, _courses)&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&const DeepCollectionEquality().equals(other._lessons, _lessons)&&const DeepCollectionEquality().equals(other._quizzes, _quizzes)&&const DeepCollectionEquality().equals(other._homework, _homework)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.mutationSuccess, mutationSuccess) || other.mutationSuccess == mutationSuccess)&&(identical(other.mutationError, mutationError) || other.mutationError == mutationError));
}


@override
int get hashCode => Object.hashAll([runtimeType,isInitialLoading,isLoadingMore,isFiltering,isRefreshing,isMutating,const DeepCollectionEquality().hash(_loadedQuestions),const DeepCollectionEquality().hash(_visibleQuestions),const DeepCollectionEquality().hash(_selectedQuestions),start,pageSize,hasNextPage,searchText,filters,const DeepCollectionEquality().hash(_courses),const DeepCollectionEquality().hash(_chapters),const DeepCollectionEquality().hash(_lessons),const DeepCollectionEquality().hash(_quizzes),const DeepCollectionEquality().hash(_homework),errorMessage,mutationSuccess,mutationError]);

@override
String toString() {
  return 'QuestionBankState(isInitialLoading: $isInitialLoading, isLoadingMore: $isLoadingMore, isFiltering: $isFiltering, isRefreshing: $isRefreshing, isMutating: $isMutating, loadedQuestions: $loadedQuestions, visibleQuestions: $visibleQuestions, selectedQuestions: $selectedQuestions, start: $start, pageSize: $pageSize, hasNextPage: $hasNextPage, searchText: $searchText, filters: $filters, courses: $courses, chapters: $chapters, lessons: $lessons, quizzes: $quizzes, homework: $homework, errorMessage: $errorMessage, mutationSuccess: $mutationSuccess, mutationError: $mutationError)';
}


}

/// @nodoc
abstract mixin class _$QuestionBankStateCopyWith<$Res> implements $QuestionBankStateCopyWith<$Res> {
  factory _$QuestionBankStateCopyWith(_QuestionBankState value, $Res Function(_QuestionBankState) _then) = __$QuestionBankStateCopyWithImpl;
@override @useResult
$Res call({
 bool isInitialLoading, bool isLoadingMore, bool isFiltering, bool isRefreshing, bool isMutating, List<QuestionModel> loadedQuestions, List<QuestionModel> visibleQuestions, Map<String, QuestionModel> selectedQuestions, int start, int pageSize, bool hasNextPage, String searchText, QuestionFilterData filters, List<CourseModel> courses, List<ChapterSummaryModel> chapters, List<LessonSummaryModel> lessons, List<QuizSummaryModel> quizzes, List<HomeworkModel> homework, String? errorMessage, String? mutationSuccess, String? mutationError
});




}
/// @nodoc
class __$QuestionBankStateCopyWithImpl<$Res>
    implements _$QuestionBankStateCopyWith<$Res> {
  __$QuestionBankStateCopyWithImpl(this._self, this._then);

  final _QuestionBankState _self;
  final $Res Function(_QuestionBankState) _then;

/// Create a copy of QuestionBankState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isInitialLoading = null,Object? isLoadingMore = null,Object? isFiltering = null,Object? isRefreshing = null,Object? isMutating = null,Object? loadedQuestions = null,Object? visibleQuestions = null,Object? selectedQuestions = null,Object? start = null,Object? pageSize = null,Object? hasNextPage = null,Object? searchText = null,Object? filters = null,Object? courses = null,Object? chapters = null,Object? lessons = null,Object? quizzes = null,Object? homework = null,Object? errorMessage = freezed,Object? mutationSuccess = freezed,Object? mutationError = freezed,}) {
  return _then(_QuestionBankState(
isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isFiltering: null == isFiltering ? _self.isFiltering : isFiltering // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isMutating: null == isMutating ? _self.isMutating : isMutating // ignore: cast_nullable_to_non_nullable
as bool,loadedQuestions: null == loadedQuestions ? _self._loadedQuestions : loadedQuestions // ignore: cast_nullable_to_non_nullable
as List<QuestionModel>,visibleQuestions: null == visibleQuestions ? _self._visibleQuestions : visibleQuestions // ignore: cast_nullable_to_non_nullable
as List<QuestionModel>,selectedQuestions: null == selectedQuestions ? _self._selectedQuestions : selectedQuestions // ignore: cast_nullable_to_non_nullable
as Map<String, QuestionModel>,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as QuestionFilterData,courses: null == courses ? _self._courses : courses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterSummaryModel>,lessons: null == lessons ? _self._lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonSummaryModel>,quizzes: null == quizzes ? _self._quizzes : quizzes // ignore: cast_nullable_to_non_nullable
as List<QuizSummaryModel>,homework: null == homework ? _self._homework : homework // ignore: cast_nullable_to_non_nullable
as List<HomeworkModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,mutationSuccess: freezed == mutationSuccess ? _self.mutationSuccess : mutationSuccess // ignore: cast_nullable_to_non_nullable
as String?,mutationError: freezed == mutationError ? _self.mutationError : mutationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
