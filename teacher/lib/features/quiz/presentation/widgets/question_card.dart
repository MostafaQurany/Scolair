import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';
import 'question_type_badge.dart';

/// Compact question card for the quiz questions list.
/// Shows drag handle, question number, type badge, marks badge,
/// question text preview, and action buttons.
class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required this.index,
    required this.question,
    this.isSelectionMode = false,
    this.isSelected = false,
    this.onToggleSelection,
    this.onEdit,
    this.onDuplicate,
    this.onDelete,
    super.key,
  });

  final int index;
  final QuizQuestionModel question;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback? onToggleSelection;
  final VoidCallback? onEdit;
  final VoidCallback? onDuplicate;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primary.withValues(alpha: 0.05)
            : theme.cardTheme.color ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          width: isSelected ? 2.w : 1.w,
        ),
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: isSelectionMode ? onToggleSelection : onEdit,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: Row(
              children: [
                if (isSelectionMode)
                  Checkbox(
                    value: isSelected,
                    onChanged: (_) => onToggleSelection?.call(),
                    activeColor: colorScheme.primary,
                  ),
                Expanded(
                  child: _CardContent(
                    index: index,
                    question: question,
                    textTheme: textTheme,
                  ),
                ),
                if (!isSelectionMode && onDelete != null)
                  _DeleteButton(onDelete: onDelete!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.index,
    required this.question,
    required this.textTheme,
  });

  final int index;
  final QuizQuestionModel question;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BadgesRow(index: index, question: question, textTheme: textTheme),
        SizedBox(height: 8.h),
        Text(
          question.displayText,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 6.h),
        _ChoicesInfo(question: question),
      ],
    );
  }
}

class _BadgesRow extends StatelessWidget {
  const _BadgesRow({
    required this.index,
    required this.question,
    required this.textTheme,
  });

  final int index;
  final QuizQuestionModel question;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8.w,
      runSpacing: 4.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          context.l10n.questionNumberLabel(index),
          style: textTheme.titleSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        QuestionTypeBadge(type: question.type ?? ApiQuestionType.choices),
        _MarksBadge(marks: question.marks),
      ],
    );
  }
}

class _MarksBadge extends StatelessWidget {
  const _MarksBadge({required this.marks});

  final int marks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        context.l10n.questionPointsLabel(marks),
        style: theme.textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ChoicesInfo extends StatelessWidget {
  const _ChoicesInfo({required this.question});

  final QuizQuestionModel question;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final type = question.type ?? ApiQuestionType.choices;
    if (type != ApiQuestionType.choices) {
      return const SizedBox.shrink();
    }

    var count = 0;
    if (question.option1 != null) count++;
    if (question.option2 != null) count++;
    if (question.option3 != null) count++;
    if (question.option4 != null) count++;
    if (question.option5 != null) count++;

    if (count == 0) return const SizedBox.shrink();

    return Row(
      children: [
        Icon(
          Icons.list_alt_rounded,
          size: 14.r,
          color: isDark ? AppColors.darkTextMuted : AppColors.textMuted,
        ),
        SizedBox(width: 4.w),
        Text(
          context.l10n.quizChoicesCount(count),
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({required this.onDelete});

  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton(
      icon: Icon(Icons.delete_outline, size: 20.r, color: colorScheme.error),
      onPressed: onDelete,
      constraints: BoxConstraints(minWidth: 44.r, minHeight: 44.r),
      padding: EdgeInsets.zero,
    );
  }
}
