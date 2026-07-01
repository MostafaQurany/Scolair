import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';

class QuizDetailsHeaderCard extends StatelessWidget {
  const QuizDetailsHeaderCard({required this.quiz, super.key});

  final QuizModel quiz;

  String _typeLabel(BuildContext context) => switch (quiz.type) {
    QuizType.quiz => context.l10n.quizTypeQuiz,
    QuizType.midterm => context.l10n.quizTypeMidterm,
    QuizType.final_ => context.l10n.quizTypeFinal,
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _typeLabel(context),
              style: textTheme.labelLarge?.copyWith(color: colorScheme.primary),
            ),
            SizedBox(height: 4.h),
            Text(
              quiz.title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (quiz.description != null) ...[
              SizedBox(height: 4.h),
              Text(
                quiz.description!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            SizedBox(height: 12.h),
            Wrap(
              spacing: 16.w,
              runSpacing: 8.h,
              children: [
                _InfoItem(
                  icon: Icons.calendar_today_outlined,
                  label: DateFormat.yMMMd().format(quiz.startDateTime),
                ),
                _InfoItem(
                  icon: Icons.timer_outlined,
                  label: context.l10n.quizDurationMinutes(quiz.durationMinutes),
                ),
                _InfoItem(
                  icon: Icons.grade_outlined,
                  label: context.l10n.quizMaxGradeLabel(quiz.maxGrade),
                ),
                _InfoItem(
                  icon: Icons.check_circle_outline,
                  label: context.l10n.quizPassingGradeLabel(quiz.minPassing),
                ),
                _InfoItem(
                  icon: Icons.quiz_outlined,
                  label: context.l10n.quizQuestionsCount(quiz.questions.length),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.r, color: colorScheme.onSurfaceVariant),
        SizedBox(width: 4.w),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
