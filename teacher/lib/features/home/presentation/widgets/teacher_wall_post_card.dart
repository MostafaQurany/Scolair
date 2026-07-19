import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../domain/entities/teacher_wall_post.dart';
import 'wall_post_attachment_view.dart';
import 'wall_post_body.dart';
import 'wall_post_engagement_bar.dart';
import 'wall_post_header.dart';

class TeacherWallPostCard extends StatelessWidget {
  const TeacherWallPostCard({
    required this.post,
    required this.onLike,
    required this.onEdit,
    required this.onDelete,
    required this.onPin,
    required this.onReport,
    required this.onModerate,
    required this.onCopyText,
    super.key,
  });

  final TeacherWallPost post;
  final VoidCallback onLike;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onPin;
  final VoidCallback onReport;
  final VoidCallback onModerate;
  final VoidCallback onCopyText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsetsDirectional.only(bottom: 12.h, start: 16.w, end: 16.w),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          width: 1.r,
        ),
      ),
      color: colorScheme.surface,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WallPostHeader(
              post: post,
              onEdit: onEdit,
              onDelete: () => _showDeleteConfirmation(context),
              onPin: onPin,
              onReport: onReport,
              onModerate: onModerate,
              onCopyText: onCopyText,
            ),
            SizedBox(height: 12.h),
            WallPostBody(
              key: ValueKey(post.id),
              body: post.body,
              hashtags: post.hashtags,
            ),
            if (post.attachment != null) ...[
              SizedBox(height: 12.h),
              WallPostAttachmentView(attachment: post.attachment!),
            ],
            SizedBox(height: 12.h),
            WallPostEngagementBar(
              likeCount: post.likeCount,
              commentCount: post.commentCount,
              isLiked: post.isLikedByCurrentUser,
              onLikeTapped: onLike,
              onCommentTapped: () {
                Navigator.pushNamed(
                  context,
                  AppRouteNames.wallPostComments,
                  arguments: post.id,
                );
              },
              onShareTapped: onCopyText,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(dialogContext.l10n.postDeleteConfirmTitle),
          content: Text(dialogContext.l10n.postDeleteConfirmBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(dialogContext.l10n.back),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                onDelete();
              },
              child: Text(
                dialogContext.l10n.postDeleteConfirmAction,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }
}
