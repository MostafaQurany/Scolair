// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeworkListState {

 bool get isLoading; List<HomeworkModel>? get homework; String? get errorMessage;
/// Create a copy of HomeworkListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeworkListStateCopyWith<HomeworkListState> get copyWith => _$HomeworkListStateCopyWithImpl<HomeworkListState>(this as HomeworkListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeworkListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.homework, homework)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(homework),errorMessage);

@override
String toString() {
  return 'HomeworkListState(isLoading: $isLoading, homework: $homework, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $HomeworkListStateCopyWith<$Res>  {
  factory $HomeworkListStateCopyWith(HomeworkListState value, $Res Function(HomeworkListState) _then) = _$HomeworkListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<HomeworkModel>? homework, String? errorMessage
});




}
/// @nodoc
class _$HomeworkListStateCopyWithImpl<$Res>
    implements $HomeworkListStateCopyWith<$Res> {
  _$HomeworkListStateCopyWithImpl(this._self, this._then);

  final HomeworkListState _self;
  final $Res Function(HomeworkListState) _then;

/// Create a copy of HomeworkListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? homework = freezed,Object? errorMessage = freezed,}) {
  return _then(HomeworkListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,homework: freezed == homework ? _self.homework : homework // ignore: cast_nullable_to_non_nullable
as List<HomeworkModel>?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeworkListState].
extension HomeworkListStatePatterns on HomeworkListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeworkListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeworkListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeworkListState value)  $default,){
final _that = this;
switch (_that) {
case _HomeworkListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeworkListState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeworkListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<HomeworkModel>? homework,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeworkListState() when $default != null:
return $default(_that.isLoading,_that.homework,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<HomeworkModel>? homework,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _HomeworkListState():
return $default(_that.isLoading,_that.homework,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<HomeworkModel>? homework,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _HomeworkListState() when $default != null:
return $default(_that.isLoading,_that.homework,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _HomeworkListState implements HomeworkListState {
  const _HomeworkListState({this.isLoading = true,  List<HomeworkModel>? homework, this.errorMessage}): _homework = homework;
  

@override@JsonKey() final  bool isLoading;
 final  List<HomeworkModel>? _homework;
@override List<HomeworkModel>? get homework {
  final value = _homework;
  if (value == null) return null;
  if (_homework is EqualUnmodifiableListView) return _homework;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? errorMessage;

/// Create a copy of HomeworkListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeworkListStateCopyWith<_HomeworkListState> get copyWith => __$HomeworkListStateCopyWithImpl<_HomeworkListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeworkListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._homework, _homework)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_homework),errorMessage);

@override
String toString() {
  return 'HomeworkListState(isLoading: $isLoading, homework: $homework, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$HomeworkListStateCopyWith<$Res> implements $HomeworkListStateCopyWith<$Res> {
  factory _$HomeworkListStateCopyWith(_HomeworkListState value, $Res Function(_HomeworkListState) _then) = __$HomeworkListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<HomeworkModel>? homework, String? errorMessage
});




}
/// @nodoc
class __$HomeworkListStateCopyWithImpl<$Res>
    implements _$HomeworkListStateCopyWith<$Res> {
  __$HomeworkListStateCopyWithImpl(this._self, this._then);

  final _HomeworkListState _self;
  final $Res Function(_HomeworkListState) _then;

/// Create a copy of HomeworkListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? homework = freezed,Object? errorMessage = freezed,}) {
  return _then(_HomeworkListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,homework: freezed == homework ? _self._homework : homework // ignore: cast_nullable_to_non_nullable
as List<HomeworkModel>?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
