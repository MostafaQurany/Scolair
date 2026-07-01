import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../../data/models/quiz_models.dart';

class QuizBasicInfoFields extends StatelessWidget {
  const QuizBasicInfoFields({
    required this.titleController,
    required this.descriptionController,
    required this.format,
    required this.onFormatChanged,
    super.key,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final QuizFormat format;
  final ValueChanged<QuizFormat> onFormatChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: context.l10n.quizTitleLabel,
            hintText: context.l10n.quizTitleHint,
          ),
          validator: (value) => value == null || value.trim().isEmpty
              ? context.l10n.quizTitleRequired
              : null,
        ),
        SizedBox(height: 16.h),
        TextFormField(
          controller: descriptionController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: context.l10n.quizDescriptionLabel,
            hintText: context.l10n.quizDescriptionHint,
          ),
        ),
        SizedBox(height: 16.h),
        SegmentedButton<QuizFormat>(
          segments: [
            ButtonSegment(
              value: QuizFormat.online,
              label: Text(context.l10n.quizFormatOnline),
            ),
            ButtonSegment(
              value: QuizFormat.offline,
              label: Text(context.l10n.quizFormatOffline),
            ),
          ],
          selected: {format},
          onSelectionChanged: (selection) => onFormatChanged(selection.first),
        ),
      ],
    );
  }
}

class QuizTimingFields extends StatelessWidget {
  const QuizTimingFields({
    required this.startDateTime,
    required this.onPickDateTime,
    required this.durationController,
    super.key,
  });

  final DateTime? startDateTime;
  final VoidCallback onPickDateTime;
  final TextEditingController durationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPickDateTime,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: context.l10n.quizStartDateTimeLabel,
            ),
            child: Text(
              startDateTime == null
                  ? context.l10n.quizStartDateTimeHint
                  : startDateTime.toString(),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        TextFormField(
          controller: durationController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: context.l10n.quizDurationLabel,
            suffixText: context.l10n.quizMinutesSuffix,
          ),
        ),
      ],
    );
  }
}

class QuizGradingFields extends StatelessWidget {
  const QuizGradingFields({
    required this.maxGradeController,
    required this.minPassingController,
    super.key,
  });

  final TextEditingController maxGradeController;
  final TextEditingController minPassingController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: maxGradeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: context.l10n.quizMaxGradeFieldLabel,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: TextFormField(
            controller: minPassingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: context.l10n.quizMinPassingFieldLabel,
            ),
          ),
        ),
      ],
    );
  }
}
