import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'lesson_content_helpers.dart';

class ListBlockWidget extends StatelessWidget {
  const ListBlockWidget({required this.style, required this.items, super.key});

  final String style;
  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    final isOrdered = style == 'ordered';
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 8.w, top: 4.h, bottom: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final text = item is String ? item : item.toString();

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24.w,
                  child: Text(
                    isOrdered ? '${index + 1}.' : '•',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: LessonContentHelpers.parseHtmlToSpans(
                        context,
                        text,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
