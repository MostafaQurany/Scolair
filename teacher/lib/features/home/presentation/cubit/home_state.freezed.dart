// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeacherHomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherHomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeacherHomeState()';
}


}

/// @nodoc
class $TeacherHomeStateCopyWith<$Res>  {
$TeacherHomeStateCopyWith(TeacherHomeState _, $Res Function(TeacherHomeState) __);
}


/// Adds pattern-matching-related methods to [TeacherHomeState].
extension TeacherHomeStatePatterns on TeacherHomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TeacherHomeInitial value)?  initial,TResult Function( TeacherHomeLoading value)?  loading,TResult Function( TeacherHomeSuccess value)?  success,TResult Function( TeacherHomeEmpty value)?  empty,TResult Function( TeacherHomeError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TeacherHomeInitial() when initial != null:
return initial(_that);case TeacherHomeLoading() when loading != null:
return loading(_that);case TeacherHomeSuccess() when success != null:
return success(_that);case TeacherHomeEmpty() when empty != null:
return empty(_that);case TeacherHomeError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TeacherHomeInitial value)  initial,required TResult Function( TeacherHomeLoading value)  loading,required TResult Function( TeacherHomeSuccess value)  success,required TResult Function( TeacherHomeEmpty value)  empty,required TResult Function( TeacherHomeError value)  error,}){
final _that = this;
switch (_that) {
case TeacherHomeInitial():
return initial(_that);case TeacherHomeLoading():
return loading(_that);case TeacherHomeSuccess():
return success(_that);case TeacherHomeEmpty():
return empty(_that);case TeacherHomeError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TeacherHomeInitial value)?  initial,TResult? Function( TeacherHomeLoading value)?  loading,TResult? Function( TeacherHomeSuccess value)?  success,TResult? Function( TeacherHomeEmpty value)?  empty,TResult? Function( TeacherHomeError value)?  error,}){
final _that = this;
switch (_that) {
case TeacherHomeInitial() when initial != null:
return initial(_that);case TeacherHomeLoading() when loading != null:
return loading(_that);case TeacherHomeSuccess() when success != null:
return success(_that);case TeacherHomeEmpty() when empty != null:
return empty(_that);case TeacherHomeError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TeacherHome home,  List<TeacherWallPost> posts,  String selectedFilterId,  bool hasMore,  bool isLoadingMore,  bool isRefreshing,  bool isFiltering,  String? actionError)?  success,TResult Function( TeacherHome home,  String selectedFilterId,  bool isFiltering)?  empty,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TeacherHomeInitial() when initial != null:
return initial();case TeacherHomeLoading() when loading != null:
return loading();case TeacherHomeSuccess() when success != null:
return success(_that.home,_that.posts,_that.selectedFilterId,_that.hasMore,_that.isLoadingMore,_that.isRefreshing,_that.isFiltering,_that.actionError);case TeacherHomeEmpty() when empty != null:
return empty(_that.home,_that.selectedFilterId,_that.isFiltering);case TeacherHomeError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TeacherHome home,  List<TeacherWallPost> posts,  String selectedFilterId,  bool hasMore,  bool isLoadingMore,  bool isRefreshing,  bool isFiltering,  String? actionError)  success,required TResult Function( TeacherHome home,  String selectedFilterId,  bool isFiltering)  empty,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TeacherHomeInitial():
return initial();case TeacherHomeLoading():
return loading();case TeacherHomeSuccess():
return success(_that.home,_that.posts,_that.selectedFilterId,_that.hasMore,_that.isLoadingMore,_that.isRefreshing,_that.isFiltering,_that.actionError);case TeacherHomeEmpty():
return empty(_that.home,_that.selectedFilterId,_that.isFiltering);case TeacherHomeError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TeacherHome home,  List<TeacherWallPost> posts,  String selectedFilterId,  bool hasMore,  bool isLoadingMore,  bool isRefreshing,  bool isFiltering,  String? actionError)?  success,TResult? Function( TeacherHome home,  String selectedFilterId,  bool isFiltering)?  empty,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TeacherHomeInitial() when initial != null:
return initial();case TeacherHomeLoading() when loading != null:
return loading();case TeacherHomeSuccess() when success != null:
return success(_that.home,_that.posts,_that.selectedFilterId,_that.hasMore,_that.isLoadingMore,_that.isRefreshing,_that.isFiltering,_that.actionError);case TeacherHomeEmpty() when empty != null:
return empty(_that.home,_that.selectedFilterId,_that.isFiltering);case TeacherHomeError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TeacherHomeInitial implements TeacherHomeState {
  const TeacherHomeInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherHomeInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeacherHomeState.initial()';
}


}




/// @nodoc


class TeacherHomeLoading implements TeacherHomeState {
  const TeacherHomeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherHomeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TeacherHomeState.loading()';
}


}




/// @nodoc


class TeacherHomeSuccess implements TeacherHomeState {
  const TeacherHomeSuccess({required this.home, required  List<TeacherWallPost> posts, required this.selectedFilterId, required this.hasMore, required this.isLoadingMore, required this.isRefreshing, this.isFiltering = false, this.actionError}): _posts = posts;
  

 final  TeacherHome home;
 final  List<TeacherWallPost> _posts;
 List<TeacherWallPost> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

 final  String selectedFilterId;
 final  bool hasMore;
 final  bool isLoadingMore;
 final  bool isRefreshing;
@JsonKey() final  bool isFiltering;
 final  String? actionError;

/// Create a copy of TeacherHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeacherHomeSuccessCopyWith<TeacherHomeSuccess> get copyWith => _$TeacherHomeSuccessCopyWithImpl<TeacherHomeSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherHomeSuccess&&(identical(other.home, home) || other.home == home)&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.selectedFilterId, selectedFilterId) || other.selectedFilterId == selectedFilterId)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isFiltering, isFiltering) || other.isFiltering == isFiltering)&&(identical(other.actionError, actionError) || other.actionError == actionError));
}


