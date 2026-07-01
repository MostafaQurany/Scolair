import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';

class QuestionTypeBadge extends StatelessWidget {
  const QuestionTypeBadge({required this.type, super.key});

  final QuestionType type;

  String _label(BuildContext context) => switch (type) {
    QuestionType.multipleChoice => context.l10n.questionTypeMultipleChoice,
    QuestionType.trueFalse => context.l10n.questionTypeTrueFalse,
    QuestionType.shortAnswer => context.l10n.questionTypeShortAnswer,
    QuestionType.essay => context.l10n.questionTypeEssay,
    QuestionType.fillBlank => context.l10n.questionTypeFillBlank,
    QuestionType.matching => context.l10n.questionTypeMatching,
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        _label(context),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
