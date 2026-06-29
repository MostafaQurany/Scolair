import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'lesson_content_helpers.dart';

class QuoteBlockWidget extends StatelessWidget {
  const QuoteBlockWidget({
    required this.text,
    this.caption,
    this.alignment = 'left',
    super.key,
  });

  final String text;
  final String? caption;
  final String alignment;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCenter = alignment == 'center';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: BorderDirectional(
          start: isCenter
              ? BorderSide.none
              : BorderSide(color: colorScheme.primary, width: 4.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: isCenter
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: isCenter ? TextAlign.center : TextAlign.start,
            text: TextSpan(
              children: LessonContentHelpers.parseHtmlToSpans(context, text),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
            ),
          ),
          if (caption != null && caption!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              '— ${LessonContentHelpers.stripHtml(caption!)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.outline,
                fontWeight: FontWeight.bold,
              ),
              textAlign: isCenter ? TextAlign.center : TextAlign.start,
            ),
          ],
        ],
      ),
    );
  }
}
