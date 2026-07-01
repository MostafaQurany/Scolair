import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';
import 'forms/question_option_tile.dart';

class QuestionTypeBody extends StatelessWidget {
  const QuestionTypeBody({
    required this.type,
    required this.optionControllers,
    required this.optionCorrect,
    required this.onAddOption,
    required this.onRemoveOption,
    required this.onSelectCorrectOption,
    required this.boolAnswer,
    required this.onBoolAnswerChanged,
    required this.acceptedAnswerController,
    super.key,
  });

  final QuestionType type;
  final List<TextEditingController> optionControllers;
  final List<bool> optionCorrect;
  final VoidCallback onAddOption;
  final ValueChanged<int> onRemoveOption;
  final ValueChanged<int> onSelectCorrectOption;
  final bool? boolAnswer;
  final ValueChanged<bool?> onBoolAnswerChanged;
  final TextEditingController acceptedAnswerController;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case QuestionType.multipleChoice:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < optionControllers.length; i++)
              QuestionOptionTile(
                label: context.l10n.questionOptionLabel(
                  String.fromCharCode(65 + i),
                ),
                controller: optionControllers[i],
                isCorrect: optionCorrect[i],
                onSelectCorrect: () => onSelectCorrectOption(i),
                onRemove: optionControllers.length > 2
                    ? () => onRemoveOption(i)
                    : null,
              ),
            TextButton.icon(
              onPressed: onAddOption,
              icon: const Icon(Icons.add),
              label: Text(context.l10n.questionAddOption),
            ),
          ],
        );
      case QuestionType.trueFalse:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.questionCorrectAnswerLabel),
            RadioGroup<bool>(
              groupValue: boolAnswer,
              onChanged: onBoolAnswerChanged,
              child: Column(
                children: [
                  RadioListTile<bool>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(context.l10n.questionTrue),
                    value: true,
                  ),
                  RadioListTile<bool>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(context.l10n.questionFalse),
                    value: false,
                  ),
                ],
              ),
            ),
          ],
        );
      case QuestionType.shortAnswer:
        return TextFormField(
          controller: acceptedAnswerController,
          decoration: InputDecoration(
            labelText: context.l10n.questionAcceptedAnswerLabel,
            hintText: context.l10n.questionAcceptedAnswerHint,
          ),
        );
      case QuestionType.essay:
        return _InfoBanner(message: context.l10n.questionEssayInfo);
      case QuestionType.fillBlank:
      case QuestionType.matching:
        return const SizedBox.shrink();
    }
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: colorScheme.primary, size: 18.r),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(message, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
