// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'courses_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CoursesState {

 String get searchText; bool? get publishedFilter; bool get isInitialLoading; bool get isRefreshing; bool get isFiltering; bool get isMutating; List<CourseModel>? get allCourses; int get coursesStart; int get coursesPageSize; bool get coursesHasNextPage; bool get isLoadingMoreCourses; List<CourseModel>? get myCourses; String? get errorMessage; String? get mutationSuccess; String? get mutationError;
/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoursesStateCopyWith<CoursesState> get copyWith => _$CoursesStateCopyWithImpl<CoursesState>(this as CoursesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursesState&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.publishedFilter, publishedFilter) || other.publishedFilter == publishedFilter)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isFiltering, isFiltering) || other.isFiltering == isFiltering)&&(identical(other.isMutating, isMutating) || other.isMutating == isMutating)&&const DeepCollectionEquality().equals(other.allCourses, allCourses)&&(identical(other.coursesStart, coursesStart) || other.coursesStart == coursesStart)&&(identical(other.coursesPageSize, coursesPageSize) || other.coursesPageSize == coursesPageSize)&&(identical(other.coursesHasNextPage, coursesHasNextPage) || other.coursesHasNextPage == coursesHasNextPage)&&(identical(other.isLoadingMoreCourses, isLoadingMoreCourses) || other.isLoadingMoreCourses == isLoadingMoreCourses)&&const DeepCollectionEquality().equals(other.myCourses, myCourses)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.mutationSuccess, mutationSuccess) || other.mutationSuccess == mutationSuccess)&&(identical(other.mutationError, mutationError) || other.mutationError == mutationError));
}


@override
int get hashCode => Object.hash(runtimeType,searchText,publishedFilter,isInitialLoading,isRefreshing,isFiltering,isMutating,const DeepCollectionEquality().hash(allCourses),coursesStart,coursesPageSize,coursesHasNextPage,isLoadingMoreCourses,const DeepCollectionEquality().hash(myCourses),errorMessage,mutationSuccess,mutationError);

@override
String toString() {
  return 'CoursesState(searchText: $searchText, publishedFilter: $publishedFilter, isInitialLoading: $isInitialLoading, isRefreshing: $isRefreshing, isFiltering: $isFiltering, isMutating: $isMutating, allCourses: $allCourses, coursesStart: $coursesStart, coursesPageSize: $coursesPageSize, coursesHasNextPage: $coursesHasNextPage, isLoadingMoreCourses: $isLoadingMoreCourses, myCourses: $myCourses, errorMessage: $errorMessage, mutationSuccess: $mutationSuccess, mutationError: $mutationError)';
}


}

