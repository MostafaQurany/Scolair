// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CourseDetailsState {

 bool get isLoading; bool get isMutating; CourseModel? get course; List<ChapterDetailModel>? get chapters; int get chaptersStart; int get chaptersPageSize; bool get chaptersHasNextPage; bool get isLoadingMoreChapters; String? get errorMessage; String? get mutationSuccess; String? get mutationError;
/// Create a copy of CourseDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseDetailsStateCopyWith<CourseDetailsState> get copyWith => _$CourseDetailsStateCopyWithImpl<CourseDetailsState>(this as CourseDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isMutating, isMutating) || other.isMutating == isMutating)&&(identical(other.course, course) || other.course == course)&&const DeepCollectionEquality().equals(other.chapters, chapters)&&(identical(other.chaptersStart, chaptersStart) || other.chaptersStart == chaptersStart)&&(identical(other.chaptersPageSize, chaptersPageSize) || other.chaptersPageSize == chaptersPageSize)&&(identical(other.chaptersHasNextPage, chaptersHasNextPage) || other.chaptersHasNextPage == chaptersHasNextPage)&&(identical(other.isLoadingMoreChapters, isLoadingMoreChapters) || other.isLoadingMoreChapters == isLoadingMoreChapters)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.mutationSuccess, mutationSuccess) || other.mutationSuccess == mutationSuccess)&&(identical(other.mutationError, mutationError) || other.mutationError == mutationError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isMutating,course,const DeepCollectionEquality().hash(chapters),chaptersStart,chaptersPageSize,chaptersHasNextPage,isLoadingMoreChapters,errorMessage,mutationSuccess,mutationError);

@override
String toString() {
  return 'CourseDetailsState(isLoading: $isLoading, isMutating: $isMutating, course: $course, chapters: $chapters, chaptersStart: $chaptersStart, chaptersPageSize: $chaptersPageSize, chaptersHasNextPage: $chaptersHasNextPage, isLoadingMoreChapters: $isLoadingMoreChapters, errorMessage: $errorMessage, mutationSuccess: $mutationSuccess, mutationError: $mutationError)';
}


}

