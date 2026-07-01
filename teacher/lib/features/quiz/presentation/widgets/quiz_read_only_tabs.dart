import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';

class QuizSettingsTab extends StatelessWidget {
  const QuizSettingsTab({required this.quiz, super.key});

  final QuizModel quiz;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.r),
      children: [
        _SettingRow(
          label: context.l10n.quizRandomizeQuestions,
          value: quiz.randomizeQuestions,
        ),
        _SettingRow(
          label: context.l10n.quizRandomizeAnswers,
          value: quiz.randomizeAnswers,
        ),
        _SettingRow(
          label: context.l10n.quizShowResultImmediately,
          value: quiz.showResultImmediately,
        ),
        _SettingRow(
          label: context.l10n.quizShowCorrectAnswers,
          value: quiz.showCorrectAnswers,
        ),
        _SettingRow(
          label: context.l10n.quizAllowRetake,
          value: quiz.allowRetake,
        ),
        _SettingRow(
          label: context.l10n.quizPreventLateSubmission,
          value: quiz.preventLateSubmission,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(context.l10n.quizMaxAttemptsLabel),
          trailing: Text('${quiz.maxAttempts}'),
        ),
      ],
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({required this.label, required this.value});

  final String label;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Icon(
        value ? Icons.check_circle : Icons.cancel_outlined,
        color: value ? colorScheme.primary : colorScheme.outlineVariant,
      ),
    );
  }
}

class QuizResultsTab extends StatelessWidget {
  const QuizResultsTab({required this.quiz, super.key});

  final QuizModel quiz;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bar_chart,
              size: 48.r,
              color: colorScheme.outlineVariant,
            ),
            SizedBox(height: 12.h),
            Text(
              context.l10n.quizSubmittedProgress(
                quiz.submittedCount,
                quiz.totalStudents,
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 4.h),
            Text(
              quiz.submittedCount == 0
                  ? context.l10n.quizResultPending
                  : context.l10n.quizGradedProgress(
                      quiz.gradedCount,
                      quiz.submittedCount,
                    ),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
