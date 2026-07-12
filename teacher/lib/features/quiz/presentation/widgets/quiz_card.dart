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

  final QuizSummaryModel quiz;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    DateTime? creationDate;
    if (quiz.creation != null) {
      creationDate = DateTime.tryParse(quiz.creation!);
    }

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
          Container(height: 3.h, color: AppColors.primary),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          quiz.title,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
                  Row(
                    children: [
                      if (creationDate != null) ...[
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 14.r,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          DateFormat.yMMMd().format(creationDate),
                          style: textTheme.bodySmall,
                        ),
                        SizedBox(width: 12.w),
                      ],
                      if (quiz.duration != null &&
                          quiz.duration!.isNotEmpty) ...[
                        Icon(
                          Icons.access_time,
                          size: 14.r,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${quiz.duration} min',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const Divider(),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.quizPassingPercentage,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${quiz.passingPercentage}%',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
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
                        context.l10n.quizMaxAttempts,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        quiz.maxAttempts > 0
                            ? quiz.maxAttempts.toString()
                            : context
                                  .l10n
                                  .quizMaxAttemptsUnlimited, // NOTE: Need to verify if this string exists, if not we'll use 'Unlimited' directly or add it. Let's use 'Unlimited' as fallback if not. Actually let's just use string literal for now to avoid ARB issues, or add it later.
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.neutral,
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
