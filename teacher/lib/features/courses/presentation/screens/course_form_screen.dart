import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/courses_models.dart';
import '../cubit/course_form_cubit.dart';
import '../cubit/course_form_state.dart';

class CourseFormScreen extends StatefulWidget {
  const CourseFormScreen({this.editingCourse, super.key});

  final CourseModel? editingCourse;

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late final TextEditingController _shortIntroController;
  late final TextEditingController _tagsController;
  late final TextEditingController _videoLinkController;
  bool _published = false;
  bool _enableCert = false;

  @override
  void initState() {
    super.initState();
    final course = widget.editingCourse;
    _titleController = TextEditingController(text: course?.title ?? '');
    _descController = TextEditingController(text: course?.description ?? '');
    _shortIntroController = TextEditingController(
      text: course?.shortIntroduction ?? '',
    );
    _tagsController = TextEditingController(text: course?.tags ?? '');
    _videoLinkController = TextEditingController(text: course?.videoLink ?? '');
    _published = course?.published == 1;
    _enableCert = course?.enableCertification == 1;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _shortIntroController.dispose();
    _tagsController.dispose();
    _videoLinkController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<CourseFormCubit>();
    if (widget.editingCourse != null) {
      cubit.updateCourse(
        courseName: widget.editingCourse!.name,
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        shortIntroduction: _shortIntroController.text.trim(),
        tags: _tagsController.text.trim(),
        published: _published,
        videoLink: _videoLinkController.text.trim(),
        enableCertification: _enableCert,
      );
    } else {
      cubit.createCourse(
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        shortIntroduction: _shortIntroController.text.trim(),
        tags: _tagsController.text.trim(),
        published: _published,
        videoLink: _videoLinkController.text.trim(),
        enableCertification: _enableCert,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CourseFormCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.editingCourse != null
                ? context.l10n.editCourse
                : context.l10n.createCourse,
          ),
        ),
        body: BlocConsumer<CourseFormCubit, CourseFormState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                AppSnackBar.showSuccess(
                  context,
                  widget.editingCourse != null
                      ? context.l10n.courseUpdatedSuccess
                      : context.l10n.courseCreatedSuccess,
                );
                Navigator.pop(context, true);
              },
              error: (msg) => AppSnackBar.showError(context, msg),
            );
          },
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              submitting: () => true,
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
                      labelText: context.l10n.courseTitleLabel,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    validator: (v) => v == null || v.trim().isEmpty
                        ? context.l10n.courseTitleRequired
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _shortIntroController,
                    decoration: InputDecoration(
                      labelText: context.l10n.courseShortIntroLabel,
                    ),
                    maxLines: 2,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _descController,
                    decoration: InputDecoration(
                      labelText: context.l10n.courseDescriptionLabel,
                    ),
                    maxLines: 4,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _tagsController,
                    decoration: InputDecoration(
                      labelText: context.l10n.courseTagsLabel,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: _videoLinkController,
                    decoration: InputDecoration(
                      labelText: context.l10n.courseVideoLinkLabel,
                      hintText: 'https://youtube.com/...',
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(height: 16.h),
                  SwitchListTile(
                    title: Text(context.l10n.coursePublishedLabel),
                    value: _published,
                    onChanged: (val) => setState(() => _published = val),
                    contentPadding: EdgeInsets.zero,
                  ),
                  SwitchListTile(
                    title: Text(context.l10n.courseEnableCertificationLabel),
                    value: _enableCert,
                    onChanged: (val) => setState(() => _enableCert = val),
                    contentPadding: EdgeInsets.zero,
                  ),
                  SizedBox(height: 32.h),
                  FilledButton(
                    onPressed: isLoading ? null : () => _submit(context),
                    style: FilledButton.styleFrom(
                      minimumSize: Size(double.infinity, 48.h),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
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
}
