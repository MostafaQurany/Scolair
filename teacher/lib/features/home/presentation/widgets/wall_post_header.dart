import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/utils/app_date_time_formatter.dart';
import '../../../../core/widgets/app_user_avatar.dart';
import '../../domain/entities/teacher_wall_post.dart';

class WallPostHeader extends StatelessWidget {
  const WallPostHeader({
    required this.post,
    required this.onEdit,
    required this.onDelete,
    required this.onPin,
    required this.onReport,
    required this.onModerate,
    required this.onCopyText,
    super.key,
  });

  final TeacherWallPost post;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onPin;
  final VoidCallback onReport;
  final VoidCallback onModerate;
  final VoidCallback onCopyText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).languageCode;

    final formattedTime = AppDateTimeFormatter.formatRelativeTime(
      post.createdAt,
      locale: locale,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppUserAvatar(
          imageUrl: post.author.imageUrl,
          displayName: post.author.displayName,
          userId: post.author.id,
          radius: 18,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: post.author.displayName,
                            style: textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (post.isOwnedByCurrentUser) ...[
                            const TextSpan(text: ' '),
                            TextSpan(
                              text: context.l10n.postYouLabel,
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  _PostTypeBadge(post: post),
                  if (post.permissions.canModerate &&
                      !post.isOwnedByCurrentUser) ...[
                    SizedBox(width: 4.w),
                    const _ModerateBadge(),
                  ],
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                '$formattedTime • ${post.audience.label}',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ),
        _PopupMenu(
          post: post,
          onEdit: onEdit,
          onDelete: onDelete,
          onPin: onPin,
          onReport: onReport,
          onModerate: onModerate,
          onCopyText: onCopyText,
        ),
      ],
    );
  }
}

class _PostTypeBadge extends StatelessWidget {
  const _PostTypeBadge({required this.post});

  final TeacherWallPost post;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color badgeColor;
    Color textColor;
    String label;
    IconData? icon;

    if (post.isPinned) {
      badgeColor = colorScheme.primary;
      textColor = colorScheme.onPrimary;
      label = context.l10n.postTypeBadgePinned;
      icon = Icons.push_pin_outlined;
    } else {
      icon = null;
      switch (post.type) {
        case WallPostType.announcement:
          badgeColor = colorScheme.primaryContainer;
          textColor = colorScheme.onPrimaryContainer;
          label = context.l10n.postTypeBadgeAnnouncement;
          break;
        case WallPostType.question:
          badgeColor = colorScheme.tertiaryContainer;
          textColor = colorScheme.onTertiaryContainer;
          label = context.l10n.postTypeBadgeQuestion;
          break;
        case WallPostType.discussion:
          badgeColor = colorScheme.secondaryContainer;
          textColor = colorScheme.onSecondaryContainer;
          label = context.l10n.postTypeBadgeDiscussion;
          break;
        case WallPostType.resource:
          badgeColor = Colors.green.shade50;
          textColor = Colors.green.shade800;
          label = context.l10n.postTypeBadgeResource;
          break;
        case WallPostType.assignmentUpdate:
          badgeColor = Colors.orange.shade50;
          textColor = Colors.orange.shade800;
          label = context.l10n.postTypeBadgeAssignment;
          break;
        case WallPostType.quizUpdate:
          badgeColor = Colors.purple.shade50;
          textColor = Colors.purple.shade800;
          label = context.l10n.postTypeBadgeQuiz;
          break;
        case WallPostType.achievement:
          badgeColor = Colors.amber.shade100;
          textColor = Colors.amber.shade900;
          label = context.l10n.postTypeBadgeAchievement;
          break;
        case WallPostType.poll:
          badgeColor = Colors.teal.shade50;
          textColor = Colors.teal.shade800;
          label = context.l10n.postTypeBadgePoll;
          break;
        case WallPostType.systemUpdate:
          badgeColor = colorScheme.surfaceContainerHighest;
          textColor = colorScheme.onSurfaceVariant;
          label = context.l10n.postTypeBadgeSystem;
          break;
      }
    }

    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 10.r, color: textColor),
            SizedBox(width: 3.w),
          ],
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: textColor,
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModerateBadge extends StatelessWidget {
  const _ModerateBadge();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: colorScheme.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shield_outlined, size: 10.r, color: colorScheme.error),
          SizedBox(width: 3.w),
          Text(
            context.l10n.postModerateBadge.toUpperCase(),
            style: TextStyle(
              color: colorScheme.error,
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _PopupMenu extends StatelessWidget {
  const _PopupMenu({
    required this.post,
    required this.onEdit,
    required this.onDelete,
    required this.onPin,
    required this.onReport,
    required this.onModerate,
    required this.onCopyText,
  });

  final TeacherWallPost post;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onPin;
  final VoidCallback onReport;
  final VoidCallback onModerate;
  final VoidCallback onCopyText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_horiz_outlined,
        color: colorScheme.outline,
        size: 20.r,
      ),
      padding: EdgeInsets.zero,
      onSelected: (value) {
        switch (value) {
          case 'edit':
            onEdit();
            break;
          case 'delete':
            onDelete();
            break;
          case 'pin':
            onPin();
            break;
          case 'copy':
            onCopyText();
            break;
          case 'report':
            onReport();
            break;
          case 'moderate':
            onModerate();
            break;
        }
      },
      itemBuilder: (context) {
        final copyItem = PopupMenuItem(
          value: 'copy',
          child: Row(
            children: [
              const Icon(Icons.copy_outlined),
              SizedBox(width: 8.w),
              Text(context.l10n.postMenuCopyText),
            ],
          ),
        );

        if (post.isOwnedByCurrentUser) {
          return [
            copyItem,
            if (post.permissions.canEdit)
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    const Icon(Icons.edit_outlined),
                    SizedBox(width: 8.w),
                    Text(context.l10n.postMenuEdit),
                  ],
                ),
              ),
            if (post.permissions.canPin)
              PopupMenuItem(
                value: 'pin',
                child: Row(
                  children: [
                    Icon(
                      post.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      post.isPinned
                          ? context.l10n.postMenuUnpin
                          : context.l10n.postMenuPin,
                    ),
                  ],
                ),
              ),
            if (post.permissions.canDelete)
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: colorScheme.error),
                    SizedBox(width: 8.w),
                    Text(
                      context.l10n.postMenuDelete,
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ],
                ),
              ),
          ];
        } else {
          return [
            copyItem,
            if (post.permissions.canReport)
              PopupMenuItem(
                value: 'report',
                child: Row(
                  children: [
                    const Icon(Icons.report_problem_outlined),
                    SizedBox(width: 8.w),
                    Text(context.l10n.postMenuReport),
                  ],
                ),
              ),
            if (post.permissions.canModerate)
              PopupMenuItem(
                value: 'moderate',
                child: Row(
                  children: [
                    const Icon(Icons.shield_outlined),
                    SizedBox(width: 8.w),
                    Text(context.l10n.postMenuModerate),
                  ],
                ),
              ),
          ];
        }
      },
    );
  }
}
