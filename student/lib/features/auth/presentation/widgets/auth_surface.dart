import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AuthSurface extends StatelessWidget {
  const AuthSurface({required this.child,
    this.isBack = false,
    this.centered = false, super.key});

  final Widget child;
  final bool centered;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final padding = MediaQuery.paddingOf(context);
    final minHeight =
        screenHeight - padding.top - padding.bottom - 48.h - 24.h;

    final content = SingleChildScrollView(
      padding: EdgeInsetsDirectional.fromSTEB(
        16.w,
        isBack ? 8.h : 48.h,
        16.w,
        24.h,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: centered ? Center(child: child) : child,
      ),
    );

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isBack)
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_sharp),
              ),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatelessWidget {
  const AuthCard({required this.child, this.padding, super.key});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsetsDirectional.all(16.r),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 16.r,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: child,
    );
  }
}

class AuthBrandMark extends StatelessWidget {
  const AuthBrandMark({this.label, this.compact = false, super.key});

  final String? label;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final iconSize = compact ? 24.r : 64.r;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: compact ? Colors.transparent : AppColors.primary,
            borderRadius: BorderRadius.circular(compact ? 0 : 12.r),
            boxShadow: compact
                ? null
                : [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.18),
                      blurRadius: 14.r,
                      offset: Offset(0, 5.h),
                    ),
                  ],
          ),
          child: Icon(
            Icons.school_outlined,
            color: compact ? AppColors.primary : AppColors.darkTextPrimary,
            size: compact ? 22.r : 32.r,
          ),
        ),
        if (!compact && label != null) ...[
          SizedBox(height: 12.h),
          Text(
            label!,
            style: AppTextStyles.textTheme(
              Brightness.light,
            ).displaySmall?.copyWith(color: AppColors.primary, fontSize: 28.sp),
          ),
        ],
      ],
    );
  }
}

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    required this.title,
    required this.subtitle,
    this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null) ...[
          Container(
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28.r),
          ),
          SizedBox(height: 24.h),
        ],
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class AuthSecondaryAction extends StatelessWidget {
  const AuthSecondaryAction({
    required this.label,
    required this.onPressed,
    this.icon,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 18.r),
      label: Text(label),
    );
  }
}
