// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuizDetailsState {

 bool get isLoading; bool get isUpdating; QuizModel? get quiz; String? get errorMessage; String? get mutationError;
/// Create a copy of QuizDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizDetailsStateCopyWith<QuizDetailsState> get copyWith => _$QuizDetailsStateCopyWithImpl<QuizDetailsState>(this as QuizDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isUpdating, isUpdating) || other.isUpdating == isUpdating)&&(identical(other.quiz, quiz) || other.quiz == quiz)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.mutationError, mutationError) || other.mutationError == mutationError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isUpdating,quiz,errorMessage,mutationError);

@override
String toString() {
  return 'QuizDetailsState(isLoading: $isLoading, isUpdating: $isUpdating, quiz: $quiz, errorMessage: $errorMessage, mutationError: $mutationError)';
}


}

/// @nodoc
abstract mixin class $QuizDetailsStateCopyWith<$Res>  {
  factory $QuizDetailsStateCopyWith(QuizDetailsState value, $Res Function(QuizDetailsState) _then) = _$QuizDetailsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isUpdating, QuizModel? quiz, String? errorMessage, String? mutationError
});




}
/// @nodoc
class _$QuizDetailsStateCopyWithImpl<$Res>
    implements $QuizDetailsStateCopyWith<$Res> {
  _$QuizDetailsStateCopyWithImpl(this._self, this._then);

  final QuizDetailsState _self;
  final $Res Function(QuizDetailsState) _then;

/// Create a copy of QuizDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isUpdating = null,Object? quiz = freezed,Object? errorMessage = freezed,Object? mutationError = freezed,}) {
  return _then(QuizDetailsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isUpdating: null == isUpdating ? _self.isUpdating : isUpdating // ignore: cast_nullable_to_non_nullable
as bool,quiz: freezed == quiz ? _self.quiz : quiz // ignore: cast_nullable_to_non_nullable
as QuizModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,mutationError: freezed == mutationError ? _self.mutationError : mutationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizDetailsState].
extension QuizDetailsStatePatterns on QuizDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _QuizDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _QuizDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isUpdating,  QuizModel? quiz,  String? errorMessage,  String? mutationError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizDetailsState() when $default != null:
return $default(_that.isLoading,_that.isUpdating,_that.quiz,_that.errorMessage,_that.mutationError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isUpdating,  QuizModel? quiz,  String? errorMessage,  String? mutationError)  $default,) {final _that = this;
switch (_that) {
case _QuizDetailsState():
return $default(_that.isLoading,_that.isUpdating,_that.quiz,_that.errorMessage,_that.mutationError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isUpdating,  QuizModel? quiz,  String? errorMessage,  String? mutationError)?  $default,) {final _that = this;
switch (_that) {
case _QuizDetailsState() when $default != null:
return $default(_that.isLoading,_that.isUpdating,_that.quiz,_that.errorMessage,_that.mutationError);case _:
  return null;

}
}

}

/// @nodoc


class _QuizDetailsState implements QuizDetailsState {
  const _QuizDetailsState({this.isLoading = true, this.isUpdating = false, this.quiz, this.errorMessage, this.mutationError});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isUpdating;
@override final  QuizModel? quiz;
@override final  String? errorMessage;
@override final  String? mutationError;

/// Create a copy of QuizDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizDetailsStateCopyWith<_QuizDetailsState> get copyWith => __$QuizDetailsStateCopyWithImpl<_QuizDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isUpdating, isUpdating) || other.isUpdating == isUpdating)&&(identical(other.quiz, quiz) || other.quiz == quiz)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.mutationError, mutationError) || other.mutationError == mutationError));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isUpdating,quiz,errorMessage,mutationError);

@override
String toString() {
  return 'QuizDetailsState(isLoading: $isLoading, isUpdating: $isUpdating, quiz: $quiz, errorMessage: $errorMessage, mutationError: $mutationError)';
}


}

/// @nodoc
abstract mixin class _$QuizDetailsStateCopyWith<$Res> implements $QuizDetailsStateCopyWith<$Res> {
  factory _$QuizDetailsStateCopyWith(_QuizDetailsState value, $Res Function(_QuizDetailsState) _then) = __$QuizDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isUpdating, QuizModel? quiz, String? errorMessage, String? mutationError
});




}
/// @nodoc
class __$QuizDetailsStateCopyWithImpl<$Res>
    implements _$QuizDetailsStateCopyWith<$Res> {
  __$QuizDetailsStateCopyWithImpl(this._self, this._then);

  final _QuizDetailsState _self;
  final $Res Function(_QuizDetailsState) _then;

/// Create a copy of QuizDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isUpdating = null,Object? quiz = freezed,Object? errorMessage = freezed,Object? mutationError = freezed,}) {
  return _then(_QuizDetailsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isUpdating: null == isUpdating ? _self.isUpdating : isUpdating // ignore: cast_nullable_to_non_nullable
as bool,quiz: freezed == quiz ? _self.quiz : quiz // ignore: cast_nullable_to_non_nullable
as QuizModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,mutationError: freezed == mutationError ? _self.mutationError : mutationError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
