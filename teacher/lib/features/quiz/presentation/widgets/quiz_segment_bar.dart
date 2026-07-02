import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';

/// Segment index constants for the quiz details sections.
abstract final class QuizSection {
  static const int questions = 0;
  static const int settings = 1;
  static const int results = 2;
}

/// A pill-shaped Material 3 segment bar for switching between
/// quiz detail sections (Questions, Settings, Results).
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

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 2),
            color: Colors.black12,
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SegmentedButton<int>(
          selected: {selectedIndex},
          onSelectionChanged: (values) => onChanged(values.first),
          showSelectedIcon: false,
          style: SegmentedButton.styleFrom(
            backgroundColor: Colors.transparent,
            selectedBackgroundColor: colorScheme.primary,
            selectedForegroundColor: colorScheme.onPrimary,
            foregroundColor: colorScheme.onSurfaceVariant,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          segments: [
            ButtonSegment<int>(
              value: QuizSection.questions,
              label: Text(
                context.l10n.quizTabQuestions,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              icon: Icon(Icons.quiz_outlined, size: 16.r),
            ),
            ButtonSegment<int>(
              value: QuizSection.settings,
              label: Text(
                context.l10n.quizTabSettings,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              icon: Icon(Icons.settings_outlined, size: 16.r),
            ),
            ButtonSegment<int>(
              value: QuizSection.results,
              label: Text(
                context.l10n.quizTabResults,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              icon: Icon(Icons.bar_chart_outlined, size: 16.r),
            ),
          ],
        ),
      ),
    );
  }
}
