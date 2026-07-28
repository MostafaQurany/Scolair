import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Theme.of(context).colorScheme.primary),
        title: Text(context.l10n.helpSupportScreenTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              _buildHelpTile(
                context,
                icon: Icons.question_answer_outlined,
                title: context.l10n.helpFaqItem,
                onTap: () => _openUrl(context, 'https://dev.scolair.site/faq'),
              ),
              SizedBox(height: 16.h),
              _buildHelpTile(
                context,
                icon: Icons.support_agent_rounded,
                title: context.l10n.helpContactItem,
                onTap: () => _openUrl(context, 'mailto:support@scolair.site'),
              ),
              SizedBox(height: 16.h),
              _buildHelpTile(
                context,
                icon: Icons.bug_report_outlined,
                title: context.l10n.helpReportItem,
                onTap: () => _openUrl(
                  context,
                  'mailto:support@scolair.site?subject=Scolair%20teacher%20app%20bug',
                ),
              ),
              SizedBox(height: 16.h),
              _buildHelpTile(
                context,
                icon: Icons.privacy_tip_outlined,
                title: context.l10n.helpPrivacyItem,
                onTap: () =>
                    _openUrl(context, 'https://dev.scolair.site/privacy'),
              ),
              SizedBox(height: 16.h),
              _buildHelpTile(
                context,
                icon: Icons.description_outlined,
                title: context.l10n.helpTermsItem,
                onTap: () =>
                    _openUrl(context, 'https://dev.scolair.site/terms'),
              ),
              SizedBox(height: 32.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.4,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.6),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.help_center_outlined,
                      color: colorScheme.primary,
                      size: 22.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        context.l10n.helpUrgentNotice,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openUrl(BuildContext context, String rawUrl) async {
    final uri = Uri.parse(rawUrl);
    if (await canLaunchUrl(uri) &&
        await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return;
    }
    if (context.mounted) {
      AppSnackBar.showError(context, context.l10n.authErrorGeneric);
    }
  }

  Widget _buildHelpTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: colorScheme.primary, size: 22.sp),
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
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
