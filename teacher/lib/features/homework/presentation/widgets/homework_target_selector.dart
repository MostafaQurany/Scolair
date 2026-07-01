import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/homework_models.dart';

class HomeworkTargetSelector extends StatelessWidget {
  const HomeworkTargetSelector({
    required this.targetType,
    required this.onTargetTypeChanged,
    required this.targetNameController,
    super.key,
  });

  final HomeworkTargetType targetType;
  final ValueChanged<HomeworkTargetType> onTargetTypeChanged;
  final TextEditingController targetNameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TargetOptionCard(
          icon: Icons.quiz_outlined,
          label: context.l10n.homeworkTargetExamQuiz,
          selected: targetType == HomeworkTargetType.examQuiz,
          onTap: () => onTargetTypeChanged(HomeworkTargetType.examQuiz),
        ),
        SizedBox(height: 8.h),
        _TargetOptionCard(
          icon: Icons.menu_book_outlined,
          label: context.l10n.homeworkTargetLesson,
          selected: targetType == HomeworkTargetType.lesson,
          onTap: () => onTargetTypeChanged(HomeworkTargetType.lesson),
        ),
        SizedBox(height: 16.h),
        TextFormField(
          controller: targetNameController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            labelText: targetType == HomeworkTargetType.examQuiz
                ? context.l10n.homeworkSearchExamLabel
                : context.l10n.homeworkSearchLessonLabel,
            hintText: context.l10n.homeworkSearchTargetHint,
          ),
          validator: (value) => value == null || value.trim().isEmpty
              ? context.l10n.homeworkTargetRequired
              : null,
        ),
      ],
    );
  }
}

class _TargetOptionCard extends StatelessWidget {
  const _TargetOptionCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primaryContainer.withValues(alpha: 0.4)
              : null,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? colorScheme.primary : colorScheme.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: selected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
            ),
          ],
        ),
      ),
    );
  }
}