/// @nodoc
abstract mixin class $CoursesStateCopyWith<$Res>  {
  factory $CoursesStateCopyWith(CoursesState value, $Res Function(CoursesState) _then) = _$CoursesStateCopyWithImpl;
@useResult
$Res call({
 String searchText, bool? publishedFilter, bool isInitialLoading, bool isRefreshing, bool isFiltering, bool isMutating, List<CourseModel>? allCourses, int coursesStart, int coursesPageSize, bool coursesHasNextPage, bool isLoadingMoreCourses, List<CourseModel>? myCourses, String? errorMessage, String? mutationSuccess, String? mutationError
});




}
/// @nodoc
class _$CoursesStateCopyWithImpl<$Res>
    implements $CoursesStateCopyWith<$Res> {
  _$CoursesStateCopyWithImpl(this._self, this._then);

  final CoursesState _self;
  final $Res Function(CoursesState) _then;

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchText = null,Object? publishedFilter = freezed,Object? isInitialLoading = null,Object? isRefreshing = null,Object? isFiltering = null,Object? isMutating = null,Object? allCourses = freezed,Object? coursesStart = null,Object? coursesPageSize = null,Object? coursesHasNextPage = null,Object? isLoadingMoreCourses = null,Object? myCourses = freezed,Object? errorMessage = freezed,Object? mutationSuccess = freezed,Object? mutationError = freezed,}) {
  return _then(CoursesState(
searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,publishedFilter: freezed == publishedFilter ? _self.publishedFilter : publishedFilter // ignore: cast_nullable_to_non_nullable
as bool?,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isFiltering: null == isFiltering ? _self.isFiltering : isFiltering // ignore: cast_nullable_to_non_nullable
as bool,isMutating: null == isMutating ? _self.isMutating : isMutating // ignore: cast_nullable_to_non_nullable
as bool,allCourses: freezed == allCourses ? _self.allCourses : allCourses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>?,coursesStart: null == coursesStart ? _self.coursesStart : coursesStart // ignore: cast_nullable_to_non_nullable
as int,coursesPageSize: null == coursesPageSize ? _self.coursesPageSize : coursesPageSize // ignore: cast_nullable_to_non_nullable
as int,coursesHasNextPage: null == coursesHasNextPage ? _self.coursesHasNextPage : coursesHasNextPage // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMoreCourses: null == isLoadingMoreCourses ? _self.isLoadingMoreCourses : isLoadingMoreCourses // ignore: cast_nullable_to_non_nullable
as bool,myCourses: freezed == myCourses ? _self.myCourses : myCourses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,mutationSuccess: freezed == mutationSuccess ? _self.mutationSuccess : mutationSuccess // ignore: cast_nullable_to_non_nullable
as String?,mutationError: freezed == mutationError ? _self.mutationError : mutationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoursesState].
extension CoursesStatePatterns on CoursesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoursesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoursesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoursesState value)  $default,){
final _that = this;
switch (_that) {
case _CoursesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoursesState value)?  $default,){
final _that = this;
switch (_that) {
case _CoursesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String searchText,  bool? publishedFilter,  bool isInitialLoading,  bool isRefreshing,  bool isFiltering,  bool isMutating,  List<CourseModel>? allCourses,  int coursesStart,  int coursesPageSize,  bool coursesHasNextPage,  bool isLoadingMoreCourses,  List<CourseModel>? myCourses,  String? errorMessage,  String? mutationSuccess,  String? mutationError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoursesState() when $default != null:
return $default(_that.searchText,_that.publishedFilter,_that.isInitialLoading,_that.isRefreshing,_that.isFiltering,_that.isMutating,_that.allCourses,_that.coursesStart,_that.coursesPageSize,_that.coursesHasNextPage,_that.isLoadingMoreCourses,_that.myCourses,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String searchText,  bool? publishedFilter,  bool isInitialLoading,  bool isRefreshing,  bool isFiltering,  bool isMutating,  List<CourseModel>? allCourses,  int coursesStart,  int coursesPageSize,  bool coursesHasNextPage,  bool isLoadingMoreCourses,  List<CourseModel>? myCourses,  String? errorMessage,  String? mutationSuccess,  String? mutationError)  $default,) {final _that = this;
switch (_that) {
case _CoursesState():
return $default(_that.searchText,_that.publishedFilter,_that.isInitialLoading,_that.isRefreshing,_that.isFiltering,_that.isMutating,_that.allCourses,_that.coursesStart,_that.coursesPageSize,_that.coursesHasNextPage,_that.isLoadingMoreCourses,_that.myCourses,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String searchText,  bool? publishedFilter,  bool isInitialLoading,  bool isRefreshing,  bool isFiltering,  bool isMutating,  List<CourseModel>? allCourses,  int coursesStart,  int coursesPageSize,  bool coursesHasNextPage,  bool isLoadingMoreCourses,  List<CourseModel>? myCourses,  String? errorMessage,  String? mutationSuccess,  String? mutationError)?  $default,) {final _that = this;
switch (_that) {
case _CoursesState() when $default != null:
return $default(_that.searchText,_that.publishedFilter,_that.isInitialLoading,_that.isRefreshing,_that.isFiltering,_that.isMutating,_that.allCourses,_that.coursesStart,_that.coursesPageSize,_that.coursesHasNextPage,_that.isLoadingMoreCourses,_that.myCourses,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
  return null;

}
}

}

/// @nodoc


class _CoursesState implements CoursesState {
  const _CoursesState({this.searchText = '', this.publishedFilter, this.isInitialLoading = false, this.isRefreshing = false, this.isFiltering = false, this.isMutating = false,  List<CourseModel>? allCourses, this.coursesStart = 0, this.coursesPageSize = 30, this.coursesHasNextPage = false, this.isLoadingMoreCourses = false,  List<CourseModel>? myCourses, this.errorMessage, this.mutationSuccess, this.mutationError}): _allCourses = allCourses,_myCourses = myCourses;
  

@override@JsonKey() final  String searchText;
@override final  bool? publishedFilter;
@override@JsonKey() final  bool isInitialLoading;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool isFiltering;
@override@JsonKey() final  bool isMutating;
 final  List<CourseModel>? _allCourses;
@override List<CourseModel>? get allCourses {
  final value = _allCourses;
  if (value == null) return null;
  if (_allCourses is EqualUnmodifiableListView) return _allCourses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  int coursesStart;
@override@JsonKey() final  int coursesPageSize;
@override@JsonKey() final  bool coursesHasNextPage;
@override@JsonKey() final  bool isLoadingMoreCourses;
 final  List<CourseModel>? _myCourses;
@override List<CourseModel>? get myCourses {
  final value = _myCourses;
  if (value == null) return null;
  if (_myCourses is EqualUnmodifiableListView) return _myCourses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? errorMessage;
@override final  String? mutationSuccess;
@override final  String? mutationError;

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoursesStateCopyWith<_CoursesState> get copyWith => __$CoursesStateCopyWithImpl<_CoursesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoursesState&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.publishedFilter, publishedFilter) || other.publishedFilter == publishedFilter)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isFiltering, isFiltering) || other.isFiltering == isFiltering)&&(identical(other.isMutating, isMutating) || other.isMutating == isMutating)&&const DeepCollectionEquality().equals(other._allCourses, _allCourses)&&(identical(other.coursesStart, coursesStart) || other.coursesStart == coursesStart)&&(identical(other.coursesPageSize, coursesPageSize) || other.coursesPageSize == coursesPageSize)&&(identical(other.coursesHasNextPage, coursesHasNextPage) || other.coursesHasNextPage == coursesHasNextPage)&&(identical(other.isLoadingMoreCourses, isLoadingMoreCourses) || other.isLoadingMoreCourses == isLoadingMoreCourses)&&const DeepCollectionEquality().equals(other._myCourses, _myCourses)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.mutationSuccess, mutationSuccess) || other.mutationSuccess == mutationSuccess)&&(identical(other.mutationError, mutationError) || other.mutationError == mutationError));
}