/// @nodoc
abstract mixin class $CourseDetailsStateCopyWith<$Res>  {
  factory $CourseDetailsStateCopyWith(CourseDetailsState value, $Res Function(CourseDetailsState) _then) = _$CourseDetailsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isMutating, CourseModel? course, List<ChapterDetailModel>? chapters, int chaptersStart, int chaptersPageSize, bool chaptersHasNextPage, bool isLoadingMoreChapters, String? errorMessage, String? mutationSuccess, String? mutationError
});




}
/// @nodoc
class _$CourseDetailsStateCopyWithImpl<$Res>
    implements $CourseDetailsStateCopyWith<$Res> {
  _$CourseDetailsStateCopyWithImpl(this._self, this._then);

  final CourseDetailsState _self;
  final $Res Function(CourseDetailsState) _then;

/// Create a copy of CourseDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isMutating = null,Object? course = freezed,Object? chapters = freezed,Object? chaptersStart = null,Object? chaptersPageSize = null,Object? chaptersHasNextPage = null,Object? isLoadingMoreChapters = null,Object? errorMessage = freezed,Object? mutationSuccess = freezed,Object? mutationError = freezed,}) {
  return _then(CourseDetailsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isMutating: null == isMutating ? _self.isMutating : isMutating // ignore: cast_nullable_to_non_nullable
as bool,course: freezed == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as CourseModel?,chapters: freezed == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterDetailModel>?,chaptersStart: null == chaptersStart ? _self.chaptersStart : chaptersStart // ignore: cast_nullable_to_non_nullable
as int,chaptersPageSize: null == chaptersPageSize ? _self.chaptersPageSize : chaptersPageSize // ignore: cast_nullable_to_non_nullable
as int,chaptersHasNextPage: null == chaptersHasNextPage ? _self.chaptersHasNextPage : chaptersHasNextPage // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMoreChapters: null == isLoadingMoreChapters ? _self.isLoadingMoreChapters : isLoadingMoreChapters // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,mutationSuccess: freezed == mutationSuccess ? _self.mutationSuccess : mutationSuccess // ignore: cast_nullable_to_non_nullable
as String?,mutationError: freezed == mutationError ? _self.mutationError : mutationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseDetailsState].
extension CourseDetailsStatePatterns on CourseDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _CourseDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _CourseDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isMutating,  CourseModel? course,  List<ChapterDetailModel>? chapters,  int chaptersStart,  int chaptersPageSize,  bool chaptersHasNextPage,  bool isLoadingMoreChapters,  String? errorMessage,  String? mutationSuccess,  String? mutationError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseDetailsState() when $default != null:
return $default(_that.isLoading,_that.isMutating,_that.course,_that.chapters,_that.chaptersStart,_that.chaptersPageSize,_that.chaptersHasNextPage,_that.isLoadingMoreChapters,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isMutating,  CourseModel? course,  List<ChapterDetailModel>? chapters,  int chaptersStart,  int chaptersPageSize,  bool chaptersHasNextPage,  bool isLoadingMoreChapters,  String? errorMessage,  String? mutationSuccess,  String? mutationError)  $default,) {final _that = this;
switch (_that) {
case _CourseDetailsState():
return $default(_that.isLoading,_that.isMutating,_that.course,_that.chapters,_that.chaptersStart,_that.chaptersPageSize,_that.chaptersHasNextPage,_that.isLoadingMoreChapters,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isMutating,  CourseModel? course,  List<ChapterDetailModel>? chapters,  int chaptersStart,  int chaptersPageSize,  bool chaptersHasNextPage,  bool isLoadingMoreChapters,  String? errorMessage,  String? mutationSuccess,  String? mutationError)?  $default,) {final _that = this;
switch (_that) {
case _CourseDetailsState() when $default != null:
return $default(_that.isLoading,_that.isMutating,_that.course,_that.chapters,_that.chaptersStart,_that.chaptersPageSize,_that.chaptersHasNextPage,_that.isLoadingMoreChapters,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
  return null;

}
}

}

/// @nodoc


class _CourseDetailsState implements CourseDetailsState {
  const _CourseDetailsState({this.isLoading = false, this.isMutating = false, this.course,  List<ChapterDetailModel>? chapters, this.chaptersStart = 0, this.chaptersPageSize = 30, this.chaptersHasNextPage = false, this.isLoadingMoreChapters = false, this.errorMessage, this.mutationSuccess, this.mutationError}): _chapters = chapters;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isMutating;
@override final  CourseModel? course;
 final  List<ChapterDetailModel>? _chapters;
@override List<ChapterDetailModel>? get chapters {
  final value = _chapters;
  if (value == null) return null;
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  int chaptersStart;
@override@JsonKey() final  int chaptersPageSize;
@override@JsonKey() final  bool chaptersHasNextPage;
@override@JsonKey() final  bool isLoadingMoreChapters;
@override final  String? errorMessage;
@override final  String? mutationSuccess;
@override final  String? mutationError;

/// Create a copy of CourseDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseDetailsStateCopyWith<_CourseDetailsState> get copyWith => __$CourseDetailsStateCopyWithImpl<_CourseDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isMutating, isMutating) || other.isMutating == isMutating)&&(identical(other.course, course) || other.course == course)&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&(identical(other.chaptersStart, chaptersStart) || other.chaptersStart == chaptersStart)&&(identical(other.chaptersPageSize, chaptersPageSize) || other.chaptersPageSize == chaptersPageSize)&&(identical(other.chaptersHasNextPage, chaptersHasNextPage) || other.chaptersHasNextPage == chaptersHasNextPage)&&(identical(other.isLoadingMoreChapters, isLoadingMoreChapters) || other.isLoadingMoreChapters == isLoadingMoreChapters)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.mutationSuccess, mutationSuccess) || other.mutationSuccess == mutationSuccess)&&(identical(other.mutationError, mutationError) || other.mutationError == mutationError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isMutating,course,const DeepCollectionEquality().hash(_chapters),chaptersStart,chaptersPageSize,chaptersHasNextPage,isLoadingMoreChapters,errorMessage,mutationSuccess,mutationError);

@override
String toString() {
  return 'CourseDetailsState(isLoading: $isLoading, isMutating: $isMutating, course: $course, chapters: $chapters, chaptersStart: $chaptersStart, chaptersPageSize: $chaptersPageSize, chaptersHasNextPage: $chaptersHasNextPage, isLoadingMoreChapters: $isLoadingMoreChapters, errorMessage: $errorMessage, mutationSuccess: $mutationSuccess, mutationError: $mutationError)';
}


}

/// @nodoc
abstract mixin class _$CourseDetailsStateCopyWith<$Res> implements $CourseDetailsStateCopyWith<$Res> {
  factory _$CourseDetailsStateCopyWith(_CourseDetailsState value, $Res Function(_CourseDetailsState) _then) = __$CourseDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isMutating, CourseModel? course, List<ChapterDetailModel>? chapters, int chaptersStart, int chaptersPageSize, bool chaptersHasNextPage, bool isLoadingMoreChapters, String? errorMessage, String? mutationSuccess, String? mutationError
});




}
/// @nodoc
class __$CourseDetailsStateCopyWithImpl<$Res>
    implements _$CourseDetailsStateCopyWith<$Res> {
  __$CourseDetailsStateCopyWithImpl(this._self, this._then);

  final _CourseDetailsState _self;
  final $Res Function(_CourseDetailsState) _then;

/// Create a copy of CourseDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isMutating = null,Object? course = freezed,Object? chapters = freezed,Object? chaptersStart = null,Object? chaptersPageSize = null,Object? chaptersHasNextPage = null,Object? isLoadingMoreChapters = null,Object? errorMessage = freezed,Object? mutationSuccess = freezed,Object? mutationError = freezed,}) {
  return _then(_CourseDetailsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isMutating: null == isMutating ? _self.isMutating : isMutating // ignore: cast_nullable_to_non_nullable
as bool,course: freezed == course ? _self.course : course // ignore: cast_nullable_to_non_nullable
as CourseModel?,chapters: freezed == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterDetailModel>?,chaptersStart: null == chaptersStart ? _self.chaptersStart : chaptersStart // ignore: cast_nullable_to_non_nullable
as int,chaptersPageSize: null == chaptersPageSize ? _self.chaptersPageSize : chaptersPageSize // ignore: cast_nullable_to_non_nullable
as int,chaptersHasNextPage: null == chaptersHasNextPage ? _self.chaptersHasNextPage : chaptersHasNextPage // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMoreChapters: null == isLoadingMoreChapters ? _self.isLoadingMoreChapters : isLoadingMoreChapters // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,mutationSuccess: freezed == mutationSuccess ? _self.mutationSuccess : mutationSuccess // ignore: cast_nullable_to_non_nullable
as String?,mutationError: freezed == mutationError ? _self.mutationError : mutationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
