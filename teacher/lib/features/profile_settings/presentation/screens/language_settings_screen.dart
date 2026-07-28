// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/localization/cubit/locale_cubit.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../cubit/authenticated_user_cubit.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  late String _selectedLangCode;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedLangCode = getIt<LocaleCubit>().state.languageCode;
  }

  Future<void> _confirmSelection() async {
    if (_isSubmitting) return;
    final currentLocale = getIt<LocaleCubit>().state;
    if (currentLocale.languageCode == _selectedLangCode) {
      Navigator.pop(context);
      return;
    }

    setState(() => _isSubmitting = true);
    final newLocale = Locale(_selectedLangCode);

    // Save previous locale for rollback if needed
    final previousLocale = currentLocale;

    if (mounted) {
      // Backend is authoritative; apply the local locale only after it succeeds.
      AppSnackBar.showInfo(context, context.l10n.languageUpdating);
    }

    // Update backend profile language
    final success = await getIt<AuthenticatedUserCubit>().updateProfile(
      language: _selectedLangCode == 'ar' ? 'ar' : 'en',
    );

    if (!success) {
      // Rollback on failure
      await getIt<LocaleCubit>().rollbackLocale(previousLocale);
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
      return;
    }

    await getIt<LocaleCubit>().updateLocale(newLocale);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.primary),
        title: Text(context.l10n.languageScreenTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              _buildLanguageOption(
                code: 'en',
                title: context.l10n.languageEnglish,
                subtitle: context.l10n.languageEnglish,
              ),
              SizedBox(height: 16.h),
              _buildLanguageOption(
                code: 'ar',
                title: context.l10n.languageArabic,
                subtitle: context.l10n.languageArabic,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _confirmSelection,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: _isSubmitting
                      ? SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: CircularProgressIndicator(
                            color: colorScheme.onPrimary,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          context.l10n.languageConfirmButton,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String code,
    required String title,
    required String subtitle,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isSelected = _selectedLangCode == code;

    return InkWell(
      onTap: _isSubmitting
          ? null
          : () => setState(() => _selectedLangCode = code),
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
                Icons.language_rounded,
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: code,
              groupValue: _selectedLangCode,
              onChanged: _isSubmitting
                  ? null
                  : (val) {
                      if (val != null) {
                        setState(() => _selectedLangCode = val);
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
