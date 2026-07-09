import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/class_model.dart';

/// A single class card matching the mockup design.
///
/// Shows a colored accent line, a class-code pill, the subject as the
/// title, a meta row (students + schedule), and icon rows for the next
/// lesson / urgent alert and submission status.
class ClassCard extends StatelessWidget {
  const ClassCard({required this.classData, required this.onTap, super.key});

  final ClassModel classData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasAlert = classData.urgentAlert != null;
    final accentColor = hasAlert
        ? colorScheme.error
        : _categoryColor(classData.category, colorScheme);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: hasAlert
              ? colorScheme.error.withValues(alpha: 0.4)
              : colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 4.h, color: accentColor),
            Padding(
              padding: EdgeInsets.all(18.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ClassHeader(classData: classData),
                  SizedBox(height: 14.h),
                  _ClassMetaRow(classData: classData),
                  SizedBox(height: 14.h),
                  Divider(
                    height: 1,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                  ),
                  SizedBox(height: 14.h),
                  if (classData.urgentAlert != null)
                    _UrgentAlertRow(alert: classData.urgentAlert!)
                  else if (classData.nextLesson != null)
                    _NextLessonRow(lesson: classData.nextLesson!),
                  if (classData.submissionStatus != null) ...[
                    SizedBox(height: 12.h),
                    _SubmissionsRow(status: classData.submissionStatus!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _categoryColor(String category, ColorScheme colorScheme) {
    switch (category) {
      case 'Mathematics':
        return const Color(0xFF003EB3);
      case 'Science':
        return const Color(0xFF006875);
      case 'Networking':
        return const Color(0xFF6D28D9);
      case 'Literature':
        return AppColors.tertiary;
      default:
        return colorScheme.primary;
    }
  }
}

class _ClassHeader extends StatelessWidget {
  const _ClassHeader({required this.classData});

  final ClassModel classData;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.7,
                  ),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  classData.code.toUpperCase(),
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                classData.subject,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Icon(Icons.more_vert, size: 20.r, color: colorScheme.onSurfaceVariant),
      ],
    );
  }
}

class _ClassMetaRow extends StatelessWidget {
  const _ClassMetaRow({required this.classData});

  final ClassModel classData;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w500,
    );

    return Row(
      children: [
        Icon(
          Icons.people_outline,
          size: 18.r,
          color: colorScheme.onSurfaceVariant,
        ),
        SizedBox(width: 6.w),
        Text(
          context.l10n.classStudentsCount(classData.studentCount),
          style: style,
        ),
        SizedBox(width: 20.w),
        Icon(
          Icons.access_time,
          size: 18.r,
          color: colorScheme.onSurfaceVariant,
        ),
        SizedBox(width: 6.w),
        Flexible(
          child: Text(
            classData.scheduleTime,
            style: style,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// A row with a soft square icon, an uppercase label and a value.
class _IconInfoRow extends StatelessWidget {
  const _IconInfoRow({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.label,
    required this.value,
    this.showChevron = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String label;
  final Widget value;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 34.r,
          height: 34.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 18.r, color: iconColor),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 2.h),
              value,
            ],
          ),
        ),
        if (showChevron)
          Icon(
            Icons.chevron_right,
            size: 22.r,
            color: colorScheme.outlineVariant,
          ),
      ],
    );
  }
}

class _NextLessonRow extends StatelessWidget {
  const _NextLessonRow({required this.lesson});

  final String lesson;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return _IconInfoRow(
      icon: Icons.menu_book_outlined,
      iconColor: colorScheme.primary,
      iconBackground: colorScheme.primary.withValues(alpha: 0.1),
      label: context.l10n.classNextLesson,
      value: Text(
        lesson,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _SubmissionsRow extends StatelessWidget {
  const _SubmissionsRow({required this.status});

  final SubmissionStatus status;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final isAllDone = status.isAllCaughtUp;
    final statusColor = isAllDone ? AppColors.success : AppColors.warning;

    return _IconInfoRow(
      icon: isAllDone ? Icons.check_circle_outline : Icons.assignment_outlined,
      iconColor: statusColor,
      iconBackground: statusColor.withValues(alpha: 0.12),
      label: context.l10n.classSubmissions,
      showChevron: true,
      value: isAllDone
          ? Text(
              context.l10n.classAllCaughtUp,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            )
          : Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: context.l10n.classPendingReview(status.pendingCount),
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _UrgentAlertRow extends StatelessWidget {
  const _UrgentAlertRow({required this.alert});

  final String alert;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_rounded,
            size: 20.r,
            color: colorScheme.onErrorContainer,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.classUrgentAlert,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onErrorContainer.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  alert,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onErrorContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
