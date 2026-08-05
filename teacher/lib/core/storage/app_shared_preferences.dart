import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  const AppSharedPreferences(this._preferences);

  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _usernameKey = 'username';
  static const String _fullNameKey = 'full_name';
  static const String _userImageKey = 'user_image';
  static const String _userRolesKey = 'user_roles';
  static const String _isCourseCreatorKey = 'is_course_creator';
  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _biometricDontShowKey = 'biometric_dont_show';
  static const String _themeModeKey = 'theme_mode';
  static const String _localeKey = 'app_locale';
  static const String _notifCourseAnnouncementsKey =
      'notif_course_announcements';
  static const String _notifAssignmentUpdatesKey = 'notif_assignment_updates';
  static const String _notifMessagesKey = 'notif_messages';
  static const String _notifRemindersKey = 'notif_reminders';
  static const String _notifProductUpdatesKey = 'notif_product_updates';

  final SharedPreferences _preferences;

  String? getString(String key) => _preferences.getString(key);

  Future<bool> setString(String key, String value) => _preferences.setString(key, value);

  bool? getBool(String key) => _preferences.getBool(key);

  Future<bool> setBool(String key, bool value) => _preferences.setBool(key, value);

  String? getThemeMode() => _preferences.getString(_themeModeKey);

  Future<bool> setThemeMode(String value) =>
      _preferences.setString(_themeModeKey, value);

  String? getLocaleCode() => _preferences.getString(_localeKey);

  Future<bool> setLocaleCode(String value) =>
      _preferences.setString(_localeKey, value);

  bool get notificationsCourseAnnouncements =>
      _preferences.getBool(_notifCourseAnnouncementsKey) ?? true;
  bool get notificationsAssignmentUpdates =>
      _preferences.getBool(_notifAssignmentUpdatesKey) ?? true;
  bool get notificationsMessages =>
      _preferences.getBool(_notifMessagesKey) ?? true;
  bool get notificationsReminders =>
      _preferences.getBool(_notifRemindersKey) ?? true;
  bool get notificationsProductUpdates =>
      _preferences.getBool(_notifProductUpdatesKey) ?? false;

  Future<bool> setNotificationsCourseAnnouncements(bool value) =>
      _preferences.setBool(_notifCourseAnnouncementsKey, value);
  Future<bool> setNotificationsAssignmentUpdates(bool value) =>
      _preferences.setBool(_notifAssignmentUpdatesKey, value);
  Future<bool> setNotificationsMessages(bool value) =>
      _preferences.setBool(_notifMessagesKey, value);
  Future<bool> setNotificationsReminders(bool value) =>
      _preferences.setBool(_notifRemindersKey, value);
  Future<bool> setNotificationsProductUpdates(bool value) =>
      _preferences.setBool(_notifProductUpdatesKey, value);

  Future<bool> remove(String key) => _preferences.remove(key);

  bool get isFirstTime => _preferences.getBool('isFirstTime') ?? true;

  Future<bool> setFirstTime(bool value) => _preferences.setBool('isFirstTime', value);

  Future<void> saveUserData({
    required String name,
    required String email,
    required String username,
    required String fullName,
    required List<String> roles,
    String? userImage,
  }) async {
    await Future.wait([
      _preferences.setString(_userNameKey, name),
      _preferences.setString(_userEmailKey, email),
      _preferences.setString(_usernameKey, username),
      _preferences.setString(_fullNameKey, fullName),
      _preferences.setString(_userRolesKey, jsonEncode(roles)),
      _preferences.setBool(
        _isCourseCreatorKey,
        roles.any((role) => role.trim().toLowerCase() == 'course creator'),
      ),
      if (userImage == null || userImage.isEmpty)
        _preferences.remove(_userImageKey)
      else
        _preferences.setString(_userImageKey, userImage),
    ]);
  }

  Future<void> clearUserData() async {
    await Future.wait([
      _preferences.remove(_userNameKey),
      _preferences.remove(_userEmailKey),
      _preferences.remove(_usernameKey),
      _preferences.remove(_fullNameKey),
      _preferences.remove(_userImageKey),
      _preferences.remove(_userRolesKey),
      _preferences.remove(_isCourseCreatorKey),
    ]);
  }

  String? getUserName() => _preferences.getString(_userNameKey);

  String? getUserEmail() => _preferences.getString(_userEmailKey);

  String? getUsername() => _preferences.getString(_usernameKey);

  String? getFullName() => _preferences.getString(_fullNameKey);

  String? getUserImage() => _preferences.getString(_userImageKey);

  List<String> getUserRoles() {
    final raw = _preferences.getString(_userRolesKey);
    if (raw == null || raw.isEmpty) return const [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      return decoded.whereType<String>().toList(growable: false);
    } on Object {
      return const [];
    }
  }

  bool get isCourseCreator =>
      _preferences.getBool(_isCourseCreatorKey) ?? false;

  bool get biometricEnabled =>
      _preferences.getBool(_biometricEnabledKey) ?? false;

  Future<void> setBiometricEnabled(bool value) =>
      _preferences.setBool(_biometricEnabledKey, value);

  bool get biometricDontShow =>
      _preferences.getBool(_biometricDontShowKey) ?? false;

  Future<void> setBiometricDontShow(bool value) =>
      _preferences.setBool(_biometricDontShowKey, value);
}
