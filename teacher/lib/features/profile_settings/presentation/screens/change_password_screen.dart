import 'package:flutter/material.dart';

import '../../../../features/auth/presentation/screens/change_password_screen.dart'
    as auth;

/// Kept as a compatibility entry point for profile-settings navigation.
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => const auth.ChangePasswordScreen();
}
