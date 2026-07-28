import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../../../quiz/data/models/quiz_models.dart';
import '../../../../quiz/presentation/widgets/question_type_badge.dart';

/// Result returned when the teacher confirms marks for selected questions.
class MarksAssignmentResult {
  const MarksAssignmentResult({
    required this.question,
    required this.marks,
  });

  final QuestionModel question;
  final int marks;
}

/// A dialog that shows after the teacher picks questions from the bank.
/// The teacher assigns a marks value to each selected question before confirming.
class MarksAssignmentDialog extends StatefulWidget {
  const MarksAssignmentDialog({
    required this.selectedQuestions,
    super.key,
  });

  final List<QuestionModel> selectedQuestions;

  @override
  State<MarksAssignmentDialog> createState() => _MarksAssignmentDialogState();
}

class _MarksAssignmentDialogState extends State<MarksAssignmentDialog> {
  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.selectedQuestions.length,
      (_) => TextEditingController(text: '1'),
    );
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onConfirm() {
    final results = <MarksAssignmentResult>[];
    for (int i = 0; i < widget.selectedQuestions.length; i++) {
      final marks = int.tryParse(_controllers[i].text.trim()) ?? 0;
      if (marks < 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.questionMarksMinError),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      results.add(
        MarksAssignmentResult(
          question: widget.selectedQuestions[i],
          marks: marks,
        ),
      );
    }
    Navigator.of(context).pop(results);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 8.w, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    context.l10n.homeworkAssignMarksTitle,
                    style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              '${widget.selectedQuestions.length} ${context.l10n.homeworkQuestionsTab}',
              style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ),
          SizedBox(height: 12.h),
          const Divider(height: 1),
          // Questions list
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.r),
              itemCount: widget.selectedQuestions.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final q = widget.selectedQuestions[index];
                return Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              q.question,
                              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6.h),
                            QuestionTypeBadge(type: q.type),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      SizedBox(
                        width: 72.w,
                        child: TextField(
                          controller: _controllers[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            labelText: context.l10n.marks,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 8.h,
                            ),
                            border: const OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          // Action buttons
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(context.l10n.cancel),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: _onConfirm,
                    child: Text(context.l10n.addToHomework),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
