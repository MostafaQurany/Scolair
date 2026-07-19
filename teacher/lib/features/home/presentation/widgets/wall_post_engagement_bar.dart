import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';

class WallPostEngagementBar extends StatelessWidget {
  const WallPostEngagementBar({
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.onLikeTapped,
    required this.onCommentTapped,
    required this.onShareTapped,
    super.key,
  });

  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final VoidCallback onLikeTapped;
  final VoidCallback onCommentTapped;
  final VoidCallback onShareTapped;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          height: 1.h,
          thickness: 1.h,
        ),
        Row(
          children: [
            Expanded(
              child: _EngagementButton(
                iconData: isLiked ? Icons.favorite : Icons.favorite_border,
                iconColor: isLiked ? Colors.red : colorScheme.outline,
                label: '$likeCount',
                onPressed: onLikeTapped,
              ),
            ),
            Expanded(
              child: _EngagementButton(
                iconData: Icons.chat_bubble_outline_outlined,
                iconColor: colorScheme.outline,
                label: '$commentCount',
                onPressed: onCommentTapped,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.share_outlined,
                color: colorScheme.outline,
                size: 20.r,
              ),
              tooltip: context.l10n.postShare,
              onPressed: onShareTapped,
            ),
          ],
        ),
      ],
    );
  }
}

class _EngagementButton extends StatelessWidget {
  const _EngagementButton({
    required this.iconData,
    required this.iconColor,
    required this.label,
    required this.onPressed,
  });

  final IconData iconData;
  final Color iconColor;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: iconColor, size: 20.r),
            SizedBox(width: 6.w),
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
