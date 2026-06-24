import 'package:flutter/material.dart';

import '../localization/localization_extension.dart';
import '../theme/app_colors.dart';

abstract final class AppSnackBar {
  static void showError(BuildContext context, String message) {
    if (!context.mounted) return;
    final text = message.isNotEmpty ? message : context.l10n.authErrorGeneric;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  static void showSuccess(BuildContext context, String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkSuccess
              : AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
