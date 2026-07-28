import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/localization/cubit/locale_cubit.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';
import '../../../../core/utils/app_version_utils.dart';
import '../cubit/authenticated_user_cubit.dart';
import '../cubit/authenticated_user_state.dart';
import '../widgets/profile_card_shimmer.dart';
import '../widgets/profile_card.dart';
import '../widgets/profile_logout_dialog.dart';
import '../widgets/settings_section_card.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  void initState() {
    super.initState();
    final cubit = getIt<AuthenticatedUserCubit>();
    if (cubit.currentProfile == null) {
      cubit.fetchProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profileSettingsTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              BlocBuilder<AuthenticatedUserCubit, AuthenticatedUserState>(
                bloc: getIt<AuthenticatedUserCubit>(),
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    initial: () => true,
                    loading: () => true,
                    orElse: () => false,
                  );
                  if (isLoading) {
                    return const ProfileCardShimmer();
                  }
                  final profile =
                      getIt<AuthenticatedUserCubit>().currentProfile;
                  if (profile == null) {
                    return const ProfileCardShimmer();
                  }
                  return ProfileCard(profile: profile);
                },
              ),
              SizedBox(height: 24.h),
              SettingsSectionCard(
                title: context.l10n.profileSectionAccount,
                children: [
                  SettingsTile(
                    icon: Icons.person_outline_rounded,
                    title: context.l10n.profileEditProfileItem,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouteNames.editProfile),
                  ),
                  SettingsTile(
                    icon: Icons.badge_outlined,
                    title: context.l10n.profileAccountInfoItem,
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRouteNames.accountInformation,
                    ),
                  ),
                ],
              ),
              BlocBuilder<LocaleCubit, Locale>(
                bloc: getIt<LocaleCubit>(),
                builder: (context, locale) {
                  final langText = locale.languageCode == 'ar'
                      ? context.l10n.languageArabic
                      : context.l10n.languageEnglish;
                  return BlocBuilder<ThemeCubit, ThemeMode>(
                    bloc: getIt<ThemeCubit>(),
                    builder: (context, themeMode) {
                      String themeText = context.l10n.themeSystem;
                      if (themeMode == ThemeMode.light) {
                        themeText = context.l10n.themeLight;
                      } else if (themeMode == ThemeMode.dark) {
                        themeText = context.l10n.themeDark;
                      }
                      return SettingsSectionCard(
                        title: context.l10n.profileSectionPreferences,
                        children: [
                          SettingsTile(
                            icon: Icons.language_rounded,
                            title: context.l10n.profileLanguageItem,
                            trailingText: langText,
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRouteNames.languageSettings,
                            ),
                          ),
                          SettingsTile(
                            icon: Icons.dark_mode_outlined,
                            title: context.l10n.profileThemeItem,
                            trailingText: themeText,
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRouteNames.themeSettings,
                            ),
                          ),
                          SettingsTile(
                            icon: Icons.notifications_none_rounded,
                            title: context.l10n.profileNotificationsItem,
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRouteNames.notificationPreferences,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SettingsSectionCard(
                title: context.l10n.profileSectionSecurity,
                children: [
                  SettingsTile(
                    icon: Icons.lock_outline_rounded,
                    title: context.l10n.changePasswordTitle,
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRouteNames.changePassword,
                    ),
                  ),
                ],
              ),
              SettingsSectionCard(
                title: context.l10n.profileToolkitItem,
                children: [
                  SettingsTile(
                    icon: Icons.co_present_rounded,
                    title: context.l10n.profileToolkitItem,
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRouteNames.toolkitWhiteboard,
                    ),
                  ),
                ],
              ),
              SettingsSectionCard(
                title: context.l10n.profileSectionSupport,
                children: [
                  SettingsTile(
                    icon: Icons.help_outline_rounded,
                    title: context.l10n.profileHelpSupportItem,
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouteNames.helpSupport),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton.icon(
                  onPressed: () => showProfileLogoutDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.errorContainer,
                    foregroundColor: colorScheme.error,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  icon: Icon(Icons.logout_rounded, size: 20.sp),
                  label: Text(
                    context.l10n.profileLogoutButton,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.error,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                AppVersionUtils.appVersion,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
