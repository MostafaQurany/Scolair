import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/localization/localization_extension.dart';
import '../../../../../core/widgets/app_snack_bar.dart';

/// Shared helpers for rendering Editor.js inline HTML content.
class LessonContentHelpers {
  const LessonContentHelpers._();

  /// Strips all HTML tags and decodes common entities.
  static String stripHtml(String htmlString) {
    var text = htmlString;
    text = text.replaceAll('&nbsp;', ' ');
    text = text.replaceAll('&amp;', '&');
    text = text.replaceAll('&lt;', '<');
    text = text.replaceAll('&gt;', '>');
    text = text.replaceAll('&quot;', '"');
    text = text.replaceAll('&#39;', "'");
    final exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return text.replaceAll(exp, '');
  }

  /// Parses inline HTML tags (<b>, <i>, <u>, <a>, <br>, <mark>,
  /// <code>) into Flutter [InlineSpan] widgets.
  static List<InlineSpan> parseHtmlToSpans(BuildContext context, String html) {
    final List<InlineSpan> spans = [];
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final regex = RegExp(
      r'(<br\s*/?>)'
      r'|(<b>|<strong>)(.*?)(</b>|</strong>)'
      r'|(<i>|<em>)(.*?)(</i>|</em>)'
      r'|(<u>)(.*?)(</u>)'
      r'|(<mark>)(.*?)(</mark>)'
      r'|(<code>)(.*?)(</code>)'
      r'|<a\s+href="([^"]+)"[^>]*>(.*?)</a>'
      r'|([^<]+)',
      caseSensitive: false,
    );

    final matches = regex.allMatches(html);

    for (final match in matches) {
      if (match.group(1) != null) {
        spans.add(const TextSpan(text: '\n'));
      } else if (match.group(2) != null) {
        spans.add(
          TextSpan(
            text: stripHtml(match.group(3) ?? ''),
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        );
      } else if (match.group(5) != null) {
        spans.add(
          TextSpan(
            text: stripHtml(match.group(6) ?? ''),
            style: textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
          ),
        );
      } else if (match.group(8) != null) {
        spans.add(
          TextSpan(
            text: stripHtml(match.group(9) ?? ''),
            style: textTheme.bodyLarge?.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        );
      } else if (match.group(11) != null) {
        spans.add(
          TextSpan(
            text: stripHtml(match.group(12) ?? ''),
            style: textTheme.bodyLarge?.copyWith(
              backgroundColor: Colors.yellow.withValues(alpha: 0.3),
            ),
          ),
        );
      } else if (match.group(14) != null) {
        spans.add(
          TextSpan(
            text: stripHtml(match.group(15) ?? ''),
            style: textTheme.bodyLarge?.copyWith(
              fontFamily: 'monospace',
              backgroundColor: colorScheme.surfaceContainerHighest,
            ),
          ),
        );
      } else if (match.group(16) != null) {
        final href = match.group(16)!;
        final linkText = stripHtml(match.group(17) ?? '');
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: href));
                AppSnackBar.showSuccess(context, context.l10n.linkCopied);
              },
              child: Text(
                linkText,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        );
      } else if (match.group(18) != null) {
        spans.add(
          TextSpan(
            text: match.group(18),
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          ),
        );
      }
    }

    if (spans.isEmpty && html.isNotEmpty) {
      spans.add(
        TextSpan(
          text: stripHtml(html),
          style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
        ),
      );
    }

    return spans;
  }
}
