import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';

import '../../../question/presentation/widgets/question_type_label.dart';

class QuestionTypeSelector extends StatelessWidget {
  const QuestionTypeSelector({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final ApiQuestionType value;
  final ValueChanged<ApiQuestionType> onChanged;

  IconData _iconFor(ApiQuestionType type) {
    return switch (type) {
      ApiQuestionType.choices => Icons.check_circle_outline,
      ApiQuestionType.userInput => Icons.keyboard_alt_outlined,
      ApiQuestionType.openEnded => Icons.notes_outlined,
      ApiQuestionType.fileUpload => Icons.upload_file_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemWidth;
        if (constraints.maxWidth < 360) {
          itemWidth = (constraints.maxWidth - 8.w) / 2;
        } else if (constraints.maxWidth < 600) {
          itemWidth = (constraints.maxWidth - 8.w) / 2;
        } else {
          itemWidth = (constraints.maxWidth - 24.w) / 4;
        }

        return Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: ApiQuestionType.values.map((type) {
              final isSelected = value == type;
              return SizedBox(
                height: 30.h,
                child: Material(
                  color: isSelected
                      ? colorScheme.primaryContainer
                      : colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  child: InkWell(
                    onTap: () => onChanged(type),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.primary.withValues(alpha: 0.3),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 4.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isSelected ? Icons.check : _iconFor(type),
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                            size: 20.r,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            type.label(context),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? colorScheme.primary
                                      : colorScheme.onSurfaceVariant,
                                  fontSize: 11.sp,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class ChoicesSection extends StatelessWidget {
  const ChoicesSection({
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.option5,
    required this.explanation1,
    required this.explanation2,
    required this.explanation3,
    required this.explanation4,
    required this.explanation5,
    required this.correctOptions,
    required this.multiple,
    required this.onToggleCorrect,
    required this.onMultipleChanged,
    super.key,
  });

  final TextEditingController option1;
  final TextEditingController option2;
  final TextEditingController option3;
  final TextEditingController option4;
  final TextEditingController option5;
  final TextEditingController explanation1;
  final TextEditingController explanation2;
  final TextEditingController explanation3;
  final TextEditingController explanation4;
  final TextEditingController explanation5;
  final List<int> correctOptions;
  final bool multiple;
  final ValueChanged<int> onToggleCorrect;
  final ValueChanged<bool> onMultipleChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(context.l10n.questionMultipleCorrect),
          value: multiple,
          onChanged: onMultipleChanged,
        ),
        SizedBox(height: 8.h),
        OptionTile(
          index: 1,
          controller: option1,
          explanationController: explanation1,
          isCorrect: correctOptions.contains(1),
          onToggle: () => onToggleCorrect(1),
        ),
        OptionTile(
          index: 2,
          controller: option2,
          explanationController: explanation2,
          isCorrect: correctOptions.contains(2),
          onToggle: () => onToggleCorrect(2),
        ),
        OptionTile(
          index: 3,
          controller: option3,
          explanationController: explanation3,
          isCorrect: correctOptions.contains(3),
          onToggle: () => onToggleCorrect(3),
        ),
        OptionTile(
          index: 4,
          controller: option4,
          explanationController: explanation4,
          isCorrect: correctOptions.contains(4),
          onToggle: () => onToggleCorrect(4),
        ),
        OptionTile(
          index: 5,
          controller: option5,
          explanationController: explanation5,
          isCorrect: correctOptions.contains(5),
          onToggle: () => onToggleCorrect(5),
        ),
      ],
    );
  }
}

class OptionTile extends StatelessWidget {
  const OptionTile({
    required this.index,
    required this.controller,
    required this.explanationController,
    required this.isCorrect,
    required this.onToggle,
    super.key,
  });

  final int index;
  final TextEditingController controller;
  final TextEditingController explanationController;
  final bool isCorrect;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isCorrect
              ? colorScheme.primary
              : colorScheme.outlineVariant.withValues(alpha: 0.4),
          width: isCorrect ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isCorrect ? Icons.check_circle : Icons.circle_outlined,
                    color: isCorrect
                        ? colorScheme.primary
                        : colorScheme.outline,
                  ),
                  onPressed: onToggle,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: '${context.l10n.questionOptionLabel} $index',
                      filled: true,
                      fillColor: colorScheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: colorScheme.outlineVariant.withValues(
                            alpha: 0.4,
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: colorScheme.outlineVariant.withValues(
                            alpha: 0.4,
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(
              height: 1,
              color: colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: explanationController,
              decoration: InputDecoration(
                labelText: '${context.l10n.questionExplanationLabel} $index',
                filled: true,
                fillColor: colorScheme.surfaceContainerLow,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                isDense: true,
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class UserInputSection extends StatelessWidget {
  const UserInputSection({
    required this.possibility1,
    required this.possibility2,
    required this.possibility3,
    required this.possibility4,
    required this.possibility5,
    super.key,
  });

  final TextEditingController possibility1;
  final TextEditingController possibility2;
  final TextEditingController possibility3;
  final TextEditingController possibility4;
  final TextEditingController possibility5;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.questionPossibilitiesLabel,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12.h),
        _PossibilityField(index: 1, controller: possibility1),
        SizedBox(height: 8.h),
        _PossibilityField(index: 2, controller: possibility2),
        SizedBox(height: 8.h),
        _PossibilityField(index: 3, controller: possibility3),
        SizedBox(height: 8.h),
        _PossibilityField(index: 4, controller: possibility4),
        SizedBox(height: 8.h),
        _PossibilityField(index: 5, controller: possibility5),
      ],
    );
  }
}

class _PossibilityField extends StatelessWidget {
  const _PossibilityField({required this.index, required this.controller});

  final int index;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: BorderDirectional(
                end: BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
            ),
            child: Text(
              '$index',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '${context.l10n.questionPossibility} $index',
                filled: true,
                fillColor: colorScheme.surfaceContainerLow,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OpenEndedHint extends StatelessWidget {
  const OpenEndedHint({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: colorScheme.onSurfaceVariant,
            size: 20.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              context.l10n.questionOpenEndedHint,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FileUploadHint extends StatelessWidget {
  const FileUploadHint({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.upload_file_outlined,
            color: colorScheme.onSurfaceVariant,
            size: 20.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              context.l10n.questionFileUploadHint,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
