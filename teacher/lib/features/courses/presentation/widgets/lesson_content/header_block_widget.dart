import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'lesson_content_helpers.dart';

class HeaderBlockWidget extends StatelessWidget {
  const HeaderBlockWidget({required this.text, required this.level, super.key});

  final String text;
  final int level;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    TextStyle? style;

    switch (level) {
      case 1:
        style = textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold);
        break;
      case 2:
        style = textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold);
        break;
      case 3:
        style = textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold);
        break;
      default:
        style = textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
        break;
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
      child: Text(LessonContentHelpers.stripHtml(text), style: style),
    );
  }
}
