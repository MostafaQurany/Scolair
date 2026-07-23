// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_students_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CourseStudentsState {

 String? get courseName; bool get isLoading; bool get isAdding; bool get isRemoving; List<StudentModel> get students; String? get errorMessage; String? get successMessage;
/// Create a copy of CourseStudentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CourseStudentsStateCopyWith<CourseStudentsState> get copyWith => _$CourseStudentsStateCopyWithImpl<CourseStudentsState>(this as CourseStudentsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CourseStudentsState&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isAdding, isAdding) || other.isAdding == isAdding)&&(identical(other.isRemoving, isRemoving) || other.isRemoving == isRemoving)&&const DeepCollectionEquality().equals(other.students, students)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,courseName,isLoading,isAdding,isRemoving,const DeepCollectionEquality().hash(students),errorMessage,successMessage);

@override
String toString() {
  return 'CourseStudentsState(courseName: $courseName, isLoading: $isLoading, isAdding: $isAdding, isRemoving: $isRemoving, students: $students, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $CourseStudentsStateCopyWith<$Res>  {
  factory $CourseStudentsStateCopyWith(CourseStudentsState value, $Res Function(CourseStudentsState) _then) = _$CourseStudentsStateCopyWithImpl;
@useResult
$Res call({
 String? courseName, bool isLoading, bool isAdding, bool isRemoving, List<StudentModel> students, String? errorMessage, String? successMessage
});




}
/// @nodoc
class _$CourseStudentsStateCopyWithImpl<$Res>
    implements $CourseStudentsStateCopyWith<$Res> {
  _$CourseStudentsStateCopyWithImpl(this._self, this._then);

  final CourseStudentsState _self;
  final $Res Function(CourseStudentsState) _then;

/// Create a copy of CourseStudentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseName = freezed,Object? isLoading = null,Object? isAdding = null,Object? isRemoving = null,Object? students = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(CourseStudentsState(
courseName: freezed == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isAdding: null == isAdding ? _self.isAdding : isAdding // ignore: cast_nullable_to_non_nullable
as bool,isRemoving: null == isRemoving ? _self.isRemoving : isRemoving // ignore: cast_nullable_to_non_nullable
as bool,students: null == students ? _self.students : students // ignore: cast_nullable_to_non_nullable
as List<StudentModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CourseStudentsState].
extension CourseStudentsStatePatterns on CourseStudentsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CourseStudentsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CourseStudentsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CourseStudentsState value)  $default,){
final _that = this;
switch (_that) {
case _CourseStudentsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CourseStudentsState value)?  $default,){
final _that = this;
switch (_that) {
case _CourseStudentsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? courseName,  bool isLoading,  bool isAdding,  bool isRemoving,  List<StudentModel> students,  String? errorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CourseStudentsState() when $default != null:
return $default(_that.courseName,_that.isLoading,_that.isAdding,_that.isRemoving,_that.students,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? courseName,  bool isLoading,  bool isAdding,  bool isRemoving,  List<StudentModel> students,  String? errorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _CourseStudentsState():
return $default(_that.courseName,_that.isLoading,_that.isAdding,_that.isRemoving,_that.students,_that.errorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? courseName,  bool isLoading,  bool isAdding,  bool isRemoving,  List<StudentModel> students,  String? errorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _CourseStudentsState() when $default != null:
return $default(_that.courseName,_that.isLoading,_that.isAdding,_that.isRemoving,_that.students,_that.errorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CourseStudentsState implements CourseStudentsState {
  const _CourseStudentsState({this.courseName, this.isLoading = false, this.isAdding = false, this.isRemoving = false,  List<StudentModel> students = const [], this.errorMessage, this.successMessage}): _students = students;
  

@override final  String? courseName;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isAdding;
@override@JsonKey() final  bool isRemoving;
 final  List<StudentModel> _students;
@override@JsonKey() List<StudentModel> get students {
  if (_students is EqualUnmodifiableListView) return _students;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_students);
}

@override final  String? errorMessage;
@override final  String? successMessage;

/// Create a copy of CourseStudentsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CourseStudentsStateCopyWith<_CourseStudentsState> get copyWith => __$CourseStudentsStateCopyWithImpl<_CourseStudentsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CourseStudentsState&&(identical(other.courseName, courseName) || other.courseName == courseName)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isAdding, isAdding) || other.isAdding == isAdding)&&(identical(other.isRemoving, isRemoving) || other.isRemoving == isRemoving)&&const DeepCollectionEquality().equals(other._students, _students)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,courseName,isLoading,isAdding,isRemoving,const DeepCollectionEquality().hash(_students),errorMessage,successMessage);

@override
String toString() {
  return 'CourseStudentsState(courseName: $courseName, isLoading: $isLoading, isAdding: $isAdding, isRemoving: $isRemoving, students: $students, errorMessage: $errorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$CourseStudentsStateCopyWith<$Res> implements $CourseStudentsStateCopyWith<$Res> {
  factory _$CourseStudentsStateCopyWith(_CourseStudentsState value, $Res Function(_CourseStudentsState) _then) = __$CourseStudentsStateCopyWithImpl;
@override @useResult
$Res call({
 String? courseName, bool isLoading, bool isAdding, bool isRemoving, List<StudentModel> students, String? errorMessage, String? successMessage
});




}
/// @nodoc
class __$CourseStudentsStateCopyWithImpl<$Res>
    implements _$CourseStudentsStateCopyWith<$Res> {
  __$CourseStudentsStateCopyWithImpl(this._self, this._then);

  final _CourseStudentsState _self;
  final $Res Function(_CourseStudentsState) _then;

/// Create a copy of CourseStudentsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseName = freezed,Object? isLoading = null,Object? isAdding = null,Object? isRemoving = null,Object? students = null,Object? errorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_CourseStudentsState(
courseName: freezed == courseName ? _self.courseName : courseName // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isAdding: null == isAdding ? _self.isAdding : isAdding // ignore: cast_nullable_to_non_nullable
as bool,isRemoving: null == isRemoving ? _self.isRemoving : isRemoving // ignore: cast_nullable_to_non_nullable
as bool,students: null == students ? _self._students : students // ignore: cast_nullable_to_non_nullable
as List<StudentModel>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
