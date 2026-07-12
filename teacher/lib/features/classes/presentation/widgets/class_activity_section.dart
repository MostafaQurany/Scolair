import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/class_model.dart';

/// Class activity section showing announcements and grading cards.
class ClassActivitySection extends StatelessWidget {
  const ClassActivitySection({
    required this.activities,
    this.onGradeNow,
    super.key,
  });

  final List<ClassActivity> activities;
  final VoidCallback? onGradeNow;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.classActivity,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 14.h),
        ...activities.map(
          (activity) => switch (activity.type) {
            ClassActivityType.announcement => _AnnouncementCard(
              activity: activity,
            ),
            ClassActivityType.grading => _GradingCard(
              activity: activity,
              onGradeNow: onGradeNow,
            ),
          },
        ),
      ],
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  const _AnnouncementCard({required this.activity});

  final ClassActivity activity;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.campaign_outlined,
                size: 20.r,
                color: colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  activity.title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (activity.timestamp != null)
                Text(
                  activity.timestamp!,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            activity.description,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _GradingCard extends StatelessWidget {
  const _GradingCard({required this.activity, this.onGradeNow});

  final ClassActivity activity;
  final VoidCallback? onGradeNow;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final submitted = activity.submittedCount ?? 0;
    final total = activity.totalCount ?? 0;
    final progress = total == 0 ? 0.0 : submitted / total;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.grading_outlined,
                size: 20.r,
                color: AppColors.warning,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  activity.title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              FilledButton(
                onPressed: onGradeNow,
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  minimumSize: Size(0, 34.h),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(context.l10n.classGradeNow),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            activity.badgeLabel ?? activity.description,
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          if (total > 0) ...[
            SizedBox(height: 10.h),
            Row(
              children: [
                Text(
                  context.l10n.classSubmitted,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const Spacer(),
                Text(
                  '$submitted/$total',
                  style: textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6.h,
                backgroundColor: colorScheme.surfaceContainerHighest,
                valueColor: const AlwaysStoppedAnimation(AppColors.warning),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
