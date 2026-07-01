import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';

class SecurityResultsAccordion extends StatelessWidget {
  const SecurityResultsAccordion({
    required this.randomizeQuestions,
    required this.randomizeAnswers,
    required this.showResultImmediately,
    required this.showCorrectAnswers,
    required this.allowRetake,
    required this.preventLateSubmission,
    required this.maxAttemptsController,
    required this.onRandomizeQuestionsChanged,
    required this.onRandomizeAnswersChanged,
    required this.onShowResultImmediatelyChanged,
    required this.onShowCorrectAnswersChanged,
    required this.onAllowRetakeChanged,
    required this.onPreventLateSubmissionChanged,
    super.key,
  });

  final bool randomizeQuestions;
  final bool randomizeAnswers;
  final bool showResultImmediately;
  final bool showCorrectAnswers;
  final bool allowRetake;
  final bool preventLateSubmission;
  final TextEditingController maxAttemptsController;
  final ValueChanged<bool> onRandomizeQuestionsChanged;
  final ValueChanged<bool> onRandomizeAnswersChanged;
  final ValueChanged<bool> onShowResultImmediatelyChanged;
  final ValueChanged<bool> onShowCorrectAnswersChanged;
  final ValueChanged<bool> onAllowRetakeChanged;
  final ValueChanged<bool> onPreventLateSubmissionChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(Icons.shield_outlined, color: colorScheme.primary),
          title: Text(
            context.l10n.quizSecurityResultsSection,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          children: [
            _SwitchRow(
              label: context.l10n.quizRandomizeQuestions,
              value: randomizeQuestions,
              onChanged: onRandomizeQuestionsChanged,
            ),
            _SwitchRow(
              label: context.l10n.quizRandomizeAnswers,
              value: randomizeAnswers,
              onChanged: onRandomizeAnswersChanged,
            ),
            _SwitchRow(
              label: context.l10n.quizShowResultImmediately,
              value: showResultImmediately,
              onChanged: onShowResultImmediatelyChanged,
            ),
            _SwitchRow(
              label: context.l10n.quizShowCorrectAnswers,
              value: showCorrectAnswers,
              onChanged: onShowCorrectAnswersChanged,
            ),
            _SwitchRow(
              label: context.l10n.quizAllowRetake,
              value: allowRetake,
              onChanged: onAllowRetakeChanged,
            ),
            _SwitchRow(
              label: context.l10n.quizPreventLateSubmission,
              value: preventLateSubmission,
              onChanged: onPreventLateSubmissionChanged,
            ),
            SizedBox(height: 8.h),
            TextFormField(
              controller: maxAttemptsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: context.l10n.quizMaxAttemptsLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      value: value,
      onChanged: onChanged,
    );
  }
}
