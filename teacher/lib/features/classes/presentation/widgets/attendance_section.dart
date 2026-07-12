import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/class_model.dart';

/// Attendance section with a circular progress indicator, present/absent
/// stats and a "Take Attendance" button.
class AttendanceSection extends StatelessWidget {
  const AttendanceSection({
    required this.data,
    this.onTakeAttendance,
    super.key,
  });

  final AttendanceData data;
  final VoidCallback? onTakeAttendance;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.classAttendance,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 14.h),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _AttendanceDonut(percentage: data.percentage),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      children: [
                        _StatCard(
                          label: context.l10n.classPresentToday,
                          value: data.presentToday,
                          color: AppColors.success,
                          icon: Icons.check_circle_outline,
                        ),
                        SizedBox(height: 10.h),
                        _StatCard(
                          label: context.l10n.classAbsentToday,
                          value: data.absentToday,
                          color: colorScheme.error,
                          icon: Icons.cancel_outlined,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onTakeAttendance,
                  icon: Icon(Icons.how_to_reg_outlined, size: 20.r),
                  label: Text(context.l10n.classTakeAttendance),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AttendanceDonut extends StatelessWidget {
  const _AttendanceDonut({required this.percentage});

  final double percentage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 96.r,
      height: 96.r,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 96.r,
            height: 96.r,
            child: CircularProgressIndicator(
              value: percentage / 100,
              strokeWidth: 8.r,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: const AlwaysStoppedAnimation(AppColors.success),
              strokeCap: StrokeCap.round,
            ),
          ),
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final int value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.r, color: color),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Text(
            '$value',
            style: textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
