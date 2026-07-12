import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/homework_models.dart';

class HomeworkCard extends StatelessWidget {
  const HomeworkCard({
    required this.homework,
    this.onEdit,
    this.onDuplicate,
    this.onDelete,
    super.key,
  });

  final HomeworkModel homework;
  final VoidCallback? onEdit;
  final VoidCallback? onDuplicate;
  final VoidCallback? onDelete;

  Color _subjectColor(ColorScheme colorScheme) {
    final palette = [
      colorScheme.primary,
      colorScheme.tertiary,
      colorScheme.secondary,
    ];
    final index = homework.subject.hashCode.abs() % palette.length;
    return palette[index];
  }

  bool get _isDueToday {
    final now = DateTime.now();
    return homework.dueDateTime.year == now.year &&
        homework.dueDateTime.month == now.month &&
        homework.dueDateTime.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final progress = homework.totalStudents == 0
        ? 0.0
        : homework.submittedCount / homework.totalStudents;

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
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
          Container(height: 3.h, color: _subjectColor(colorScheme)),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      homework.subject,
                      style: textTheme.labelMedium?.copyWith(
                        color: _subjectColor(colorScheme),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        size: 20.r,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      padding: EdgeInsets.zero,
                      onSelected: (value) {
                        if (value == 'edit') onEdit?.call();
                        if (value == 'duplicate') onDuplicate?.call();
                        if (value == 'delete') onDelete?.call();
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text(context.l10n.edit),
                        ),
                        PopupMenuItem(
                          value: 'duplicate',
                          child: Text(context.l10n.duplicate),
                        ),
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
                SizedBox(height: 6.h),
                Text(
                  homework.title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.event_outlined,
                      size: 14.r,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      _isDueToday
                          ? context.l10n.homeworkDueToday(
                              DateFormat.jm().format(homework.dueDateTime),
                            )
                          : context.l10n.homeworkDueOn(
                              DateFormat.yMMMd().add_jm().format(
                                homework.dueDateTime,
                              ),
                            ),
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6.h,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  context.l10n.homeworkSubmissionProgress(
                    homework.submittedCount,
                    homework.totalStudents,
                  ),
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit_outlined, size: 16),
                        label: Text(context.l10n.edit),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onDuplicate,
                        icon: const Icon(Icons.copy_outlined, size: 16),
                        label: Text(context.l10n.duplicate),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
