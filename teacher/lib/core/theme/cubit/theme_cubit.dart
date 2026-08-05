import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../storage/app_shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._preferences) : super(_getInitialThemeMode(_preferences));

  final AppSharedPreferences _preferences;

  static ThemeMode _getInitialThemeMode(AppSharedPreferences prefs) {
    final saved = prefs.getThemeMode();
    if (saved == 'light') return ThemeMode.light;
    if (saved == 'dark') return ThemeMode.dark;
    return ThemeMode.system;
  }

  Future<void> updateThemeMode(ThemeMode mode) async {
    emit(mode);
    var value = 'system';
    if (mode == ThemeMode.light) value = 'light';
    if (mode == ThemeMode.dark) value = 'dark';
    await _preferences.setThemeMode(value);
  }
}
