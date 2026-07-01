// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_lessons_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChapterLessonsState {

 String? get chapterName; bool get isInitialLoading; bool get isLoadingMore; List<LessonSummaryModel>? get lessons; int get start; int get pageSize; bool get hasNextPage; String? get errorMessage;
/// Create a copy of ChapterLessonsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterLessonsStateCopyWith<ChapterLessonsState> get copyWith => _$ChapterLessonsStateCopyWithImpl<ChapterLessonsState>(this as ChapterLessonsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterLessonsState&&(identical(other.chapterName, chapterName) || other.chapterName == chapterName)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.lessons, lessons)&&(identical(other.start, start) || other.start == start)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,chapterName,isInitialLoading,isLoadingMore,const DeepCollectionEquality().hash(lessons),start,pageSize,hasNextPage,errorMessage);

@override
String toString() {
  return 'ChapterLessonsState(chapterName: $chapterName, isInitialLoading: $isInitialLoading, isLoadingMore: $isLoadingMore, lessons: $lessons, start: $start, pageSize: $pageSize, hasNextPage: $hasNextPage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ChapterLessonsStateCopyWith<$Res>  {
  factory $ChapterLessonsStateCopyWith(ChapterLessonsState value, $Res Function(ChapterLessonsState) _then) = _$ChapterLessonsStateCopyWithImpl;
@useResult
$Res call({
 String? chapterName, bool isInitialLoading, bool isLoadingMore, List<LessonSummaryModel>? lessons, int start, int pageSize, bool hasNextPage, String? errorMessage
});




}
/// @nodoc
class _$ChapterLessonsStateCopyWithImpl<$Res>
    implements $ChapterLessonsStateCopyWith<$Res> {
  _$ChapterLessonsStateCopyWithImpl(this._self, this._then);

  final ChapterLessonsState _self;
  final $Res Function(ChapterLessonsState) _then;

/// Create a copy of ChapterLessonsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chapterName = freezed,Object? isInitialLoading = null,Object? isLoadingMore = null,Object? lessons = freezed,Object? start = null,Object? pageSize = null,Object? hasNextPage = null,Object? errorMessage = freezed,}) {
  return _then(ChapterLessonsState(
chapterName: freezed == chapterName ? _self.chapterName : chapterName // ignore: cast_nullable_to_non_nullable
as String?,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,lessons: freezed == lessons ? _self.lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonSummaryModel>?,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChapterLessonsState].
extension ChapterLessonsStatePatterns on ChapterLessonsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterLessonsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterLessonsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterLessonsState value)  $default,){
final _that = this;
switch (_that) {
case _ChapterLessonsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterLessonsState value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterLessonsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? chapterName,  bool isInitialLoading,  bool isLoadingMore,  List<LessonSummaryModel>? lessons,  int start,  int pageSize,  bool hasNextPage,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterLessonsState() when $default != null:
return $default(_that.chapterName,_that.isInitialLoading,_that.isLoadingMore,_that.lessons,_that.start,_that.pageSize,_that.hasNextPage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? chapterName,  bool isInitialLoading,  bool isLoadingMore,  List<LessonSummaryModel>? lessons,  int start,  int pageSize,  bool hasNextPage,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ChapterLessonsState():
return $default(_that.chapterName,_that.isInitialLoading,_that.isLoadingMore,_that.lessons,_that.start,_that.pageSize,_that.hasNextPage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? chapterName,  bool isInitialLoading,  bool isLoadingMore,  List<LessonSummaryModel>? lessons,  int start,  int pageSize,  bool hasNextPage,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ChapterLessonsState() when $default != null:
return $default(_that.chapterName,_that.isInitialLoading,_that.isLoadingMore,_that.lessons,_that.start,_that.pageSize,_that.hasNextPage,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ChapterLessonsState implements ChapterLessonsState {
  const _ChapterLessonsState({this.chapterName, this.isInitialLoading = false, this.isLoadingMore = false,  List<LessonSummaryModel>? lessons, this.start = 0, this.pageSize = 30, this.hasNextPage = false, this.errorMessage}): _lessons = lessons;
  

@override final  String? chapterName;
@override@JsonKey() final  bool isInitialLoading;
@override@JsonKey() final  bool isLoadingMore;
 final  List<LessonSummaryModel>? _lessons;
@override List<LessonSummaryModel>? get lessons {
  final value = _lessons;
  if (value == null) return null;
  if (_lessons is EqualUnmodifiableListView) return _lessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  int start;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  bool hasNextPage;
@override final  String? errorMessage;

/// Create a copy of ChapterLessonsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterLessonsStateCopyWith<_ChapterLessonsState> get copyWith => __$ChapterLessonsStateCopyWithImpl<_ChapterLessonsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterLessonsState&&(identical(other.chapterName, chapterName) || other.chapterName == chapterName)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other._lessons, _lessons)&&(identical(other.start, start) || other.start == start)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,chapterName,isInitialLoading,isLoadingMore,const DeepCollectionEquality().hash(_lessons),start,pageSize,hasNextPage,errorMessage);

@override
String toString() {
  return 'ChapterLessonsState(chapterName: $chapterName, isInitialLoading: $isInitialLoading, isLoadingMore: $isLoadingMore, lessons: $lessons, start: $start, pageSize: $pageSize, hasNextPage: $hasNextPage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ChapterLessonsStateCopyWith<$Res> implements $ChapterLessonsStateCopyWith<$Res> {
  factory _$ChapterLessonsStateCopyWith(_ChapterLessonsState value, $Res Function(_ChapterLessonsState) _then) = __$ChapterLessonsStateCopyWithImpl;
@override @useResult
$Res call({
 String? chapterName, bool isInitialLoading, bool isLoadingMore, List<LessonSummaryModel>? lessons, int start, int pageSize, bool hasNextPage, String? errorMessage
});




}
/// @nodoc
class __$ChapterLessonsStateCopyWithImpl<$Res>
    implements _$ChapterLessonsStateCopyWith<$Res> {
  __$ChapterLessonsStateCopyWithImpl(this._self, this._then);

  final _ChapterLessonsState _self;
  final $Res Function(_ChapterLessonsState) _then;

/// Create a copy of ChapterLessonsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chapterName = freezed,Object? isInitialLoading = null,Object? isLoadingMore = null,Object? lessons = freezed,Object? start = null,Object? pageSize = null,Object? hasNextPage = null,Object? errorMessage = freezed,}) {
  return _then(_ChapterLessonsState(
chapterName: freezed == chapterName ? _self.chapterName : chapterName // ignore: cast_nullable_to_non_nullable
as String?,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,lessons: freezed == lessons ? _self._lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<LessonSummaryModel>?,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
