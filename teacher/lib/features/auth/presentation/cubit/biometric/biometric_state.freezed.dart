// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biometric_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BiometricState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiometricState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiometricState()';
}


}

/// @nodoc
class $BiometricStateCopyWith<$Res>  {
$BiometricStateCopyWith(BiometricState _, $Res Function(BiometricState) __);
}


/// Adds pattern-matching-related methods to [BiometricState].
extension BiometricStatePatterns on BiometricState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Checking value)?  checking,TResult Function( _Authenticated value)?  authenticated,TResult Function( _Unavailable value)?  unavailable,TResult Function( _Failed value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Checking() when checking != null:
return checking(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Unavailable() when unavailable != null:
return unavailable(_that);case _Failed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Checking value)  checking,required TResult Function( _Authenticated value)  authenticated,required TResult Function( _Unavailable value)  unavailable,required TResult Function( _Failed value)  failed,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Checking():
return checking(_that);case _Authenticated():
return authenticated(_that);case _Unavailable():
return unavailable(_that);case _Failed():
return failed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Checking value)?  checking,TResult? Function( _Authenticated value)?  authenticated,TResult? Function( _Unavailable value)?  unavailable,TResult? Function( _Failed value)?  failed,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Checking() when checking != null:
return checking(_that);case _Authenticated() when authenticated != null:
return authenticated(_that);case _Unavailable() when unavailable != null:
return unavailable(_that);case _Failed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  checking,TResult Function()?  authenticated,TResult Function()?  unavailable,TResult Function( String message)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Checking() when checking != null:
return checking();case _Authenticated() when authenticated != null:
return authenticated();case _Unavailable() when unavailable != null:
return unavailable();case _Failed() when failed != null:
return failed(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  checking,required TResult Function()  authenticated,required TResult Function()  unavailable,required TResult Function( String message)  failed,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Checking():
return checking();case _Authenticated():
return authenticated();case _Unavailable():
return unavailable();case _Failed():
return failed(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  checking,TResult? Function()?  authenticated,TResult? Function()?  unavailable,TResult? Function( String message)?  failed,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Checking() when checking != null:
return checking();case _Authenticated() when authenticated != null:
return authenticated();case _Unavailable() when unavailable != null:
return unavailable();case _Failed() when failed != null:
return failed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements BiometricState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiometricState.initial()';
}


}




/// @nodoc


class _Checking implements BiometricState {
  const _Checking();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Checking);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiometricState.checking()';
}


}




/// @nodoc


class _Authenticated implements BiometricState {
  const _Authenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Authenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiometricState.authenticated()';
}


}




/// @nodoc


class _Unavailable implements BiometricState {
  const _Unavailable();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Unavailable);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BiometricState.unavailable()';
}


}




/// @nodoc


class _Failed implements BiometricState {
  const _Failed(this.message);
  

 final  String message;

/// Create a copy of BiometricState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailedCopyWith<_Failed> get copyWith => __$FailedCopyWithImpl<_Failed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'BiometricState.failed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailedCopyWith<$Res> implements $BiometricStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) _then) = __$FailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailedCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(this._self, this._then);

  final _Failed _self;
  final $Res Function(_Failed) _then;

/// Create a copy of BiometricState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Failed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
