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

 bool get isLoading; List<CourseModel>? get allCourses; List<CourseModel>? get myCourses; String? get errorMessage;
/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoursesStateCopyWith<CoursesState> get copyWith => _$CoursesStateCopyWithImpl<CoursesState>(this as CoursesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoursesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.allCourses, allCourses)&&const DeepCollectionEquality().equals(other.myCourses, myCourses)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(allCourses),const DeepCollectionEquality().hash(myCourses),errorMessage);

@override
String toString() {
  return 'CoursesState(isLoading: $isLoading, allCourses: $allCourses, myCourses: $myCourses, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CoursesStateCopyWith<$Res>  {
  factory $CoursesStateCopyWith(CoursesState value, $Res Function(CoursesState) _then) = _$CoursesStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<CourseModel>? allCourses, List<CourseModel>? myCourses, String? errorMessage
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
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? allCourses = freezed,Object? myCourses = freezed,Object? errorMessage = freezed,}) {
  return _then(CoursesState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,allCourses: freezed == allCourses ? _self.allCourses : allCourses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>?,myCourses: freezed == myCourses ? _self.myCourses : myCourses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<CourseModel>? allCourses,  List<CourseModel>? myCourses,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoursesState() when $default != null:
return $default(_that.isLoading,_that.allCourses,_that.myCourses,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<CourseModel>? allCourses,  List<CourseModel>? myCourses,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CoursesState():
return $default(_that.isLoading,_that.allCourses,_that.myCourses,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<CourseModel>? allCourses,  List<CourseModel>? myCourses,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CoursesState() when $default != null:
return $default(_that.isLoading,_that.allCourses,_that.myCourses,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CoursesState implements CoursesState {
  const _CoursesState({this.isLoading = false,  List<CourseModel>? allCourses,  List<CourseModel>? myCourses, this.errorMessage}): _allCourses = allCourses,_myCourses = myCourses;
  

@override@JsonKey() final  bool isLoading;
 final  List<CourseModel>? _allCourses;
@override List<CourseModel>? get allCourses {
  final value = _allCourses;
  if (value == null) return null;
  if (_allCourses is EqualUnmodifiableListView) return _allCourses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<CourseModel>? _myCourses;
@override List<CourseModel>? get myCourses {
  final value = _myCourses;
  if (value == null) return null;
  if (_myCourses is EqualUnmodifiableListView) return _myCourses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? errorMessage;

/// Create a copy of CoursesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoursesStateCopyWith<_CoursesState> get copyWith => __$CoursesStateCopyWithImpl<_CoursesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoursesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._allCourses, _allCourses)&&const DeepCollectionEquality().equals(other._myCourses, _myCourses)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_allCourses),const DeepCollectionEquality().hash(_myCourses),errorMessage);

@override
String toString() {
  return 'CoursesState(isLoading: $isLoading, allCourses: $allCourses, myCourses: $myCourses, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CoursesStateCopyWith<$Res> implements $CoursesStateCopyWith<$Res> {
  factory _$CoursesStateCopyWith(_CoursesState value, $Res Function(_CoursesState) _then) = __$CoursesStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<CourseModel>? allCourses, List<CourseModel>? myCourses, String? errorMessage
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
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? allCourses = freezed,Object? myCourses = freezed,Object? errorMessage = freezed,}) {
  return _then(_CoursesState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,allCourses: freezed == allCourses ? _self._allCourses : allCourses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>?,myCourses: freezed == myCourses ? _self._myCourses : myCourses // ignore: cast_nullable_to_non_nullable
as List<CourseModel>?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
