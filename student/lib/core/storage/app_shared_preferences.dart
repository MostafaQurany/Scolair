import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  const AppSharedPreferences(this._preferences);

  final SharedPreferences _preferences;

  String? getString(String key) => _preferences.getString(key);

  Future<bool> setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  Future<bool> remove(String key) => _preferences.remove(key);

  bool get isFirstTime {
    return _preferences.getBool('isFirstTime') ?? true;
  }

  Future<bool> setFirstTime(bool value) {
    return _preferences.setBool('isFirstTime', value);
  }
}
