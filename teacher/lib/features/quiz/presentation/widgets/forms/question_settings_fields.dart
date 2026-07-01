import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../../data/models/quiz_models.dart';

class QuestionTypeAndTextFields extends StatelessWidget {
  const QuestionTypeAndTextFields({
    required this.type,
    required this.onTypeChanged,
    required this.textController,
    super.key,
  });

  final QuestionType type;
  final ValueChanged<QuestionType> onTypeChanged;
  final TextEditingController textController;

  String _typeLabel(BuildContext context, QuestionType value) =>
      switch (value) {
        QuestionType.multipleChoice => context.l10n.questionTypeMultipleChoice,
        QuestionType.trueFalse => context.l10n.questionTypeTrueFalse,
        QuestionType.shortAnswer => context.l10n.questionTypeShortAnswer,
        QuestionType.essay => context.l10n.questionTypeEssay,
        QuestionType.fillBlank => context.l10n.questionTypeFillBlank,
        QuestionType.matching => context.l10n.questionTypeMatching,
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<QuestionType>(
          initialValue: type,
          decoration: InputDecoration(
            labelText: context.l10n.questionTypeLabel,
          ),
          items: QuestionType.values
              .map(
                (value) => DropdownMenuItem(
                  value: value,
                  child: Text(_typeLabel(context, value)),
                ),
              )
              .toList(),
          onChanged: (value) => onTypeChanged(value!),
        ),
        SizedBox(height: 16.h),
        TextFormField(
          controller: textController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: context.l10n.questionTextLabel,
            hintText: context.l10n.questionTextHint,
          ),
          validator: (value) => value == null || value.trim().isEmpty
              ? context.l10n.questionTextRequired
              : null,
        ),
      ],
    );
  }
}

class QuestionSettingsFields extends StatelessWidget {
  const QuestionSettingsFields({
    required this.pointsController,
    required this.difficulty,
    required this.onDifficultyChanged,
    required this.required,
    required this.onRequiredChanged,
    super.key,
  });

  final TextEditingController pointsController;
  final QuestionDifficulty difficulty;
  final ValueChanged<QuestionDifficulty> onDifficultyChanged;
  final bool required;
  final ValueChanged<bool> onRequiredChanged;

  String _label(BuildContext context, QuestionDifficulty value) =>
      switch (value) {
        QuestionDifficulty.easy => context.l10n.questionDifficultyEasy,
        QuestionDifficulty.medium => context.l10n.questionDifficultyMedium,
        QuestionDifficulty.hard => context.l10n.questionDifficultyHard,
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: pointsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: context.l10n.questionPointsFieldLabel,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: DropdownButtonFormField<QuestionDifficulty>(
                initialValue: difficulty,
                decoration: InputDecoration(
                  labelText: context.l10n.questionDifficultyFieldLabel,
                ),
                items: QuestionDifficulty.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_label(context, value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) => onDifficultyChanged(value!),
              ),
            ),
          ],
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(context.l10n.questionRequiredLabel),
          value: required,
          onChanged: onRequiredChanged,
        ),
      ],
    );
  }
}
