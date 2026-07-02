import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/class_model.dart';

/// Curriculum section listing lessons, chapters and problem sets
/// with their completion status.
class CurriculumSection extends StatelessWidget {
  const CurriculumSection({
    required this.items,
    this.currentWeek = 4,
    this.totalWeeks = 12,
    super.key,
  });

  final List<CurriculumItem> items;
  final int currentWeek;
  final int totalWeeks;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.classCurriculum,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                context.l10n.classCurriculumWeek(currentWeek, totalWeeks),
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        ...items.map((item) => _CurriculumTile(item: item)),
      ],
    );
  }
}

class _CurriculumTile extends StatelessWidget {
  const _CurriculumTile({required this.item});

  final CurriculumItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final statusColor = _statusColor(context, item.status);
    final isCurrent = item.status == CurriculumStatus.current;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: isCurrent
            ? colorScheme.primaryContainer.withValues(alpha: 0.4)
            : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isCurrent
              ? colorScheme.primary.withValues(alpha: 0.5)
              : colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          _LeadingIndicator(item: item, statusColor: statusColor),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (item.subtitle != null && item.subtitle!.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    item.subtitle!,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (item.dueDate != null) ...[
            SizedBox(width: 8.w),
            _DueBadge(dueDate: item.dueDate!, color: statusColor),
          ],
        ],
      ),
    );
  }

  Color _statusColor(BuildContext context, CurriculumStatus status) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (status) {
      case CurriculumStatus.completed:
        return AppColors.success;
      case CurriculumStatus.current:
        return colorScheme.primary;
      case CurriculumStatus.overdue:
        return colorScheme.error;
      case CurriculumStatus.upcoming:
        return colorScheme.onSurfaceVariant;
    }
  }
}

class _LeadingIndicator extends StatelessWidget {
  const _LeadingIndicator({required this.item, required this.statusColor});

  final CurriculumItem item;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    if (item.type == CurriculumType.chapter && item.itemNumber != null) {
      return Container(
        width: 32.r,
        height: 32.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: statusColor.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Text(
          item.itemNumber!,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: statusColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Container(
      width: 32.r,
      height: 32.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(_statusIcon(item), size: 18.r, color: statusColor),
    );
  }

  IconData _statusIcon(CurriculumItem item) {
    switch (item.status) {
      case CurriculumStatus.completed:
        return Icons.check;
      case CurriculumStatus.current:
        return Icons.play_arrow_rounded;
      case CurriculumStatus.overdue:
        return Icons.error_outline;
      case CurriculumStatus.upcoming:
        return item.type == CurriculumType.problemSet
            ? Icons.assignment_outlined
            : Icons.lock_outline;
    }
  }
}

class _DueBadge extends StatelessWidget {
  const _DueBadge({required this.dueDate, required this.color});

  final String dueDate;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        dueDate,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
