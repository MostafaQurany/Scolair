// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preferences_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationPreferencesState {

 bool get courseAnnouncements; bool get assignmentUpdates; bool get messages; bool get reminders; bool get productUpdates;
/// Create a copy of NotificationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesStateCopyWith<NotificationPreferencesState> get copyWith => _$NotificationPreferencesStateCopyWithImpl<NotificationPreferencesState>(this as NotificationPreferencesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferencesState&&(identical(other.courseAnnouncements, courseAnnouncements) || other.courseAnnouncements == courseAnnouncements)&&(identical(other.assignmentUpdates, assignmentUpdates) || other.assignmentUpdates == assignmentUpdates)&&(identical(other.messages, messages) || other.messages == messages)&&(identical(other.reminders, reminders) || other.reminders == reminders)&&(identical(other.productUpdates, productUpdates) || other.productUpdates == productUpdates));
}


@override
int get hashCode => Object.hash(runtimeType,courseAnnouncements,assignmentUpdates,messages,reminders,productUpdates);

@override
String toString() {
  return 'NotificationPreferencesState(courseAnnouncements: $courseAnnouncements, assignmentUpdates: $assignmentUpdates, messages: $messages, reminders: $reminders, productUpdates: $productUpdates)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesStateCopyWith<$Res>  {
  factory $NotificationPreferencesStateCopyWith(NotificationPreferencesState value, $Res Function(NotificationPreferencesState) _then) = _$NotificationPreferencesStateCopyWithImpl;
@useResult
$Res call({
 bool courseAnnouncements, bool assignmentUpdates, bool messages, bool reminders, bool productUpdates
});




}
/// @nodoc
class _$NotificationPreferencesStateCopyWithImpl<$Res>
    implements $NotificationPreferencesStateCopyWith<$Res> {
  _$NotificationPreferencesStateCopyWithImpl(this._self, this._then);

  final NotificationPreferencesState _self;
  final $Res Function(NotificationPreferencesState) _then;

/// Create a copy of NotificationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? courseAnnouncements = null,Object? assignmentUpdates = null,Object? messages = null,Object? reminders = null,Object? productUpdates = null,}) {
  return _then(NotificationPreferencesState(
courseAnnouncements: null == courseAnnouncements ? _self.courseAnnouncements : courseAnnouncements // ignore: cast_nullable_to_non_nullable
as bool,assignmentUpdates: null == assignmentUpdates ? _self.assignmentUpdates : assignmentUpdates // ignore: cast_nullable_to_non_nullable
as bool,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as bool,reminders: null == reminders ? _self.reminders : reminders // ignore: cast_nullable_to_non_nullable
as bool,productUpdates: null == productUpdates ? _self.productUpdates : productUpdates // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPreferencesState].
extension NotificationPreferencesStatePatterns on NotificationPreferencesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferencesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferencesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferencesState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferencesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferencesState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferencesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool courseAnnouncements,  bool assignmentUpdates,  bool messages,  bool reminders,  bool productUpdates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPreferencesState() when $default != null:
return $default(_that.courseAnnouncements,_that.assignmentUpdates,_that.messages,_that.reminders,_that.productUpdates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool courseAnnouncements,  bool assignmentUpdates,  bool messages,  bool reminders,  bool productUpdates)  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferencesState():
return $default(_that.courseAnnouncements,_that.assignmentUpdates,_that.messages,_that.reminders,_that.productUpdates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool courseAnnouncements,  bool assignmentUpdates,  bool messages,  bool reminders,  bool productUpdates)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferencesState() when $default != null:
return $default(_that.courseAnnouncements,_that.assignmentUpdates,_that.messages,_that.reminders,_that.productUpdates);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationPreferencesState implements NotificationPreferencesState {
  const _NotificationPreferencesState({this.courseAnnouncements = true, this.assignmentUpdates = true, this.messages = true, this.reminders = true, this.productUpdates = false});
  

@override@JsonKey() final  bool courseAnnouncements;
@override@JsonKey() final  bool assignmentUpdates;
@override@JsonKey() final  bool messages;
@override@JsonKey() final  bool reminders;
@override@JsonKey() final  bool productUpdates;

/// Create a copy of NotificationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferencesStateCopyWith<_NotificationPreferencesState> get copyWith => __$NotificationPreferencesStateCopyWithImpl<_NotificationPreferencesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferencesState&&(identical(other.courseAnnouncements, courseAnnouncements) || other.courseAnnouncements == courseAnnouncements)&&(identical(other.assignmentUpdates, assignmentUpdates) || other.assignmentUpdates == assignmentUpdates)&&(identical(other.messages, messages) || other.messages == messages)&&(identical(other.reminders, reminders) || other.reminders == reminders)&&(identical(other.productUpdates, productUpdates) || other.productUpdates == productUpdates));
}


@override
int get hashCode => Object.hash(runtimeType,courseAnnouncements,assignmentUpdates,messages,reminders,productUpdates);

@override
String toString() {
  return 'NotificationPreferencesState(courseAnnouncements: $courseAnnouncements, assignmentUpdates: $assignmentUpdates, messages: $messages, reminders: $reminders, productUpdates: $productUpdates)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferencesStateCopyWith<$Res> implements $NotificationPreferencesStateCopyWith<$Res> {
  factory _$NotificationPreferencesStateCopyWith(_NotificationPreferencesState value, $Res Function(_NotificationPreferencesState) _then) = __$NotificationPreferencesStateCopyWithImpl;
@override @useResult
$Res call({
 bool courseAnnouncements, bool assignmentUpdates, bool messages, bool reminders, bool productUpdates
});




}
/// @nodoc
class __$NotificationPreferencesStateCopyWithImpl<$Res>
    implements _$NotificationPreferencesStateCopyWith<$Res> {
  __$NotificationPreferencesStateCopyWithImpl(this._self, this._then);

  final _NotificationPreferencesState _self;
  final $Res Function(_NotificationPreferencesState) _then;

/// Create a copy of NotificationPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? courseAnnouncements = null,Object? assignmentUpdates = null,Object? messages = null,Object? reminders = null,Object? productUpdates = null,}) {
  return _then(_NotificationPreferencesState(
courseAnnouncements: null == courseAnnouncements ? _self.courseAnnouncements : courseAnnouncements // ignore: cast_nullable_to_non_nullable
as bool,assignmentUpdates: null == assignmentUpdates ? _self.assignmentUpdates : assignmentUpdates // ignore: cast_nullable_to_non_nullable
as bool,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as bool,reminders: null == reminders ? _self.reminders : reminders // ignore: cast_nullable_to_non_nullable
as bool,productUpdates: null == productUpdates ? _self.productUpdates : productUpdates // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
