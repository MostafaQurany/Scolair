import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import 'lesson_part_data.dart';
import 'quiz_selection_dialog.dart';

class LessonPartDraft {
  LessonPartDraft({
    required this.id,
    required this.type,
    String text = '',
    this.file,
    this.existingFileUrl,
    this.existingFileType,
  }) : controller = TextEditingController(text: text);

  final String id;
  LessonPartType type;
  final TextEditingController controller;
  File? file;
  String? existingFileUrl;
  String? existingFileType;

  void dispose() => controller.dispose();

  LessonPartData toData() => LessonPartData(
    type: type,
    text: controller.text.trim(),
    uploadFile: file,
    existingFileUrl: existingFileUrl,
    existingFileType: existingFileType,
  );
}

class LessonPartsEditor extends StatelessWidget {
  const LessonPartsEditor({
    required this.parts,
    required this.onAdd,
    required this.onRemove,
    required this.onReorder,
    required this.onChanged,
    super.key,
  });

  final List<LessonPartDraft> parts;
  final ValueChanged<LessonPartType> onAdd;
  final ValueChanged<LessonPartDraft> onRemove;
  final ReorderCallback onReorder;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: LessonPartType.values
              .map(
                (type) => ActionChip(
                  avatar: Icon(_iconForType(type), size: 18.r),
                  label: Text(_labelForType(context, type)),
                  onPressed: () => onAdd(type),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 12.h),
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: parts.length,
          onReorder: onReorder,
          itemBuilder: (context, index) {
            final part = parts[index];
            return _LessonPartCard(
              key: ValueKey(part.id),
              part: part,
              index: index,
              onRemove: () => onRemove(part),
              onChanged: onChanged,
            );
          },
        ),
      ],
    );
  }
}

class _LessonPartCard extends StatelessWidget {
  const _LessonPartCard({
    required this.part,
    required this.index,
    required this.onRemove,
    required this.onChanged,
    super.key,
  });

  final LessonPartDraft part;
  final int index;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(_iconForType(part.type), size: 20.r),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    '${index + 1}. ${_labelForType(context, part.type)}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            if (part.type == LessonPartType.video ||
                part.type == LessonPartType.pdf)
              _UploadPartField(part: part, onChanged: onChanged)
            else if (part.type == LessonPartType.quiz)
              TextFormField(
                controller: part.controller,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: context.l10n.quizNameLabel,
                  hintText: context.l10n.selectQuizTitle,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
                onTap: () async {
                  final selectedQuiz = await showDialog<String>(
                    context: context,
                    builder: (_) => const QuizSelectionDialog(),
                  );
                  if (selectedQuiz != null) {
                    part.controller.text = selectedQuiz;
                    onChanged();
                  }
                },
              )
            else
              TextFormField(
                controller: part.controller,
                decoration: InputDecoration(
                  labelText: part.type == LessonPartType.youtube
                      ? context.l10n.youtubeUrlLabel
                      : context.l10n.lessonMarkdownLabel,
                  hintText: part.type == LessonPartType.youtube
                      ? context.l10n.youtubeUrlHint
                      : context.l10n.lessonMarkdownHint,
                ),
                keyboardType: part.type == LessonPartType.youtube
                    ? TextInputType.url
                    : TextInputType.multiline,
                maxLines: part.type == LessonPartType.youtube ? 1 : 7,
                onChanged: (_) => onChanged(),
              ),
          ],
        ),
      ),
    );
  }
}

class _UploadPartField extends StatelessWidget {
  const _UploadPartField({required this.part, required this.onChanged});

  final LessonPartDraft part;
  final VoidCallback onChanged;

  Future<void> _pickFile() async {
    final isPdf = part.type == LessonPartType.pdf;
    final result = await FilePicker.platform.pickFiles(
      type: isPdf ? FileType.custom : FileType.video,
      allowedExtensions: isPdf ? ['pdf'] : null,
    );
    final path = result?.files.single.path;
    if (path == null) return;
    part.file = File(path);
    part.existingFileUrl = null;
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final fileLabel = part.file?.path.split(Platform.pathSeparator).last;
    final existingLabel = part.existingFileUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: _pickFile,
          icon: Icon(
            part.type == LessonPartType.pdf
                ? Icons.picture_as_pdf_outlined
                : Icons.video_file_outlined,
          ),
          label: Text(context.l10n.selectFile),
        ),
        if (fileLabel != null || existingLabel != null) ...[
          SizedBox(height: 8.h),
          Text(
            fileLabel ?? existingLabel!,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

IconData _iconForType(LessonPartType type) => switch (type) {
  LessonPartType.markdown => Icons.notes_outlined,
  LessonPartType.youtube => Icons.play_circle_outline,
  LessonPartType.video => Icons.video_file_outlined,
  LessonPartType.pdf => Icons.picture_as_pdf_outlined,
  LessonPartType.quiz => Icons.quiz_outlined,
};

String _labelForType(BuildContext context, LessonPartType type) =>
    switch (type) {
      LessonPartType.markdown => context.l10n.contentTypeText,
      LessonPartType.youtube => context.l10n.contentTypeYouTube,
      LessonPartType.video => context.l10n.contentTypeVideo,
      LessonPartType.pdf => context.l10n.contentTypePdf,
      LessonPartType.quiz => context.l10n.contentTypeQuiz,
    };
