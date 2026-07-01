import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';

class CourseRequiredField extends StatelessWidget {
  const CourseRequiredField({
    required this.controller,
    required this.label,
    required this.error,
    this.maxLines = 1,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String error;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      maxLines: maxLines,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) =>
          value == null || value.trim().isEmpty ? error : null,
    );
  }
}

class CourseImagePicker extends StatelessWidget {
  const CourseImagePicker({
    required this.controller,
    required this.selectedImage,
    required this.onPickImage,
    required this.onClearImage,
    super.key,
  });

  final TextEditingController controller;
  final File? selectedImage;
  final VoidCallback onPickImage;
  final VoidCallback onClearImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: context.l10n.courseImageLabel,
            hintText: context.l10n.courseImageHint,
          ),
          keyboardType: TextInputType.url,
        ),
        SizedBox(height: 10.h),
        OutlinedButton.icon(
          onPressed: onPickImage,
          icon: const Icon(Icons.image_outlined),
          label: Text(context.l10n.selectCourseImage),
        ),
        if (selectedImage != null) ...[
          SizedBox(height: 8.h),
          InputChip(
            label: Text(selectedImage!.path.split(Platform.pathSeparator).last),
            onDeleted: onClearImage,
          ),
        ],
      ],
    );
  }
}
