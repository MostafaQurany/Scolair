import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/quiz_models.dart';
import 'question_type_badge.dart';
import 'quiz_viewer_role.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required this.index,
    required this.question,
    this.viewerRole = QuizViewerRole.teacher,
    this.onEdit,
    this.onDuplicate,
    this.onDelete,
    super.key,
  });

  final int index;
  final QuestionModel question;
  final QuizViewerRole viewerRole;
  final VoidCallback? onEdit;
  final VoidCallback? onDuplicate;
  final VoidCallback? onDelete;

  bool get _isTeacher => viewerRole == QuizViewerRole.teacher;

  String _difficultyLabel(BuildContext context) =>
      switch (question.difficulty) {
        QuestionDifficulty.easy => context.l10n.questionDifficultyEasy,
        QuestionDifficulty.medium => context.l10n.questionDifficultyMedium,
        QuestionDifficulty.hard => context.l10n.questionDifficultyHard,
      };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                context.l10n.questionNumberLabel(index),
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              QuestionTypeBadge(type: question.type),
              _Badge(label: context.l10n.questionPointsLabel(question.points)),
              _Badge(label: _difficultyLabel(context)),
              if (question.required)
                _Badge(label: context.l10n.questionRequiredLabel),
            ],
          ),
          SizedBox(height: 10.h),
          Text(question.text, style: textTheme.bodyMedium),
          SizedBox(height: 10.h),
          _QuestionPreview(question: question, showAnswers: _isTeacher),
          if (_isTeacher) ...[
            SizedBox(height: 10.h),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined, size: 16),
                    label: Text(context.l10n.edit),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: onDuplicate,
                    icon: const Icon(Icons.copy_outlined, size: 16),
                    label: Text(context.l10n.duplicate),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_outline,
                      size: 16,
                      color: colorScheme.error,
                    ),
                    label: Text(
                      context.l10n.delete,
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

class _QuestionPreview extends StatelessWidget {
  const _QuestionPreview({required this.question, required this.showAnswers});

  final QuestionModel question;
  final bool showAnswers;

  @override
  Widget build(BuildContext context) {
    switch (question.type) {
      case QuestionType.multipleChoice:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: question.options
              .map(
                (option) => _OptionRow(
                  text: option.text,
                  isCorrect: showAnswers && option.isCorrect,
                ),
              )
              .toList(),
        );
      case QuestionType.trueFalse:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OptionRow(
              text: context.l10n.questionTrue,
              isCorrect: showAnswers && question.correctBoolAnswer == true,
            ),
            _OptionRow(
              text: context.l10n.questionFalse,
              isCorrect: showAnswers && question.correctBoolAnswer == false,
            ),
          ],
        );
      case QuestionType.shortAnswer:
        return showAnswers
            ? _AcceptedAnswer(answer: question.acceptedAnswer ?? '')
            : const SizedBox.shrink();
      case QuestionType.essay:
      case QuestionType.fillBlank:
      case QuestionType.matching:
        return const SizedBox.shrink();
    }
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({required this.text, required this.isCorrect});

  final String text;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Icon(
            isCorrect ? Icons.check_circle : Icons.circle_outlined,
            size: 16.r,
            color: isCorrect
                ? AppColors.success
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}

class _AcceptedAnswer extends StatelessWidget {
  const _AcceptedAnswer({required this.answer});

  final String answer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.questionAcceptedAnswerLabel,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        SizedBox(height: 2.h),
        Text(answer, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
