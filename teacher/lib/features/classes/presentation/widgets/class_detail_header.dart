import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/class_model.dart';

/// Dark gradient header for the Class Detail screen showing class
/// identity, schedule and primary actions.
class ClassDetailHeader extends StatelessWidget {
  const ClassDetailHeader({
    required this.classData,
    this.onViewStudents,
    this.onExamsQuizzes,
    super.key,
  });

  final ClassModel classData;
  final VoidCallback? onViewStudents;
  final VoidCallback? onExamsQuizzes;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 24.h,
        top: MediaQuery.of(context).padding.top + 8.h,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0B1B3F), Color(0xFF0052FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _CircleIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.of(context).maybePop(),
              ),
              const Spacer(),
              Image.asset('assets/images/logo_header.png', height: 26.h),
              const Spacer(),
              _CircleIconButton(icon: Icons.info_outline, onTap: () {}),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            classData.category.toUpperCase(),
            style: textTheme.labelMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  classData.code,
                  style: textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _StudentCountBadge(count: classData.studentCount),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16.r,
                color: Colors.white.withValues(alpha: 0.8),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  classData.scheduleDays,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: onViewStudents,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0052FF),
                    minimumSize: Size(0, 44.h),
                  ),
                  icon: Icon(Icons.people_outline, size: 20.r),
                  label: Text(context.l10n.classDetailViewStudents),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onExamsQuizzes,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                    minimumSize: Size(0, 44.h),
                  ),
                  icon: Icon(Icons.quiz_outlined, size: 20.r),
                  label: Text(context.l10n.classDetailExamsQuizzes),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StudentCountBadge extends StatelessWidget {
  const _StudentCountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 64.r,
      height: 64.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$count',
            style: textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            context.l10n.classStudents,
            style: textTheme.labelSmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 40.r,
        height: 40.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20.r),
      ),
    );
  }
}
