import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/courses_models.dart';
import '../cubit/lesson_form_cubit.dart';
import '../cubit/lesson_form_state.dart';

class LessonFormScreen extends StatefulWidget {
  const LessonFormScreen({
    required this.chapterName,
    this.editingLesson,
    super.key,
  });

  final String chapterName;
  final LessonDetailModel? editingLesson;

  @override
  State<LessonFormScreen> createState() => _LessonFormScreenState();
}

class _LessonFormScreenState extends State<LessonFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _textController;
  late final TextEditingController _youtubeController;
  late final TextEditingController _quizController;
  late final TextEditingController _codeController;
  late final TextEditingController _codeLangController;
  bool _includeInPreview = false;
  String _contentType = 'text';
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    final lesson = widget.editingLesson;
    _titleController = TextEditingController(text: lesson?.title ?? '');
    _includeInPreview = lesson?.includeInPreview == 1;

    // Detect editing content type and fill fields if available.
    _textController = TextEditingController();
    _youtubeController = TextEditingController();
    _quizController = TextEditingController();
    _codeController = TextEditingController();
    _codeLangController = TextEditingController(text: 'python');

    if (lesson?.content != null && lesson!.content!.isNotEmpty) {
      try {
        final decoded = jsonDecode(lesson.content!);
        if (decoded is Map<String, dynamic>) {
          final List<dynamic> blocks = decoded['blocks'] ?? [];
          if (blocks.isNotEmpty) {
            final block = blocks.first as Map<String, dynamic>;
            final type = block['type'] as String? ?? '';
            final data = block['data'] as Map<String, dynamic>? ?? {};

            if (type == 'paragraph') {
              _contentType = 'text';
              _textController.text = data['text'] as String? ?? '';
            } else if (type == 'embed' && data['service'] == 'youtube') {
              _contentType = 'youtube';
              _youtubeController.text = data['source'] as String? ?? '';
            } else if (type == 'quiz') {
              _contentType = 'quiz';
              _quizController.text = data['quiz'] as String? ?? '';
            } else if (type == 'codeBox' || type == 'code') {
              _contentType = 'code';
              _codeController.text = data['code'] as String? ?? '';
              _codeLangController.text =
                  data['language'] as String? ?? 'python';
            } else if (type == 'upload') {
              final fileType = data['file_type'] as String? ?? '';
              _contentType = fileType.toLowerCase() == 'pdf' ? 'pdf' : 'video';
            }
          }
        }
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    _youtubeController.dispose();
    _quizController.dispose();
    _codeController.dispose();
    _codeLangController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final isPdf = _contentType == 'pdf';
    final result = await FilePicker.pickFiles(
      type: isPdf ? FileType.custom : FileType.video,
      allowedExtensions: isPdf ? ['pdf'] : null,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<LessonFormCubit>();
    if (widget.editingLesson != null) {
      cubit.updateLesson(
        lessonName: widget.editingLesson!.name,
        title: _titleController.text.trim(),
        includeInPreview: _includeInPreview,
        contentType: _contentType,
        textContent: _textController.text.trim(),
        youtubeUrl: _youtubeController.text.trim(),
        quizName: _quizController.text.trim(),
        codeContent: _codeController.text.trim(),
        codeLanguage: _codeLangController.text.trim(),
        uploadFile: _selectedFile,
      );
    } else {
      cubit.createLesson(
        title: _titleController.text.trim(),
        chapterName: widget.chapterName,
        includeInPreview: _includeInPreview,
        contentType: _contentType,
        textContent: _textController.text.trim(),
        youtubeUrl: _youtubeController.text.trim(),
        quizName: _quizController.text.trim(),
        codeContent: _codeController.text.trim(),
        codeLanguage: _codeLangController.text.trim(),
        uploadFile: _selectedFile,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LessonFormCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.editingLesson != null
                ? context.l10n.editLesson
                : context.l10n.createLesson,
          ),
        ),
        body: BlocConsumer<LessonFormCubit, LessonFormState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                AppSnackBar.showSuccess(
                  context,
                  widget.editingLesson != null
                      ? context.l10n.lessonUpdatedSuccess
                      : context.l10n.lessonCreatedSuccess,
                );
                Navigator.pop(context, true);
              },
              error: (msg) => AppSnackBar.showError(context, msg),
            );
          },
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              submitting: () => true,
              uploading: () => true,
              orElse: () => false,
            );
            final isUploading = state.maybeWhen(
              uploading: () => true,
              orElse: () => false,
            );

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(20.r),
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: context.l10n.lessonTitleLabel,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    validator: (v) => v == null || v.trim().isEmpty
                        ? context.l10n.lessonTitleRequired
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  DropdownButtonFormField<String>(
                    value: _contentType,
                    decoration: InputDecoration(
                      labelText: context.l10n.contentTypeLabel,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'text',
                        child: Text(context.l10n.contentTypeText),
                      ),
                      DropdownMenuItem(
                        value: 'youtube',
                        child: Text(context.l10n.contentTypeYouTube),
                      ),
                      DropdownMenuItem(
                        value: 'video',
                        child: Text(context.l10n.contentTypeVideo),
                      ),
                      DropdownMenuItem(
                        value: 'pdf',
                        child: Text(context.l10n.contentTypePdf),
                      ),
                      DropdownMenuItem(
                        value: 'quiz',
                        child: Text(context.l10n.contentTypeQuiz),
                      ),
                      DropdownMenuItem(
                        value: 'code',
                        child: Text(context.l10n.contentTypeCode),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _contentType = val;
                          _selectedFile = null;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 16.h),
                  _buildContentFields(),
                  SizedBox(height: 16.h),
                  SwitchListTile(
                    title: Text(context.l10n.includeInPreviewLabel),
                    value: _includeInPreview,
                    onChanged: (val) => setState(() => _includeInPreview = val),
                    contentPadding: EdgeInsets.zero,
                  ),
                  SizedBox(height: 32.h),
                  FilledButton(
                    onPressed: isLoading ? null : () => _submit(context),
                    style: FilledButton.styleFrom(
                      minimumSize: Size(double.infinity, 48.h),
                    ),
                    child: isLoading
                        ? Text(
                            isUploading
                                ? context.l10n.uploadingFile
                                : context.l10n.loading,
                          )
                        : Text(context.l10n.save),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContentFields() {
    switch (_contentType) {
      case 'text':
        return TextFormField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: context.l10n.contentTypeText,
            hintText: 'Enter lesson text...',
          ),
          maxLines: 8,
          textCapitalization: TextCapitalization.sentences,
          validator: (v) =>
              v == null || v.trim().isEmpty ? 'Text content is required' : null,
        );
      case 'youtube':
        return TextFormField(
          controller: _youtubeController,
          decoration: InputDecoration(
            labelText: context.l10n.youtubeUrlLabel,
            hintText: context.l10n.youtubeUrlHint,
          ),
          keyboardType: TextInputType.url,
          validator: (v) =>
              v == null || v.trim().isEmpty ? 'YouTube URL is required' : null,
        );
      case 'video':
      case 'pdf':
        final isPdf = _contentType == 'pdf';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton.icon(
              onPressed: _pickFile,
              icon: Icon(isPdf ? Icons.picture_as_pdf : Icons.video_file),
              label: Text(context.l10n.selectFile),
            ),
            if (_selectedFile != null) ...[
              SizedBox(height: 8.h),
              Text(
                _selectedFile!.path.split(Platform.pathSeparator).last,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        );
      case 'quiz':
        return TextFormField(
          controller: _quizController,
          decoration: InputDecoration(labelText: context.l10n.quizNameLabel),
          validator: (v) =>
              v == null || v.trim().isEmpty ? 'Quiz Name is required' : null,
        );
      case 'code':
        return Column(
          children: [
            TextFormField(
              controller: _codeLangController,
              decoration: InputDecoration(
                labelText: context.l10n.codeLanguageLabel,
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Language is required' : null,
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: context.l10n.codeContentLabel,
              ),
              maxLines: 6,
              style: const TextStyle(fontFamily: 'monospace'),
              validator: (v) => v == null || v.trim().isEmpty
                  ? 'Code content is required'
                  : null,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
