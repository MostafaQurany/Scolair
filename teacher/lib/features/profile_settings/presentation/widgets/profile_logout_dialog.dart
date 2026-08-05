import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/storage/app_secure_storage.dart';
import '../../../../core/storage/app_shared_preferences.dart';
import '../cubit/authenticated_user_cubit.dart';
import '../../../auth/domain/usecases/logout_usecase.dart';

Future<void> showProfileLogoutDialog(BuildContext context) => showDialog<void>(
    context: context,
    builder: (dialogContext) {
      final colors = Theme.of(dialogContext).colorScheme;
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(dialogContext.l10n.profileLogoutConfirmTitle),
        content: Text(dialogContext.l10n.profileLogoutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(dialogContext.l10n.profileLogoutConfirmNo),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final secureStorage = getIt<AppSecureStorage>();
              final accessToken = await secureStorage.readAccessToken();
              if (accessToken != null && accessToken.isNotEmpty) {
                await getIt<LogoutUseCase>()(accessToken);
              }
              await getIt<AppSharedPreferences>().clearUserData();
              await secureStorage.clearAll();
              getIt<AuthenticatedUserCubit>().clear();
              if (context.mounted) {
                unawaited(Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouteNames.login,
                  (route) => false,
                ));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.error,
              foregroundColor: colors.onError,
            ),
            child: Text(dialogContext.l10n.profileLogoutConfirmYes),
          ),
        ],
      );
    },
  );
