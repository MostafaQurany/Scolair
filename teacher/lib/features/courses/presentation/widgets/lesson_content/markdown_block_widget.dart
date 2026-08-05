import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class MarkdownBlockWidget extends StatelessWidget {
  const MarkdownBlockWidget({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) => MarkdownBody(
      data: text,
      selectable: true,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
    );
}
