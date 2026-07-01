// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonDetailsState {

 bool get isLoading; bool get isMutating; LessonDetailModel? get lesson; String? get errorMessage; String? get mutationSuccess; String? get mutationError;
/// Create a copy of LessonDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonDetailsStateCopyWith<LessonDetailsState> get copyWith => _$LessonDetailsStateCopyWithImpl<LessonDetailsState>(this as LessonDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isMutating, isMutating) || other.isMutating == isMutating)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.mutationSuccess, mutationSuccess) || other.mutationSuccess == mutationSuccess)&&(identical(other.mutationError, mutationError) || other.mutationError == mutationError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isMutating,lesson,errorMessage,mutationSuccess,mutationError);

@override
String toString() {
  return 'LessonDetailsState(isLoading: $isLoading, isMutating: $isMutating, lesson: $lesson, errorMessage: $errorMessage, mutationSuccess: $mutationSuccess, mutationError: $mutationError)';
}


}

/// @nodoc
abstract mixin class $LessonDetailsStateCopyWith<$Res>  {
  factory $LessonDetailsStateCopyWith(LessonDetailsState value, $Res Function(LessonDetailsState) _then) = _$LessonDetailsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isMutating, LessonDetailModel? lesson, String? errorMessage, String? mutationSuccess, String? mutationError
});




}
/// @nodoc
class _$LessonDetailsStateCopyWithImpl<$Res>
    implements $LessonDetailsStateCopyWith<$Res> {
  _$LessonDetailsStateCopyWithImpl(this._self, this._then);

  final LessonDetailsState _self;
  final $Res Function(LessonDetailsState) _then;

/// Create a copy of LessonDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isMutating = null,Object? lesson = freezed,Object? errorMessage = freezed,Object? mutationSuccess = freezed,Object? mutationError = freezed,}) {
  return _then(LessonDetailsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isMutating: null == isMutating ? _self.isMutating : isMutating // ignore: cast_nullable_to_non_nullable
as bool,lesson: freezed == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as LessonDetailModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,mutationSuccess: freezed == mutationSuccess ? _self.mutationSuccess : mutationSuccess // ignore: cast_nullable_to_non_nullable
as String?,mutationError: freezed == mutationError ? _self.mutationError : mutationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonDetailsState].
extension LessonDetailsStatePatterns on LessonDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _LessonDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _LessonDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isMutating,  LessonDetailModel? lesson,  String? errorMessage,  String? mutationSuccess,  String? mutationError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonDetailsState() when $default != null:
return $default(_that.isLoading,_that.isMutating,_that.lesson,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isMutating,  LessonDetailModel? lesson,  String? errorMessage,  String? mutationSuccess,  String? mutationError)  $default,) {final _that = this;
switch (_that) {
case _LessonDetailsState():
return $default(_that.isLoading,_that.isMutating,_that.lesson,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isMutating,  LessonDetailModel? lesson,  String? errorMessage,  String? mutationSuccess,  String? mutationError)?  $default,) {final _that = this;
switch (_that) {
case _LessonDetailsState() when $default != null:
return $default(_that.isLoading,_that.isMutating,_that.lesson,_that.errorMessage,_that.mutationSuccess,_that.mutationError);case _:
  return null;

}
}

}

/// @nodoc


class _LessonDetailsState implements LessonDetailsState {
  const _LessonDetailsState({this.isLoading = false, this.isMutating = false, this.lesson, this.errorMessage, this.mutationSuccess, this.mutationError});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isMutating;
@override final  LessonDetailModel? lesson;
@override final  String? errorMessage;
@override final  String? mutationSuccess;
@override final  String? mutationError;

/// Create a copy of LessonDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonDetailsStateCopyWith<_LessonDetailsState> get copyWith => __$LessonDetailsStateCopyWithImpl<_LessonDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isMutating, isMutating) || other.isMutating == isMutating)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.mutationSuccess, mutationSuccess) || other.mutationSuccess == mutationSuccess)&&(identical(other.mutationError, mutationError) || other.mutationError == mutationError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isMutating,lesson,errorMessage,mutationSuccess,mutationError);

@override
String toString() {
  return 'LessonDetailsState(isLoading: $isLoading, isMutating: $isMutating, lesson: $lesson, errorMessage: $errorMessage, mutationSuccess: $mutationSuccess, mutationError: $mutationError)';
}


}

/// @nodoc
abstract mixin class _$LessonDetailsStateCopyWith<$Res> implements $LessonDetailsStateCopyWith<$Res> {
  factory _$LessonDetailsStateCopyWith(_LessonDetailsState value, $Res Function(_LessonDetailsState) _then) = __$LessonDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isMutating, LessonDetailModel? lesson, String? errorMessage, String? mutationSuccess, String? mutationError
});




}
/// @nodoc
class __$LessonDetailsStateCopyWithImpl<$Res>
    implements _$LessonDetailsStateCopyWith<$Res> {
  __$LessonDetailsStateCopyWithImpl(this._self, this._then);

  final _LessonDetailsState _self;
  final $Res Function(_LessonDetailsState) _then;

/// Create a copy of LessonDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isMutating = null,Object? lesson = freezed,Object? errorMessage = freezed,Object? mutationSuccess = freezed,Object? mutationError = freezed,}) {
  return _then(_LessonDetailsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isMutating: null == isMutating ? _self.isMutating : isMutating // ignore: cast_nullable_to_non_nullable
as bool,lesson: freezed == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as LessonDetailModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,mutationSuccess: freezed == mutationSuccess ? _self.mutationSuccess : mutationSuccess // ignore: cast_nullable_to_non_nullable
as String?,mutationError: freezed == mutationError ? _self.mutationError : mutationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
