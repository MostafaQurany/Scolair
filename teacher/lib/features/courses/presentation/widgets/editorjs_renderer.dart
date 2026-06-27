import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

class EditorJsRenderer extends StatelessWidget {
  const EditorJsRenderer({required this.content, super.key});

  final String? content;

  @override
  Widget build(BuildContext context) {
    if (content == null || content!.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    try {
      final Map<String, dynamic> json = jsonDecode(content!);
      final List<dynamic> blocks = json['blocks'] ?? [];

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: blocks.length,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final block = blocks[index] as Map<String, dynamic>;
          final type = block['type'] as String? ?? '';
          final data = block['data'] as Map<String, dynamic>? ?? {};

          switch (type) {
            case 'header':
              return _renderHeader(context, data);
            case 'paragraph':
              return _renderParagraph(context, data);
            case 'embed':
              return _renderEmbed(context, data);
            case 'codeBox':
              return _renderCodeBox(context, data);
            case 'upload':
              return _renderUpload(context, data);
            case 'quiz':
              return _renderQuiz(context, data);
            default:
              return _renderUnknown(context, type, data);
          }
        },
      );
    } catch (e) {
      // Fallback: If not valid JSON, render as plain HTML/text
      return _renderHtmlFallback(context, content!);
    }
  }

  Widget _renderHeader(BuildContext context, Map<String, dynamic> data) {
    final text = data['text'] as String? ?? '';
    final level = data['level'] as int? ?? 2;
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
      child: Text(
        _stripHtml(text),
        style: style,
      ),
    );
  }

  Widget _renderParagraph(BuildContext context, Map<String, dynamic> data) {
    final text = data['text'] as String? ?? '';
    return RichText(
      text: TextSpan(
        children: _parseHtmlToSpans(context, text),
      ),
    );
  }

  Widget _renderEmbed(BuildContext context, Map<String, dynamic> data) {
    final service = data['service'] as String? ?? '';
    final source = data['source'] as String? ?? '';
    final caption = data['caption'] as String? ?? '';
    final colorScheme = Theme.of(context).colorScheme;

    if (service == 'youtube') {
      return Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Video thumbnail placeholder
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.black87,
                    child: Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        color: Colors.redAccent,
                        size: 64.r,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.video_library, color: Colors.white, size: 14),
                        SizedBox(width: 4.w),
                        Text(
                          'YouTube',
                          style: TextStyle(color: Colors.white, fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    caption.isNotEmpty ? caption : 'YouTube Video Link',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          source,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.neutral,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: source));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Video link copied to clipboard')),
                          );
                        },
                        tooltip: 'Copy Video Link',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text('Embed source ($service): $source'),
    );
  }

  Widget _renderCodeBox(BuildContext context, Map<String, dynamic> data) {
    final code = data['code'] as String? ?? '';
    final language = data['language'] as String? ?? 'code';

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  language.toUpperCase(),
                  style: GoogleFonts.firaCode(
                    color: Colors.greenAccent,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Code copied to clipboard')),
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.copy, size: 14, color: Colors.white70),
                      SizedBox(width: 4.w),
                      Text(
                        'Copy',
                        style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                code,
                style: GoogleFonts.firaCode(
                  color: const Color(0xFFD4D4D4),
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderUpload(BuildContext context, Map<String, dynamic> data) {
    final fileUrl = data['file_url'] as String? ?? '';
    final fileType = data['file_type'] as String? ?? '';
    final colorScheme = Theme.of(context).colorScheme;

    final isPdf = fileType.toLowerCase() == 'pdf';
    final isVideo = ['mp4', 'mov', 'avi', 'mkv'].contains(fileType.toLowerCase());

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: isPdf
                    ? Colors.red.withOpacity(0.1)
                    : isVideo
                        ? Colors.blue.withOpacity(0.1)
                        : Colors.amber.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPdf
                    ? Icons.picture_as_pdf
                    : isVideo
                        ? Icons.play_circle
                        : Icons.insert_drive_file,
                color: isPdf
                    ? Colors.red
                    : isVideo
                        ? Colors.blue
                        : Colors.amber,
                size: 28.r,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileUrl.split('/').last,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    fileType.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.neutral,
                        ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: fileUrl));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('File URL copied: $fileUrl')),
                );
              },
              tooltip: 'Download File',
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderQuiz(BuildContext context, Map<String, dynamic> data) {
    final quizName = data['quiz'] as String? ?? '';
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      shadowColor: Colors.deepPurple.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: Colors.deepPurple.withOpacity(0.2), width: 1.5),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.quiz,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interactive Assessment',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        quizName,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.neutral,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Starting quiz: $quizName')),
                );
              },
              icon: const Icon(Icons.assignment_turned_in),
              label: const Text('Start Quiz Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                minimumSize: Size(double.infinity, 44.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderUnknown(BuildContext context, String type, Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber.shade200),
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        'Unsupported Block Type "$type": ${data.toString()}',
        style: TextStyle(color: Colors.amber.shade900, fontSize: 12.sp),
      ),
    );
  }

  Widget _renderHtmlFallback(BuildContext context, String content) {
    return Text(
      _stripHtml(content),
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  String _stripHtml(String htmlString) {
    var document = htmlString;
    // Simple HTML entities decode
    document = document.replaceAll('&nbsp;', ' ');
    document = document.replaceAll('&amp;', '&');
    document = document.replaceAll('&lt;', '<');
    document = document.replaceAll('&gt;', '>');
    document = document.replaceAll('&quot;', '"');
    document = document.replaceAll('&#39;', "'");

    // Remove HTML tags
    final exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return document.replaceAll(exp, '');
  }

  List<InlineSpan> _parseHtmlToSpans(BuildContext context, String html) {
    final List<InlineSpan> spans = [];
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // A basic parser for inline elements like <b>, <i>, <u>, <a>, <br>
    final regex = RegExp(
      r'(<br\s*/?>)|(<b>|<strong>)(.*?)(</b>|</strong>)|(<i>|<em>)(.*?)(</i>|</em>)|(<u>)(.*?)(</u>)|<a\s+href="([^"]+)"[^>]*>(.*?)</a>|([^<]+)',
      caseSensitive: false,
    );

    final matches = regex.allMatches(html);

    for (final match in matches) {
      if (match.group(1) != null) {
        // <br> tag
        spans.add(const TextSpan(text: '\n'));
      } else if (match.group(2) != null) {
        // bold
        spans.add(TextSpan(
          text: match.group(3),
          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ));
      } else if (match.group(5) != null) {
        // italic
        spans.add(TextSpan(
          text: match.group(6),
          style: textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
        ));
      } else if (match.group(8) != null) {
        // underline
        spans.add(TextSpan(
          text: match.group(9),
          style: textTheme.bodyLarge?.copyWith(decoration: TextDecoration.underline),
        ));
      } else if (match.group(10) != null) {
        // link <a>
        final href = match.group(10)!;
        final linkText = match.group(11)!;
        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: href));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Copied link: $href')),
              );
            },
            child: Text(
              linkText,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ));
      } else if (match.group(12) != null) {
        // plain text
        spans.add(TextSpan(
          text: match.group(12),
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ));
      }
    }

    if (spans.isEmpty && html.isNotEmpty) {
      spans.add(TextSpan(
        text: _stripHtml(html),
        style: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ));
    }

    return spans;
  }
}
