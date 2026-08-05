import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'frappe_file_url_resolver.dart';
import 'lesson_content_helpers.dart';

class ImageBlockWidget extends StatelessWidget {
  const ImageBlockWidget({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    String? imageUrl;
    final fileObj = data['file'];
    if (fileObj is Map<String, dynamic>) {
      imageUrl = fileObj['url'] as String?;
    }
    imageUrl ??= data['url'] as String?;

    if (imageUrl == null || imageUrl.isEmpty) {
      return const SizedBox.shrink();
    }

    final resolvedUrl = FrappeFileUrlResolver.resolve(imageUrl);
    final caption = data['caption'] as String? ?? '';
    final withBorder = data['withBorder'] as bool? ?? false;
    final withBackground = data['withBackground'] as bool? ?? false;
    final stretched = data['stretched'] as bool? ?? false;

    Widget imageWidget = CachedNetworkImage(
      imageUrl: resolvedUrl,
      fit: stretched ? BoxFit.cover : BoxFit.contain,
      placeholder: (context, url) => Container(
        height: 200.h,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        height: 200.h,
        color: Theme.of(context).colorScheme.errorContainer,
        child: Icon(
          Icons.broken_image,
          color: Theme.of(context).colorScheme.error,
          size: 40.r,
        ),
      ),
    );

    if (withBorder) {
      imageWidget = DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: imageWidget,
      );
    }

    if (withBackground) {
      imageWidget = Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        padding: EdgeInsets.all(16.r),
        child: Center(child: imageWidget),
      );
    }

    return Column(
      crossAxisAlignment: stretched
          ? CrossAxisAlignment.stretch
          : CrossAxisAlignment.center,
      children: [
        imageWidget,
        if (caption.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Text(
            LessonContentHelpers.stripHtml(caption),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
