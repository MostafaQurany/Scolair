import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/quiz_models.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({
    required this.quiz,
    this.onTap,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final QuizModel quiz;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  Color get _accentColor => quiz.resultStatus == QuizResultStatus.needsGrading
      ? AppColors.warning
      : quiz.timelineStatus == QuizTimelineStatus.upcoming
      ? AppColors.primary
      : AppColors.neutral;

  String _typeLabel(BuildContext context) => switch (quiz.type) {
    QuizType.quiz => context.l10n.quizTypeQuiz,
    QuizType.midterm => context.l10n.quizTypeMidterm,
    QuizType.final_ => context.l10n.quizTypeFinal,
  };

  String _timelineLabel(BuildContext context) =>
      quiz.timelineStatus == QuizTimelineStatus.upcoming
      ? context.l10n.quizTimelineUpcoming
      : context.l10n.quizTimelinePast;

  String _resultLabel(BuildContext context) => switch (quiz.resultStatus) {
    QuizResultStatus.pending => context.l10n.quizResultPending,
    QuizResultStatus.graded => context.l10n.quizResultGraded(
      quiz.gradedCount,
      quiz.submittedCount,
    ),
    QuizResultStatus.needsGrading => context.l10n.quizResultNeedsGrading(
      quiz.gradedCount,
      quiz.submittedCount,
    ),
  };

  Color _resultColor() => switch (quiz.resultStatus) {
    QuizResultStatus.pending => AppColors.warning,
    QuizResultStatus.graded => AppColors.success,
    QuizResultStatus.needsGrading => AppColors.warning,
  };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: 3.h, color: _accentColor),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          _typeLabel(context),
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (onEdit != null || onDelete != null)
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            size: 20.r,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          padding: EdgeInsets.zero,
                          onSelected: (value) {
                            if (value == 'edit') onEdit?.call();
                            if (value == 'delete') onDelete?.call();
                          },
                          itemBuilder: (context) => [
                            if (onEdit != null)
                              PopupMenuItem(
                                value: 'edit',
                                child: Text(context.l10n.edit),
                              ),
                            if (onDelete != null)
                              PopupMenuItem(
                                value: 'delete',
                                child: Text(
                                  context.l10n.delete,
                                  style: TextStyle(color: colorScheme.error),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    quiz.title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (quiz.description != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      quiz.description!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.r,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        DateFormat.yMMMd().format(quiz.startDateTime),
                        style: textTheme.bodySmall,
                      ),
                      SizedBox(width: 12.w),
                      Icon(
                        Icons.access_time,
                        size: 14.r,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        DateFormat.jm().format(quiz.startDateTime),
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const Divider(),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.quizTimelineStatusLabel,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        _timelineLabel(context),
                        style: textTheme.bodySmall?.copyWith(
                          color:
                              quiz.timelineStatus == QuizTimelineStatus.upcoming
                              ? AppColors.primary
                              : AppColors.neutral,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.quizResultStatusLabel,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        _resultLabel(context),
                        style: textTheme.bodySmall?.copyWith(
                          color: _resultColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
