import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'lesson_content/table_block_widget.dart';

import 'lesson_content/checklist_block_widget.dart';
import 'lesson_content/code_block_widget.dart';
import 'lesson_content/delimiter_block_widget.dart';
import 'lesson_content/editor_js_content_parser.dart';
import 'lesson_content/header_block_widget.dart';
import 'lesson_content/image_block_widget.dart';
import 'lesson_content/lesson_content_helpers.dart';
import 'lesson_content/link_tool_block_widget.dart';
import 'lesson_content/list_block_widget.dart';
import 'lesson_content/markdown_block_widget.dart';
import 'lesson_content/paragraph_block_widget.dart';
import 'lesson_content/quote_block_widget.dart';
import 'lesson_content/quiz_block_widget.dart';
import 'lesson_content/raw_block_widget.dart';
import 'lesson_content/unsupported_block_widget.dart';
import 'lesson_content/upload_pdf_block_widget.dart';
import 'lesson_content/upload_video_block_widget.dart';
import 'lesson_content/youtube_embed_block_widget.dart';

class EditorJsRenderer extends StatelessWidget {
  const EditorJsRenderer({
    this.content,
    this.onRemoveQuiz,
    super.key,
  });

  final String? content;
  final void Function(String quizName)? onRemoveQuiz;

  @override
  Widget build(BuildContext context) {
    final parsed = EditorJsContentParser.parse(content);

    if (parsed.blocks.isEmpty) {
      if (parsed.isMalformed) {
        return _renderHtmlFallback(context, parsed.raw ?? '');
      }
      return const SizedBox.shrink();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: parsed.blocks.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final block = parsed.blocks[index];
        final type = block.type;
        final data = block.data;

        switch (type) {
          case 'header':
            return HeaderBlockWidget(
              text: data['text'] as String? ?? '',
              level: data['level'] as int? ?? 2,
            );
          case 'paragraph':
            return ParagraphBlockWidget(text: data['text'] as String? ?? '');
          case 'markdown':
            return MarkdownBlockWidget(text: data['text'] as String? ?? '');
          case 'list':
            return ListBlockWidget(
              style: data['style'] as String? ?? 'unordered',
              items: data['items'] as List<dynamic>? ?? const [],
            );
          case 'image':
            return ImageBlockWidget(data: data);
          case 'embed':
            final service = data['service'] as String? ?? '';
            final source = data['source'] as String? ?? '';
            if (service == 'youtube') {
              return YoutubeEmbedBlockWidget(
                source: source,
                caption: data['caption'] as String?,
              );
            }
            return UnsupportedBlockWidget(type: type, data: data);
          case 'codeBox':
          case 'code':
            return CodeBlockWidget(
              code: data['code'] as String? ?? '',
              language: data['language'] as String? ?? 'text',
            );
          case 'upload':
            final fileUrl = data['file_url'] as String? ?? '';
            final fileType = data['file_type'] as String? ?? '';
            if (fileType.toLowerCase() == 'pdf') {
              return UploadPdfBlockWidget(fileUrl: fileUrl, fileType: fileType);
            }
            return UploadVideoBlockWidget(fileUrl: fileUrl, fileType: fileType);
          case 'quiz':
            final quizName = data['quiz'] as String? ?? '';
            return QuizBlockWidget(
              quizName: quizName,
              onRemoveQuiz:
                  onRemoveQuiz != null ? () => onRemoveQuiz!(quizName) : null,
            );
          case 'table':
            return TableBlockWidget(
              content: data['content'] as List<dynamic>? ?? const [],
              withHeadings: data['withHeadings'] as bool? ?? false,
            );
          case 'quote':
            return QuoteBlockWidget(
              text: data['text'] as String? ?? '',
              caption: data['caption'] as String?,
              alignment: data['alignment'] as String? ?? 'left',
            );
          case 'raw':
            return RawBlockWidget(html: data['html'] as String? ?? '');
          case 'checklist':
            return ChecklistBlockWidget(
              items: data['items'] as List<dynamic>? ?? const [],
            );
          case 'delimiter':
            return const DelimiterBlockWidget();
          case 'linkTool':
            return LinkToolBlockWidget(
              link: data['link'] as String? ?? '',
              meta: data['meta'] as Map<String, dynamic>?,
            );
          default:
            return UnsupportedBlockWidget(type: type, data: data);
        }
      },
    );
  }

  Widget _renderHtmlFallback(BuildContext context, String content) {
    return Text(
      LessonContentHelpers.stripHtml(content),
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
