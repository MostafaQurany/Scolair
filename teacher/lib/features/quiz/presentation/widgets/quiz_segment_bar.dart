import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';

/// Segment index constants for the quiz details sections.
abstract final class QuizSection {
  static const int questions = 0;
  static const int settings = 1;
  static const int review = 2;
}

/// An underline-style tab bar for switching between quiz detail
/// sections (Questions, Settings, Review).
class QuizSegmentBar extends StatelessWidget {
  const QuizSegmentBar({
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _TabItem(
              label: context.l10n.quizTabQuestions,
              icon: Icons.quiz_outlined,
              isSelected: selectedIndex == QuizSection.questions,
              onTap: () => onChanged(QuizSection.questions),
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
            SizedBox(width: 8.w),
            _TabItem(
              label: context.l10n.quizTabSettings,
              icon: Icons.settings_outlined,
              isSelected: selectedIndex == QuizSection.settings,
              onTap: () => onChanged(QuizSection.settings),
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
            SizedBox(width: 8.w),
            _TabItem(
              label: context.l10n.quizTabReview,
              icon: Icons.bar_chart_outlined,
              isSelected: selectedIndex == QuizSection.review,
              onTap: () => onChanged(QuizSection.review),
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
    required this.textTheme,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? colorScheme.primary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.r, color: color),
            SizedBox(width: 6.w),
            Text(
              label,
              style: textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
