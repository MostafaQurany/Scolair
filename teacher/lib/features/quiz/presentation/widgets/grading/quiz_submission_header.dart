import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../data/models/quiz_submission_models.dart';

class QuizSubmissionHeader extends StatelessWidget {
  const QuizSubmissionHeader({required this.submission, super.key});

  final QuizSubmissionItemModel submission;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(16.r),
      color: colors.surfaceContainerLowest,
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: colors.primaryContainer,
            child: Text(
              submission.memberName.isNotEmpty
                  ? submission.memberName[0].toUpperCase()
                  : '?',
              style: TextStyle(
                color: colors.onPrimaryContainer,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  submission.memberName,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  submission.creation,
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${submission.score} / ${submission.scoreOutOf}',
                style: textTheme.titleMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${submission.percentage.toStringAsFixed(1)}%',
                style: textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
