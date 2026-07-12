import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/homework_models.dart';
import '../cubit/homework_form_cubit.dart';
import '../cubit/homework_form_state.dart';
import '../widgets/forms/homework_upload_box.dart';
import '../widgets/homework_target_selector.dart';

const _homeworkCategories = ['Worksheet', 'Reading', 'Practice Set', 'Project'];

class HomeworkFormScreen extends StatefulWidget {
  const HomeworkFormScreen({this.editingHomework, super.key});

  final HomeworkModel? editingHomework;

  @override
  State<HomeworkFormScreen> createState() => _HomeworkFormScreenState();
}

class _HomeworkFormScreenState extends State<HomeworkFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _targetNameController;
  String _category = _homeworkCategories.first;
  HomeworkTargetType _targetType = HomeworkTargetType.examQuiz;
  String? _fileName;

  @override
  void initState() {
    super.initState();
    final homework = widget.editingHomework;
    _titleController = TextEditingController(text: homework?.title ?? '');
    _targetNameController = TextEditingController(
      text: homework?.targetName ?? '',
    );
    _category = homework?.category ?? _homeworkCategories.first;
    _targetType = homework?.targetType ?? HomeworkTargetType.examQuiz;
    _fileName = homework?.fileName;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _targetNameController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'docx', 'xlsx'],
    );
    final name = result?.files.single.name;
    if (name == null) return;
    setState(() => _fileName = name);
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final homework = HomeworkModel(
      id: widget.editingHomework?.id ?? '',
      title: _titleController.text.trim(),
      category: _category,
      subject: widget.editingHomework?.subject ?? _category,
      fileName: _fileName ?? '',
      targetType: _targetType,
      targetName: _targetNameController.text.trim(),
      dueDateTime: widget.editingHomework?.dueDateTime ?? DateTime.now(),
      status: widget.editingHomework?.status ?? HomeworkStatus.draft,
      totalStudents: widget.editingHomework?.totalStudents ?? 24,
      submittedCount: widget.editingHomework?.submittedCount ?? 0,
    );

    final cubit = context.read<HomeworkFormCubit>();
    if (widget.editingHomework == null) {
      cubit.createHomework(homework);
    } else {
      cubit.updateHomework(homework);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editingHomework != null;

    return BlocProvider(
      create: (_) => getIt<HomeworkFormCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isEditing
                ? context.l10n.homeworkEditFileTitle
                : context.l10n.homeworkAddFileTitle,
          ),
        ),
        body: BlocConsumer<HomeworkFormCubit, HomeworkFormState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                AppSnackBar.showSuccess(
                  context,
                  context.l10n.homeworkSavedSuccess,
                );
                Navigator.pop(context, true);
              },
              error: (message) => AppSnackBar.showError(context, message),
            );
          },
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              submitting: () => true,
              orElse: () => false,
            );

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(16.r),
                      children: [
                        Text(
                          context.l10n.homeworkFileDetailsSection,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(height: 12.h),
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: context.l10n.homeworkTitleLabel,
                            hintText: context.l10n.homeworkTitleHint,
                          ),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                              ? context.l10n.homeworkTitleRequired
                              : null,
                        ),
                        SizedBox(height: 16.h),
                        DropdownButtonFormField<String>(
                          initialValue: _category,
                          decoration: InputDecoration(
                            labelText: context.l10n.homeworkCategoryLabel,
                          ),
                          items: _homeworkCategories
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ),
                              )
                              .toList(),
                          onChanged: (value) =>
                              setState(() => _category = value!),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          context.l10n.homeworkUploadSection,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(height: 12.h),
                        HomeworkUploadBox(
                          fileName: _fileName,
                          onTap: _pickFile,
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          context.l10n.homeworkTargetSection,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        SizedBox(height: 12.h),
                        HomeworkTargetSelector(
                          targetType: _targetType,
                          onTargetTypeChanged: (value) =>
                              setState(() => _targetType = value),
                          targetNameController: _targetNameController,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      16.w,
                      12.h,
                      16.w,
                      16.h + MediaQuery.of(context).padding.bottom,
                    ),
                    child: FilledButton.icon(
                      onPressed: isLoading ? null : () => _submit(context),
                      icon: const Icon(Icons.upload_outlined),
                      label: Text(context.l10n.homeworkUploadAndAttach),
                      style: FilledButton.styleFrom(
                        minimumSize: Size(double.infinity, 52.h),
                      ),
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
