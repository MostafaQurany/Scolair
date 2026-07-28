import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/utils/app_date_time_formatter.dart';
import '../../domain/entities/homework_list_item.dart';

class HomeworkCard extends StatelessWidget {
  const HomeworkCard({
    required this.homework,
    required this.onViewDetails,
    required this.onDelete,
    this.onEdit,
    this.isDeleting = false,
    super.key,
  });

  final HomeworkListItem homework;
  final VoidCallback onViewDetails;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;
  final bool isDeleting;

  String _plainInstructions(String value) => value
      .replaceAll(RegExp(r'<[^>]*>'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final instructions = _plainInstructions(homework.instructions);
    final course = homework.course.isEmpty
        ? context.l10n.homeworkNoCourse
        : homework.course;
    final title = homework.title.isEmpty
        ? context.l10n.homeworkUntitled
        : homework.title;
    final dueDate = homework.dueDate;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: BorderDirectional(
          bottom: BorderSide(color: colors.primary, width: 1),
          end: BorderSide(color: colors.primary, width: 1),
        ),
      ),
      padding: EdgeInsets.all(1),
      child: Card(
        child: InkWell(
          onTap: isDeleting ? null : onViewDetails,
          child: Padding(
            padding: EdgeInsetsDirectional.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      enabled: !isDeleting,
                      onSelected: (action) {
                        if (action == 'view') onViewDetails();
                        if (action == 'edit') onEdit?.call();
                        if (action == 'delete') onDelete();
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'view',
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.visibility_outlined),
                            title: Text(context.l10n.homeworkViewDetails),
                          ),
                        ),
                        if (onEdit != null)
                          PopupMenuItem<String>(
                            value: 'edit',
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.edit_outlined),
                              title: Text(context.l10n.edit),
                            ),
                          ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.delete_outline,
                              color: colors.error,
                            ),
                            title: Text(
                              context.l10n.delete,
                              style: TextStyle(color: colors.error),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                if (instructions.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(
                    instructions,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
                SizedBox(height: 14.h),
                _MetadataRow(
                  icon: Icons.event_outlined,
                  label: dueDate == null
                      ? context.l10n.homeworkNoDueDate
                      : context.l10n.homeworkDueOn(
                          AppDateTimeFormatter.formatDateTime(
                            dueDate,
                            locale: Localizations.localeOf(
                              context,
                            ).toLanguageTag(),
                          ),
                        ),
                ),
                SizedBox(height: 6.h),
                _MetadataRow(
                  icon: Icons.grade_outlined,
                  label: context.l10n.questionPointsLabel(homework.maxMarks),
                ),
                if (homework.allowLateSubmission) ...[
                  SizedBox(height: 6.h),
                  _MetadataRow(
                    icon: Icons.schedule_outlined,
                    label: context.l10n.homeworkLateAllowed,
                  ),
                ],
                if (homework.attachment != null) ...[
                  SizedBox(height: 6.h),
                  _MetadataRow(
                    icon: Icons.attach_file,
                    label: context.l10n.homeworkAttachmentAvailable,
                  ),
                ],
                SizedBox(height: 16.h),

                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Chip(
                    visualDensity: VisualDensity.compact,
                    avatar: isDeleting
                        ? SizedBox.square(
                            dimension: 14.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : null,
                    label: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 220.w),
                      child: Text(
                        course,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MetadataRow extends StatelessWidget {
  const _MetadataRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(
        icon,
        size: 18.r,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      SizedBox(width: 8.w),
      Expanded(
        child: Text(label, style: Theme.of(context).textTheme.bodySmall),
      ),
    ],
  );
}
