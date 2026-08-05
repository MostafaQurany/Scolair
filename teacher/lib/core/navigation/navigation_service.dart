import 'package:flutter/material.dart';

import '../constants/app_route_names.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool _isNavigatingToLogin = false;

  Future<dynamic>? navigateTo(String routeName, {Object? arguments}) => navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );

  Future<dynamic>? navigateToAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) => navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );

  void navigateToLogin() {
    if (_isNavigatingToLogin) return;

    final navigator = navigatorKey.currentState;
    if (navigator == null) return;

    var isAlreadyOnLogin = false;
    navigator.popUntil((route) {
      if (route.settings.name == AppRouteNames.login) {
        isAlreadyOnLogin = true;
      }
      return true;
    });

    if (isAlreadyOnLogin) return;

    _isNavigatingToLogin = true;
    navigator
        .pushNamedAndRemoveUntil(AppRouteNames.login, (route) => false)
        .whenComplete(() {
          _isNavigatingToLogin = false;
        });
  }
}
