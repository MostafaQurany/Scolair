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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.editingChapter?.title ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final result = widget.editingChapter == null
        ? await getIt<CreateChapterUseCase>().call(
            title: _titleController.text.trim(),
            courseName: widget.courseName,
            isScormPackage: false,
          )
        : await getIt<UpdateChapterUseCase>().call(
            chapterName: widget.editingChapter!.name,
            title: _titleController.text.trim(),
          );

    if (!mounted) return;
    setState(() => _isLoading = false);
    result.when(
      success: (_) {
        AppSnackBar.showSuccess(
          context,
          widget.editingChapter == null
              ? context.l10n.chapterCreatedSuccess
              : context.l10n.chapterUpdatedSuccess,
        );
        Navigator.pop(context, true);
      },
      failure: (failure) => AppSnackBar.showError(context, failure.message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.editingChapter == null
                    ? context.l10n.createChapter
                    : context.l10n.editChapter,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: context.l10n.chapterTitleLabel,
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) => value == null || value.trim().isEmpty
                    ? context.l10n.chapterTitleRequired
                    : null,
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _isLoading
                          ? null
                          : () => Navigator.pop(context, false),
                      child: Text(context.l10n.cancel),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: FilledButton(
                      onPressed: _isLoading ? null : _submit,
                      child: Text(
                        _isLoading ? context.l10n.loading : context.l10n.save,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
