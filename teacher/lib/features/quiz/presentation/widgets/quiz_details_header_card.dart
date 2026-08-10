import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/adaptive_layout_extension.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';

/// Stats grid showing quiz metadata: question count, total points,
/// time limit, and passing score. Adapts to 2x2 on mobile
/// and 4-in-a-row on tablet.
class QuizDetailsHeaderCard extends StatelessWidget {
  const QuizDetailsHeaderCard({required this.quiz, super.key});

  final QuizModel quiz;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTabletLayout;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _QuizSubtitle(quiz: quiz),
          SizedBox(height: 12.h),
          if (isTablet)
            Row(
              children: [
                Expanded(child: _StatBox.questions(context, quiz)),
                SizedBox(width: 10.w),
                Expanded(child: _StatBox.totalPoints(context, quiz)),
                SizedBox(width: 10.w),
                Expanded(child: _StatBox.timeLimit(context, quiz)),
                SizedBox(width: 10.w),
                Expanded(child: _StatBox.passingScore(context, quiz)),
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _StatBox.questions(context, quiz)),
                    SizedBox(width: 10.w),
                    Expanded(child: _StatBox.totalPoints(context, quiz)),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(child: _StatBox.timeLimit(context, quiz)),
                    SizedBox(width: 10.w),
                    Expanded(child: _StatBox.passingScore(context, quiz)),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _QuizSubtitle extends StatelessWidget {
  const _QuizSubtitle({required this.quiz});

  final QuizModel quiz;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        if (quiz.course != null && quiz.course!.isNotEmpty) ...[
          Icon(
            Icons.school_outlined,
            size: 14.r,
            color: colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 4.w),
          Text(
            quiz.course!,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(width: 12.w),
        ],
        if (quiz.lesson != null && quiz.lesson!.isNotEmpty) ...[
          Icon(
            Icons.bookmark_outline,
            size: 14.r,
            color: colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 4.w),
          Text(
            quiz.lesson!,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  factory _StatBox.questions(BuildContext context, QuizModel quiz) => _StatBox(
    icon: Icons.help_outline_rounded,
    value: '${quiz.questions.length}',
    label: context.l10n.quizTabQuestions,
    iconColor: const Color(0xFF2196F3),
  );

  factory _StatBox.totalPoints(BuildContext context, QuizModel quiz) {
    final total = quiz.questions.fold<int>(0, (sum, q) => sum + q.marks);
    return _StatBox(
      icon: Icons.star_outline_rounded,
      value: '$total',
      label: context.l10n.quizPointsSuffix,
      iconColor: const Color(0xFFFF9800),
    );
  }

  factory _StatBox.timeLimit(BuildContext context, QuizModel quiz) {
    final duration = quiz.duration;
    final display = (duration != null && duration.isNotEmpty)
        ? '$duration min'
        : '∞';
    return _StatBox(
      icon: Icons.timer_outlined,
      value: display,
      label: context.l10n.quizTimeLimitLabel,
      iconColor: const Color(0xFF4CAF50),
    );
  }

  factory _StatBox.passingScore(BuildContext context, QuizModel quiz) =>
      _StatBox(
        icon: Icons.trending_up_rounded,
        value: '${quiz.passingPercentage}%',
        label: context.l10n.quizPassingScoreLabel,
        iconColor: const Color(0xFF9C27B0),
      );

  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22.r, color: iconColor),
          SizedBox(height: 8.h),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
