import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../quiz/data/models/quiz_models.dart';
import 'question_type_label.dart';

class QuestionTypeBadge extends StatelessWidget {
  const QuestionTypeBadge({required this.type, super.key});

  final ApiQuestionType type;

  Color _typeColor(ColorScheme colorScheme) {
    return switch (type) {
      ApiQuestionType.choices => colorScheme.primary,
      ApiQuestionType.userInput => colorScheme.tertiary,
      ApiQuestionType.openEnded => colorScheme.secondary,
      ApiQuestionType.fileUpload => colorScheme.error,
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = _typeColor(Theme.of(context).colorScheme);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        type.label(context),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
