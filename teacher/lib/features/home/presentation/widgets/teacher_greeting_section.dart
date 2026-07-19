import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';

class TeacherGreetingSection extends StatelessWidget {
  const TeacherGreetingSection({
    required this.teacherName,
    this.greetingActivityTitle,
    super.key,
  });

  final String teacherName;
  final String? greetingActivityTitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final hour = DateTime.now().hour;
    final String greetingText;
    if (hour >= 0 && hour < 12) {
      greetingText = context.l10n.homeGreetingMorning;
    } else if (hour >= 12 && hour < 17) {
      greetingText = context.l10n.homeGreetingAfternoon;
    } else {
      greetingText = context.l10n.homeGreetingEvening;
    }

    final secondaryText = greetingActivityTitle != null
        ? context.l10n.homeGreetingSecondaryWithActivity(greetingActivityTitle!)
        : context.l10n.homeGreetingSecondaryFallback;

    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.school_outlined,
                size: 22.r,
                color: colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  context.l10n.homeGreetingTemplate(greetingText, teacherName),
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 30.w),
            child: Text(
              secondaryText,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
