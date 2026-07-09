import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/network/api_endpoints.dart';
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
  late final TextEditingController _descriptionController;
  late final TextEditingController _shortIntroController;
  late final TextEditingController _imageController;
  late final TextEditingController _tagsController;
  late final TextEditingController _videoLinkController;
  bool _published = false;
  bool _enableCertification = false;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    final course = widget.editingCourse;
    _titleController = TextEditingController(text: course?.title ?? '');
    _descriptionController = TextEditingController(
      text: course?.description ?? '',
    );
    _shortIntroController = TextEditingController(
      text: course?.shortIntroduction ?? '',
    );
    _imageController = TextEditingController(text: course?.image ?? '');
    _tagsController = TextEditingController(text: course?.tags ?? '');
    _videoLinkController = TextEditingController(text: course?.videoLink ?? '');
    _published = course?.published == 1;
    _enableCertification = course?.enableCertification == 1;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _shortIntroController.dispose();
    _imageController.dispose();
    _tagsController.dispose();
    _videoLinkController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    final path = result?.files.single.path;
    if (path == null) return;
    setState(() {
      _selectedImage = File(path);
      _imageController.clear();
    });
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    final cubit = context.read<CourseFormCubit>();
    final course = widget.editingCourse;
    if (course == null) {
      cubit.createCourse(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        shortIntroduction: _shortIntroController.text.trim(),
        image: _imageController.text.trim(),
        imageFile: _selectedImage,
        tags: _tagsController.text.trim(),
        published: _published,
        videoLink: _videoLinkController.text.trim(),
        enableCertification: _enableCertification,
      );
      return;
    }

    cubit.updateCourse(
      courseName: course.name,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      shortIntroduction: _shortIntroController.text.trim(),
      image: _imageController.text.trim(),
      imageFile: _selectedImage,
      tags: _tagsController.text.trim(),
      published: _published,
      videoLink: _videoLinkController.text.trim(),
      enableCertification: _enableCertification,
    );
  }

  // ─── UI helpers ──────────────────────────────────────────────────────────────

  Widget _buildImageHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasFile = _selectedImage != null;
    final hasUrl = _imageController.text.isNotEmpty;
    final hasImage = hasFile || hasUrl;

    String? resolvedUrl;
    if (hasUrl && !hasFile) {
      final raw = _imageController.text;
      resolvedUrl = (raw.startsWith('http://') || raw.startsWith('https://'))
          ? raw
          : '${ApiEndpoints.baseUrl}$raw';
    }

    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: hasImage
              ? null
              : LinearGradient(
                  colors: [
                    colorScheme.primary.withValues(alpha: 0.15),
                    colorScheme.secondary.withValues(alpha: 0.15),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          color: hasImage ? Colors.black : null,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            if (hasFile)
              Image.file(_selectedImage!, fit: BoxFit.cover)
            else if (resolvedUrl != null)
              Image.network(
                resolvedUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),

            // Dark scrim when image present
            if (hasImage)
              Container(color: Colors.black.withValues(alpha: 0.45)),

            // Placeholder or change-photo UI
            Center(
              child: hasImage
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                          child: Icon(
                            Icons.photo_camera_outlined,
                            color: Colors.white,
                            size: 28.r,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          context.l10n.selectCourseImage,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(14.r),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            color: colorScheme.primary,
                            size: 36.r,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          context.l10n.courseImageLabel,
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          context.l10n.courseImageHint,
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 16.h),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _requiredField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String errorText,
    int maxLines = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      validator: (value) =>
          value == null || value.trim().isEmpty ? errorText : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (_) => getIt<CourseFormCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.editingCourse == null
                ? context.l10n.createCourse
                : context.l10n.editCourse,
          ),
          elevation: 0,
        ),
        body: BlocConsumer<CourseFormCubit, CourseFormState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                AppSnackBar.showSuccess(
                  context,
                  widget.editingCourse == null
                      ? context.l10n.courseCreatedSuccess
                      : context.l10n.courseUpdatedSuccess,
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
                      padding: EdgeInsets.zero,
                      children: [
                        // ── Cover image ────────────────────────────────────
                        _buildImageHeader(context),

                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                          child: Column(
                            children: [
                              // ── Basic Info ─────────────────────────────
                              _buildSectionCard(
                                context,
                                title: context.l10n.courseBasicInfoSection,
                                children: [
                                  _requiredField(
                                    context: context,
                                    controller: _titleController,
                                    label: context.l10n.courseTitleLabel,
                                    errorText: context.l10n.courseTitleRequired,
                                  ),
                                  SizedBox(height: 16.h),
                                  _requiredField(
                                    context: context,
                                    controller: _shortIntroController,
                                    label: context.l10n.courseShortIntroLabel,
                                    errorText:
                                        context.l10n.courseShortIntroRequired,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 16.h),
                                  _requiredField(
                                    context: context,
                                    controller: _descriptionController,
                                    label: context.l10n.courseDescriptionLabel,
                                    errorText:
                                        context.l10n.courseDescriptionRequired,
                                    maxLines: 5,
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),

                              // ── Media ──────────────────────────────────
                              _buildSectionCard(
                                context,
                                title: context.l10n.courseMediaSection,
                                children: [
                                  TextFormField(
                                    controller: _videoLinkController,
                                    decoration: InputDecoration(
                                      labelText:
                                          context.l10n.courseVideoLinkLabel,
                                      hintText: context.l10n.youtubeUrlHint,
                                      prefixIcon: const Icon(
                                        Icons.play_circle_outline,
                                      ),
                                    ),
                                    keyboardType: TextInputType.url,
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),

                              // ── Tags ────────────────────────────────────
                              _buildSectionCard(
                                context,
                                title: context.l10n.courseTagsSection,
                                children: [
                                  TextFormField(
                                    controller: _tagsController,
                                    decoration: InputDecoration(
                                      labelText: context.l10n.courseTagsLabel,
                                      hintText: context.l10n.courseTagsHint,
                                      prefixIcon: const Icon(
                                        Icons.label_outline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),

                              // ── Settings ────────────────────────────────
                              _buildSectionCard(
                                context,
                                title: context.l10n.courseSettingsSection,
                                children: [
                                  _SettingsToggle(
                                    icon: Icons.public_outlined,
                                    title: context.l10n.coursePublishedLabel,
                                    value: _published,
                                    onChanged: (v) =>
                                        setState(() => _published = v),
                                  ),
                                  SizedBox(height: 8.h),
                                  const Divider(height: 1),
                                  SizedBox(height: 8.h),
                                  _SettingsToggle(
                                    icon: Icons.workspace_premium_outlined,
                                    title: context
                                        .l10n
                                        .courseEnableCertificationLabel,
                                    value: _enableCertification,
                                    onChanged: (v) => setState(
                                      () => _enableCertification = v,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Sticky submit button ──────────────────────────────────
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      16.w,
                      12.h,
                      16.w,
                      16.h + MediaQuery.of(context).padding.bottom,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      border: Border(
                        top: BorderSide(
                          color: colorScheme.outlineVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ),
                    child: FilledButton(
                      onPressed: isLoading ? null : () => _submit(context),
                      style: FilledButton.styleFrom(
                        minimumSize: Size(double.infinity, 52.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 20.r,
                              height: 20.r,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              widget.editingCourse == null
                                  ? context.l10n.createCourse
                                  : context.l10n.save,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
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

class _SettingsToggle extends StatelessWidget {
  const _SettingsToggle({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 20.r, color: colorScheme.onSurfaceVariant),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
