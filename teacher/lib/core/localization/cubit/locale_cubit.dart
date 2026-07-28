import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../storage/app_shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._preferences) : super(_getInitialLocale(_preferences));

  final AppSharedPreferences _preferences;

  static Locale _getInitialLocale(AppSharedPreferences prefs) {
    final saved = prefs.getLocaleCode();
    if (saved == 'ar') return const Locale('ar');
    return const Locale('en');
  }

  Future<void> updateLocale(Locale locale) async {
    if (state == locale) return;
    emit(locale);
    await _preferences.setLocaleCode(locale.languageCode);
  }

  Future<void> rollbackLocale(Locale previousLocale) async {
    if (state == previousLocale) return;
    emit(previousLocale);
    await _preferences.setLocaleCode(previousLocale.languageCode);
  }
}
