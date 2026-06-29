import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/courses_models.dart';
import '../../domain/usecases/courses_usecases.dart';

class ChapterFormScreen extends StatefulWidget {
  const ChapterFormScreen({
    required this.courseName,
    this.editingChapter,
    super.key,
  });

  final String courseName;
  final ChapterDetailModel? editingChapter;

  @override
  State<ChapterFormScreen> createState() => _ChapterFormScreenState();
}

class _ChapterFormScreenState extends State<ChapterFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  bool _isScormPackage = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.editingChapter?.title ?? '',
    );
    // DetailModel doesn't have isScormPackage field direct, or we check if we can toggle it.
    // In any case, we can keep it as is.
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    if (widget.editingChapter != null) {
      final res = await getIt<UpdateChapterUseCase>().call(
        chapterName: widget.editingChapter!.name,
        title: _titleController.text.trim(),
      );
      if (mounted) {
        setState(() => _isLoading = false);
        res.when(
          success: (_) {
            AppSnackBar.showSuccess(
              context,
              context.l10n.chapterUpdatedSuccess,
            );
            Navigator.pop(context, true);
          },
          failure: (fail) => AppSnackBar.showError(context, fail.message),
        );
      }
    } else {
      final res = await getIt<CreateChapterUseCase>().call(
        title: _titleController.text.trim(),
        courseName: widget.courseName,
        isScormPackage: _isScormPackage,
      );
      if (mounted) {
        setState(() => _isLoading = false);
        res.when(
          success: (_) {
            AppSnackBar.showSuccess(
              context,
              context.l10n.chapterCreatedSuccess,
            );
            Navigator.pop(context, true);
          },
          failure: (fail) => AppSnackBar.showError(context, fail.message),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.editingChapter != null
              ? context.l10n.editChapter
              : context.l10n.createChapter,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(20.r),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: context.l10n.chapterTitleLabel,
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) => v == null || v.trim().isEmpty
                  ? context.l10n.chapterTitleRequired
                  : null,
            ),
            if (widget.editingChapter == null) ...[
              SizedBox(height: 16.h),
              SwitchListTile(
                title: Text(context.l10n.isScormPackageLabel),
                value: _isScormPackage,
                onChanged: (val) => setState(() => _isScormPackage = val),
                contentPadding: EdgeInsets.zero,
              ),
            ],
            SizedBox(height: 32.h),
            FilledButton(
              onPressed: _isLoading ? null : _submit,
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(context.l10n.save),
            ),
          ],
        ),
      ),
    );
  }
}
