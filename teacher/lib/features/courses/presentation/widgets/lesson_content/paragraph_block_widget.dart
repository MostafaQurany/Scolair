import 'package:flutter/material.dart';
import 'lesson_content_helpers.dart';

class ParagraphBlockWidget extends StatelessWidget {
  const ParagraphBlockWidget({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: LessonContentHelpers.parseHtmlToSpans(context, text),
      ),
    );
  }
}
