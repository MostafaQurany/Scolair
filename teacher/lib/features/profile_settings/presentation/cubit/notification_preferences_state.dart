import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences_state.freezed.dart';

@freezed
abstract class NotificationPreferencesState
    with _$NotificationPreferencesState {
  const factory NotificationPreferencesState({
    @Default(true) bool courseAnnouncements,
    @Default(true) bool assignmentUpdates,
    @Default(true) bool messages,
    @Default(true) bool reminders,
    @Default(false) bool productUpdates,
  }) = _NotificationPreferencesState;
}