@override
int get hashCode => Object.hash(runtimeType,home,const DeepCollectionEquality().hash(_posts),selectedFilterId,hasMore,isLoadingMore,isRefreshing,isFiltering,actionError);

@override
String toString() {
  return 'TeacherHomeState.success(home: $home, posts: $posts, selectedFilterId: $selectedFilterId, hasMore: $hasMore, isLoadingMore: $isLoadingMore, isRefreshing: $isRefreshing, isFiltering: $isFiltering, actionError: $actionError)';
}


}

/// @nodoc
abstract mixin class $TeacherHomeSuccessCopyWith<$Res> implements $TeacherHomeStateCopyWith<$Res> {
  factory $TeacherHomeSuccessCopyWith(TeacherHomeSuccess value, $Res Function(TeacherHomeSuccess) _then) = _$TeacherHomeSuccessCopyWithImpl;
@useResult
$Res call({
 TeacherHome home, List<TeacherWallPost> posts, String selectedFilterId, bool hasMore, bool isLoadingMore, bool isRefreshing, bool isFiltering, String? actionError
});




}
/// @nodoc
class _$TeacherHomeSuccessCopyWithImpl<$Res>
    implements $TeacherHomeSuccessCopyWith<$Res> {
  _$TeacherHomeSuccessCopyWithImpl(this._self, this._then);

  final TeacherHomeSuccess _self;
  final $Res Function(TeacherHomeSuccess) _then;

/// Create a copy of TeacherHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? home = null,Object? posts = null,Object? selectedFilterId = null,Object? hasMore = null,Object? isLoadingMore = null,Object? isRefreshing = null,Object? isFiltering = null,Object? actionError = freezed,}) {
  return _then(TeacherHomeSuccess(
home: null == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as TeacherHome,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<TeacherWallPost>,selectedFilterId: null == selectedFilterId ? _self.selectedFilterId : selectedFilterId // ignore: cast_nullable_to_non_nullable
as String,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isFiltering: null == isFiltering ? _self.isFiltering : isFiltering // ignore: cast_nullable_to_non_nullable
as bool,actionError: freezed == actionError ? _self.actionError : actionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class TeacherHomeEmpty implements TeacherHomeState {
  const TeacherHomeEmpty({required this.home, required this.selectedFilterId, this.isFiltering = false});
  

 final  TeacherHome home;
 final  String selectedFilterId;
@JsonKey() final  bool isFiltering;

/// Create a copy of TeacherHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeacherHomeEmptyCopyWith<TeacherHomeEmpty> get copyWith => _$TeacherHomeEmptyCopyWithImpl<TeacherHomeEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherHomeEmpty&&(identical(other.home, home) || other.home == home)&&(identical(other.selectedFilterId, selectedFilterId) || other.selectedFilterId == selectedFilterId)&&(identical(other.isFiltering, isFiltering) || other.isFiltering == isFiltering));
}


@override
int get hashCode => Object.hash(runtimeType,home,selectedFilterId,isFiltering);

@override
String toString() {
  return 'TeacherHomeState.empty(home: $home, selectedFilterId: $selectedFilterId, isFiltering: $isFiltering)';
}


}

/// @nodoc
abstract mixin class $TeacherHomeEmptyCopyWith<$Res> implements $TeacherHomeStateCopyWith<$Res> {
  factory $TeacherHomeEmptyCopyWith(TeacherHomeEmpty value, $Res Function(TeacherHomeEmpty) _then) = _$TeacherHomeEmptyCopyWithImpl;
@useResult
$Res call({
 TeacherHome home, String selectedFilterId, bool isFiltering
});




}
/// @nodoc
class _$TeacherHomeEmptyCopyWithImpl<$Res>
    implements $TeacherHomeEmptyCopyWith<$Res> {
  _$TeacherHomeEmptyCopyWithImpl(this._self, this._then);

  final TeacherHomeEmpty _self;
  final $Res Function(TeacherHomeEmpty) _then;

/// Create a copy of TeacherHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? home = null,Object? selectedFilterId = null,Object? isFiltering = null,}) {
  return _then(TeacherHomeEmpty(
home: null == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as TeacherHome,selectedFilterId: null == selectedFilterId ? _self.selectedFilterId : selectedFilterId // ignore: cast_nullable_to_non_nullable
as String,isFiltering: null == isFiltering ? _self.isFiltering : isFiltering // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class TeacherHomeError implements TeacherHomeState {
  const TeacherHomeError({required this.message});
  

 final  String message;

/// Create a copy of TeacherHomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeacherHomeErrorCopyWith<TeacherHomeError> get copyWith => _$TeacherHomeErrorCopyWithImpl<TeacherHomeError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherHomeError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TeacherHomeState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TeacherHomeErrorCopyWith<$Res> implements $TeacherHomeStateCopyWith<$Res> {
  factory $TeacherHomeErrorCopyWith(TeacherHomeError value, $Res Function(TeacherHomeError) _then) = _$TeacherHomeErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TeacherHomeErrorCopyWithImpl<$Res>
    implements $TeacherHomeErrorCopyWith<$Res> {
  _$TeacherHomeErrorCopyWithImpl(this._self, this._then);

  final TeacherHomeError _self;
  final $Res Function(TeacherHomeError) _then;

/// Create a copy of TeacherHomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TeacherHomeError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
