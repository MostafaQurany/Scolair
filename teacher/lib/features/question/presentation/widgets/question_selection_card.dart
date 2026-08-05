import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../quiz/data/models/quiz_models.dart';
import 'question_type_badge.dart';

class QuestionSelectionCard extends StatelessWidget {
  const QuestionSelectionCard({
    required this.question,
    required this.isSelected,
    required this.onTap,
    this.disabledReason,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final QuestionModel question;
  final bool isSelected;
  final VoidCallback onTap;
  final String? disabledReason;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  bool get _isDisabled => disabledReason != null;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Opacity(
      opacity: _isDisabled ? 0.62 : 1,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: !isSelected
              ? BorderDirectional(
                  end: BorderSide(
                    color: colorScheme.primary.withValues(alpha: 0.5),
                  ),
                  bottom: BorderSide(
                    color: colorScheme.primary.withValues(alpha: 0.5),
                  ),
                )
              : Border.all(color: colorScheme.primary, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: _isDisabled ? null : onTap,
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isSelected,
                    onChanged: _isDisabled ? null : (_) => onTap(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            QuestionTypeBadge(type: question.type),
                            SizedBox(width: 8.w),
                            Text(
                              question.name,
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const Spacer(),
                            if (onEdit != null || onDelete != null)
                              _ActionsMenu(onEdit: onEdit, onDelete: onDelete),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          question.question,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (disabledReason != null) ...[
                          SizedBox(height: 8.h),
                          Text(
                            disabledReason!,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.error,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionsMenu extends StatelessWidget {
  const _ActionsMenu({this.onEdit, this.onDelete});

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) => PopupMenuButton<_QuestionAction>(
      itemBuilder: (context) => [
        if (onEdit != null)
          PopupMenuItem(
            value: _QuestionAction.edit,
            child: Text(context.l10n.edit),
          ),
        if (onDelete != null)
          PopupMenuItem(
            value: _QuestionAction.delete,
            child: Text(context.l10n.delete),
          ),
      ],
      onSelected: (action) {
        switch (action) {
          case _QuestionAction.edit:
            onEdit?.call();
          case _QuestionAction.delete:
            onDelete?.call();
        }
      },
    );
}

enum _QuestionAction { edit, delete }
