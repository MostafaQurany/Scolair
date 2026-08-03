import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../../../core/constants/app_route_names.dart';
import '../../../../../core/localization/localization_extension.dart';

class QuizBlockWidget extends StatelessWidget {
  const QuizBlockWidget({
    required this.quizName,
    this.onRemoveQuiz,
    super.key,
  });

  final String quizName;
  final VoidCallback? onRemoveQuiz;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shadowColor: Colors.deepPurple.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: Colors.deepPurple.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.quiz, color: Colors.deepPurple),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.interactiveAssessment,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        quizName,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRouteNames.quizDetails,
                        arguments: quizName,
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: Text(context.l10n.edit),
                  ),
                ),
                if (onRemoveQuiz != null) ...[
                  SizedBox(width: 12.w),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _confirmRemove(context),
                      icon: const Icon(Icons.delete_outline),
                      label: Text(context.l10n.delete),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.error,
                        side: BorderSide(color: colorScheme.error),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmRemove(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.confirmRemoveQuizFromLessonTitle),
        content: Text(context.l10n.confirmRemoveQuizFromLesson),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              onRemoveQuiz?.call();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
  }
}
