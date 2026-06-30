import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/courses_models.dart';
import '../cubit/lesson_form_cubit.dart';
import '../cubit/lesson_form_state.dart';
import '../widgets/lesson_form/lesson_part_data.dart';
import '../widgets/lesson_form/lesson_parts_editor.dart';

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
  final List<LessonPartDraft> _parts = [];
  bool _includeInPreview = false;
  int _nextPartId = 0;

  @override
  void initState() {
    super.initState();
    final lesson = widget.editingLesson;
    _titleController = TextEditingController(text: lesson?.title ?? '');
    _includeInPreview = lesson?.includeInPreview == 1;
    _loadExistingParts(lesson?.content);
    if (_parts.isEmpty) _addPart(LessonPartType.markdown);
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (final part in _parts) {
      part.dispose();
    }
    super.dispose();
  }

  void _addPart(LessonPartType type) {
    setState(() {
      _parts.add(LessonPartDraft(id: '${_nextPartId++}', type: type));
    });
  }

  void _removePart(LessonPartDraft part) {
    if (_parts.length == 1) return;
    setState(() {
      _parts.remove(part);
      part.dispose();
    });
  }

  void _reorderParts(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final part = _parts.removeAt(oldIndex);
      _parts.insert(newIndex, part);
    });
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    if (!_validateParts(context)) return;

    final cubit = context.read<LessonFormCubit>();
    final parts = _parts.map((part) => part.toData()).toList(growable: false);
    final lesson = widget.editingLesson;
    if (lesson == null) {
      cubit.createLesson(
        title: _titleController.text.trim(),
        chapterName: widget.chapterName,
        includeInPreview: _includeInPreview,
        parts: parts,
      );
      return;
    }

    cubit.updateLesson(
      lessonName: lesson.name,
      title: _titleController.text.trim(),
      includeInPreview: _includeInPreview,
      parts: parts,
    );
  }

  bool _validateParts(BuildContext context) {
    for (final part in _parts) {
      final isTextPart =
          part.type == LessonPartType.markdown ||
          part.type == LessonPartType.youtube;
      final hasText = part.controller.text.trim().isNotEmpty;
      final hasFile = part.file != null || part.existingFileUrl != null;
      if ((isTextPart && !hasText) || (!isTextPart && !hasFile)) {
        AppSnackBar.showError(context, context.l10n.lessonPartContentRequired);
        return false;
      }
    }
    return true;
  }

  void _loadExistingParts(String? content) {
    if (content == null || content.isEmpty) return;
    try {
      final decoded = jsonDecode(content);
      if (decoded is! Map<String, dynamic>) return;
      final blocks = decoded['blocks'];
      if (blocks is! List) return;
      for (final block in blocks.whereType<Map<String, dynamic>>()) {
        _parts.add(_draftFromBlock(block));
      }
    } on Object {
      _parts.add(
        LessonPartDraft(
          id: '${_nextPartId++}',
          type: LessonPartType.markdown,
          text: content,
        ),
      );
    }
  }

  LessonPartDraft _draftFromBlock(Map<String, dynamic> block) {
    final type = block['type'] as String? ?? '';
    final data = block['data'] as Map<String, dynamic>? ?? {};
    if (type == 'embed' && data['service'] == 'youtube') {
      return LessonPartDraft(
        id: '${_nextPartId++}',
        type: LessonPartType.youtube,
        text: data['source'] as String? ?? '',
      );
    }
    if (type == 'upload') {
      final fileType = (data['file_type'] as String? ?? '').toLowerCase();
      return LessonPartDraft(
        id: '${_nextPartId++}',
        type: fileType == 'pdf' ? LessonPartType.pdf : LessonPartType.video,
        existingFileUrl: data['file_url'] as String?,
        existingFileType: fileType,
      );
    }
    return LessonPartDraft(
      id: '${_nextPartId++}',
      type: LessonPartType.markdown,
      text: data['text'] as String? ?? data['html'] as String? ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LessonFormCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.editingLesson == null
                ? context.l10n.createLesson
                : context.l10n.editLesson,
          ),
        ),
        body: BlocConsumer<LessonFormCubit, LessonFormState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                AppSnackBar.showSuccess(
                  context,
                  widget.editingLesson == null
                      ? context.l10n.lessonCreatedSuccess
                      : context.l10n.lessonUpdatedSuccess,
                );
                Navigator.pop(context, true);
              },
              error: (message) => AppSnackBar.showError(context, message),
            );
          },
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              submitting: () => true,
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
                    validator: (value) => value == null || value.trim().isEmpty
                        ? context.l10n.lessonTitleRequired
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  SwitchListTile(
                    title: Text(context.l10n.includeInPreviewLabel),
                    value: _includeInPreview,
                    onChanged: (value) =>
                        setState(() => _includeInPreview = value),
                    contentPadding: EdgeInsets.zero,
                  ),
                  SizedBox(height: 12.h),
                  LessonPartsEditor(
                    parts: _parts,
                    onAdd: _addPart,
                    onRemove: _removePart,
                    onReorder: _reorderParts,
                    onChanged: () => setState(() {}),
                  ),
                  SizedBox(height: 24.h),
                  FilledButton(
                    onPressed: isLoading ? null : () => _submit(context),
                    child: Text(
                      isLoading
                          ? context.l10n.uploadingFile
                          : context.l10n.save,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
