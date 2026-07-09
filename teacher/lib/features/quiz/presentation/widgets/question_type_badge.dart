import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';

class QuestionTypeBadge extends StatelessWidget {
  const QuestionTypeBadge({required this.type, super.key});

  final ApiQuestionType type;

  Color _typeColor() => switch (type) {
    ApiQuestionType.choices => AppColors.success,
    ApiQuestionType.userInput => AppColors.info,
    ApiQuestionType.openEnded => AppColors.warning,
  };

  String _typeLabel(BuildContext context) => switch (type) {
    ApiQuestionType.choices => context.l10n.questionTypeChoices,
    ApiQuestionType.userInput => context.l10n.questionTypeUserInput,
    ApiQuestionType.openEnded => context.l10n.questionTypeOpenEnded,
  };

  @override
  Widget build(BuildContext context) {
    final color = _typeColor();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        _typeLabel(context),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