@override
int get hashCode => Object.hash(runtimeType,searchText,publishedFilter,isInitialLoading,isRefreshing,isFiltering,isMutating,const DeepCollectionEquality().hash(_allCourses),coursesStart,coursesPageSize,coursesHasNextPage,isLoadingMoreCourses,const DeepCollectionEquality().hash(_myCourses),errorMessage,mutationSuccess,mutationError);

@override
String toString() {
  return 'CoursesState(searchText: $searchText, publishedFilter: $publishedFilter, isInitialLoading: $isInitialLoading, isRefreshing: $isRefreshing, isFiltering: $isFiltering, isMutating: $isMutating, allCourses: $allCourses, coursesStart: $coursesStart, coursesPageSize: $coursesPageSize, coursesHasNextPage: $coursesHasNextPage, isLoadingMoreCourses: $isLoadingMoreCourses, myCourses: $myCourses, errorMessage: $errorMessage, mutationSuccess: $mutationSuccess, mutationError: $mutationError)';
}


}

/// @nodoc
abstract mixin class _$CoursesStateCopyWith<$Res> implements $CoursesStateCopyWith<$Res> {
  factory _$CoursesStateCopyWith(_CoursesState value, $Res Function(_CoursesState) _then) = __$CoursesStateCopyWithImpl;
@override @useResult
$Res call({
 String searchText, bool? publishedFilter, bool isInitialLoading, bool isRefreshing, bool isFiltering, bool isMutating, List<CourseModel>? allCourses, int coursesStart, int coursesPageSize, bool coursesHasNextPage, bool isLoadingMoreCourses, List<CourseModel>? myCourses, String? errorMessage, String? mutationSuccess, String? mutationError
});




}
/// @nodoc
class __$CoursesStateCopyWithImpl<$Res>
    implements _$CoursesStateCopyWith<$Res> {
  __$CoursesStateCopyWithImpl(this._self, this._then);

  final _CoursesState _self;
  final $Res Function(_CoursesState) _then;

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchText = null,Object? publishedFilter = freezed,Object? isInitialLoading = null,Object? isRefreshing = null,Object? isFiltering = null,Object? isMutating = null,Object? allCourses = freezed,Object? coursesStart = null,Object? coursesPageSize = null,Object? coursesHasNextPage = null,Object? isLoadingMoreCourses = null,Object? myCourses = freezed,Object? errorMessage = freezed,Object? mutationSuccess = freezed,Object? mutationError = freezed,}) {
  return _then(_CoursesState(
searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,publishedFilter: freezed == publishedFilter ? _self.publishedFilter : publishedFilter // ignore: cast_nullable_to_non_nullable
as bool?,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isFiltering: null == isFiltering ? _self.isFiltering : isFiltering // ignore: cast_nullable_to_non_nullable
as bool,isMutating: null == isMutating ? _self.isMutating : isMutating // ignore: cast_nullable_to_non_nullable
as bool,allCourses: freezed == allCourses ? _self._allCourses : allCourses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>?,coursesStart: null == coursesStart ? _self.coursesStart : coursesStart // ignore: cast_nullable_to_non_nullable
as int,coursesPageSize: null == coursesPageSize ? _self.coursesPageSize : coursesPageSize // ignore: cast_nullable_to_non_nullable
as int,coursesHasNextPage: null == coursesHasNextPage ? _self.coursesHasNextPage : coursesHasNextPage // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMoreCourses: null == isLoadingMoreCourses ? _self.isLoadingMoreCourses : isLoadingMoreCourses // ignore: cast_nullable_to_non_nullable
as bool,myCourses: freezed == myCourses ? _self._myCourses : myCourses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,mutationSuccess: freezed == mutationSuccess ? _self.mutationSuccess : mutationSuccess // ignore: cast_nullable_to_non_nullable
as String?,mutationError: freezed == mutationError ? _self.mutationError : mutationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
