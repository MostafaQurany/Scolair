// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.primary),
        title: Text(context.l10n.themeScreenTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          bloc: getIt<ThemeCubit>(),
          builder: (context, currentMode) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                children: [
                  _buildThemeOption(
                    context,
                    mode: ThemeMode.light,
                    title: context.l10n.themeLight,
                    icon: Icons.light_mode_outlined,
                    currentMode: currentMode,
                  ),
                  SizedBox(height: 16.h),
                  _buildThemeOption(
                    context,
                    mode: ThemeMode.dark,
                    title: context.l10n.themeDark,
                    icon: Icons.dark_mode_outlined,
                    currentMode: currentMode,
                  ),
                  SizedBox(height: 16.h),
                  _buildThemeOption(
                    context,
                    mode: ThemeMode.system,
                    title: context.l10n.themeSystem,
                    icon: Icons.settings_brightness_outlined,
                    currentMode: currentMode,
                  ),
                ],
              ),
            ),
        ),
      ),
    );

  Widget _buildThemeOption(
    BuildContext context, {
    required ThemeMode mode,
    required String title,
    required IconData icon,
    required ThemeMode currentMode,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isSelected = currentMode == mode;

    return InkWell(
      onTap: () => getIt<ThemeCubit>().updateThemeMode(mode),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer.withValues(alpha: 0.3)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            Radio<ThemeMode>(
              value: mode,
              groupValue: currentMode,
              onChanged: (val) {
                if (val != null) {
                  getIt<ThemeCubit>().updateThemeMode(val);
                }
              },
              activeColor: colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
