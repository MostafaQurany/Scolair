// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_feed_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationFeedState {

 List<NotificationEntity> get notifications; bool get isLoading; bool get isFetchingMore; bool get hasReachedMax; String get filter; String get searchQuery; String? get error;
/// Create a copy of NotificationFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationFeedStateCopyWith<NotificationFeedState> get copyWith => _$NotificationFeedStateCopyWithImpl<NotificationFeedState>(this as NotificationFeedState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationFeedState&&const DeepCollectionEquality().equals(other.notifications, notifications)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFetchingMore, isFetchingMore) || other.isFetchingMore == isFetchingMore)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(notifications),isLoading,isFetchingMore,hasReachedMax,filter,searchQuery,error);

@override
String toString() {
  return 'NotificationFeedState(notifications: $notifications, isLoading: $isLoading, isFetchingMore: $isFetchingMore, hasReachedMax: $hasReachedMax, filter: $filter, searchQuery: $searchQuery, error: $error)';
}


}

/// @nodoc
abstract mixin class $NotificationFeedStateCopyWith<$Res>  {
  factory $NotificationFeedStateCopyWith(NotificationFeedState value, $Res Function(NotificationFeedState) _then) = _$NotificationFeedStateCopyWithImpl;
@useResult
$Res call({
 List<NotificationEntity> notifications, bool isLoading, bool isFetchingMore, bool hasReachedMax, String filter, String searchQuery, String? error
});




}
/// @nodoc
class _$NotificationFeedStateCopyWithImpl<$Res>
    implements $NotificationFeedStateCopyWith<$Res> {
  _$NotificationFeedStateCopyWithImpl(this._self, this._then);

  final NotificationFeedState _self;
  final $Res Function(NotificationFeedState) _then;

/// Create a copy of NotificationFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notifications = null,Object? isLoading = null,Object? isFetchingMore = null,Object? hasReachedMax = null,Object? filter = null,Object? searchQuery = null,Object? error = freezed,}) {
  return _then(NotificationFeedState(
notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFetchingMore: null == isFetchingMore ? _self.isFetchingMore : isFetchingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationFeedState].
extension NotificationFeedStatePatterns on NotificationFeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationFeedState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationFeedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationFeedState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationFeedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationFeedState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationFeedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NotificationEntity> notifications,  bool isLoading,  bool isFetchingMore,  bool hasReachedMax,  String filter,  String searchQuery,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationFeedState() when $default != null:
return $default(_that.notifications,_that.isLoading,_that.isFetchingMore,_that.hasReachedMax,_that.filter,_that.searchQuery,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NotificationEntity> notifications,  bool isLoading,  bool isFetchingMore,  bool hasReachedMax,  String filter,  String searchQuery,  String? error)  $default,) {final _that = this;
switch (_that) {
case _NotificationFeedState():
return $default(_that.notifications,_that.isLoading,_that.isFetchingMore,_that.hasReachedMax,_that.filter,_that.searchQuery,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NotificationEntity> notifications,  bool isLoading,  bool isFetchingMore,  bool hasReachedMax,  String filter,  String searchQuery,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _NotificationFeedState() when $default != null:
return $default(_that.notifications,_that.isLoading,_that.isFetchingMore,_that.hasReachedMax,_that.filter,_that.searchQuery,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationFeedState implements NotificationFeedState {
  const _NotificationFeedState({ List<NotificationEntity> notifications = const [], this.isLoading = true, this.isFetchingMore = false, this.hasReachedMax = false, this.filter = '', this.searchQuery = '', this.error}): _notifications = notifications;
  

 final  List<NotificationEntity> _notifications;
@override@JsonKey() List<NotificationEntity> get notifications {
  if (_notifications is EqualUnmodifiableListView) return _notifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notifications);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isFetchingMore;
@override@JsonKey() final  bool hasReachedMax;
@override@JsonKey() final  String filter;
@override@JsonKey() final  String searchQuery;
@override final  String? error;

/// Create a copy of NotificationFeedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationFeedStateCopyWith<_NotificationFeedState> get copyWith => __$NotificationFeedStateCopyWithImpl<_NotificationFeedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationFeedState&&const DeepCollectionEquality().equals(other._notifications, _notifications)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFetchingMore, isFetchingMore) || other.isFetchingMore == isFetchingMore)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notifications),isLoading,isFetchingMore,hasReachedMax,filter,searchQuery,error);

@override
String toString() {
  return 'NotificationFeedState(notifications: $notifications, isLoading: $isLoading, isFetchingMore: $isFetchingMore, hasReachedMax: $hasReachedMax, filter: $filter, searchQuery: $searchQuery, error: $error)';
}


}

/// @nodoc
abstract mixin class _$NotificationFeedStateCopyWith<$Res> implements $NotificationFeedStateCopyWith<$Res> {
  factory _$NotificationFeedStateCopyWith(_NotificationFeedState value, $Res Function(_NotificationFeedState) _then) = __$NotificationFeedStateCopyWithImpl;
@override @useResult
$Res call({
 List<NotificationEntity> notifications, bool isLoading, bool isFetchingMore, bool hasReachedMax, String filter, String searchQuery, String? error
});




}
/// @nodoc
class __$NotificationFeedStateCopyWithImpl<$Res>
    implements _$NotificationFeedStateCopyWith<$Res> {
  __$NotificationFeedStateCopyWithImpl(this._self, this._then);

  final _NotificationFeedState _self;
  final $Res Function(_NotificationFeedState) _then;

/// Create a copy of NotificationFeedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notifications = null,Object? isLoading = null,Object? isFetchingMore = null,Object? hasReachedMax = null,Object? filter = null,Object? searchQuery = null,Object? error = freezed,}) {
  return _then(_NotificationFeedState(
notifications: null == notifications ? _self._notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFetchingMore: null == isFetchingMore ? _self.isFetchingMore : isFetchingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as String,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
