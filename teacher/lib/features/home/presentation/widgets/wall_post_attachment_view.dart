import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/widgets/app_cached_network_image.dart';
import '../../domain/entities/teacher_wall_post.dart';

class WallPostAttachmentView extends StatelessWidget {
  const WallPostAttachmentView({required this.attachment, super.key});

  final WallPostAttachment attachment;

  @override
  Widget build(BuildContext context) {
    if (attachment.type != WallPostAttachmentType.image) {
      // Safe placeholder fallback for non-image attachments
      return Container(
        padding: EdgeInsetsDirectional.all(12.r),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.insert_drive_file_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                attachment.title ?? 'Attachment',
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    final ratio = attachment.aspectRatio ?? (16 / 9);

    return AspectRatio(
      aspectRatio: ratio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: AppCachedNetworkImage(
          imageUrl: attachment.url,
          errorWidget: ColoredBox(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: Theme.of(context).colorScheme.outlineVariant,
                size: 28.r,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
