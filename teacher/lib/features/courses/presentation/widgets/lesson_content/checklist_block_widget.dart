import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'lesson_content_helpers.dart';

class ChecklistBlockWidget extends StatelessWidget {
  const ChecklistBlockWidget({required this.items, super.key});

  final List<dynamic> items;

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        final item = items[index] as Map<String, dynamic>;
        final text = item['text'] as String? ?? '';
        final checked = item['checked'] as bool? ?? false;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                checked ? Icons.check_box : Icons.check_box_outline_blank,
                size: 20.r,
                color: checked
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
              ),
              SizedBox(width: 10.w),
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
    );
}
