import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/app_shared_preferences.dart';
import 'notification_preferences_state.dart';

class NotificationPreferencesCubit extends Cubit<NotificationPreferencesState> {
  NotificationPreferencesCubit(this._preferences)
    : super(_getInitialState(_preferences));

  final AppSharedPreferences _preferences;

  static NotificationPreferencesState _getInitialState(
    AppSharedPreferences prefs,
  ) {
    return NotificationPreferencesState(
      courseAnnouncements: prefs.notificationsCourseAnnouncements,
      assignmentUpdates: prefs.notificationsAssignmentUpdates,
      messages: prefs.notificationsMessages,
      reminders: prefs.notificationsReminders,
      productUpdates: prefs.notificationsProductUpdates,
    );
  }

  Future<void> toggleCourseAnnouncements(bool value) async {
    emit(state.copyWith(courseAnnouncements: value));
    await _preferences.setNotificationsCourseAnnouncements(value);
  }

  Future<void> toggleAssignmentUpdates(bool value) async {
    emit(state.copyWith(assignmentUpdates: value));
    await _preferences.setNotificationsAssignmentUpdates(value);
  }

  Future<void> toggleMessages(bool value) async {
    emit(state.copyWith(messages: value));
    await _preferences.setNotificationsMessages(value);
  }

  Future<void> toggleReminders(bool value) async {
    emit(state.copyWith(reminders: value));
    await _preferences.setNotificationsReminders(value);
  }

  Future<void> toggleProductUpdates(bool value) async {
    emit(state.copyWith(productUpdates: value));
    await _preferences.setNotificationsProductUpdates(value);
  }
}
