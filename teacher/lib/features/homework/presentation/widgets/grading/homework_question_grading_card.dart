import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../../domain/entities/homework_submission.dart';
import '../../cubit/grading/homework_grading_cubit.dart';
import '../../cubit/grading/homework_grading_state.dart';

class HomeworkQuestionGradingCard extends StatelessWidget {
  const HomeworkQuestionGradingCard({
    required this.question,
    required this.index,
    super.key,
  });

  final SubmissionQuestionDetail question;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colors.outlineVariant),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${context.l10n.homeworkQuestionTab} ${index + 1}: ${question.questionText.isNotEmpty ? question.questionText : question.question}',
                    style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Chip(
                  label: Text('${question.maxMarks} ${context.l10n.marks}'),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildAnswerSection(context, colors, textTheme),
            SizedBox(height: 16.h),
            if (question.isManualGraded)
              _buildManualGradingSection(context)
            else
              _buildAutoGradedSection(context, colors),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerSection(BuildContext context, ColorScheme colors, TextTheme textTheme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.homeworkAnswer, style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, color: colors.onSurfaceVariant)),
          SizedBox(height: 6.h),
          if (question.type.toLowerCase().contains('file') && question.answer != null && question.answer!.isNotEmpty)
            Row(
              children: [
                Icon(Icons.attach_file, size: 20.r, color: colors.primary),
                SizedBox(width: 8.w),
                Expanded(child: Text(question.answer!, style: textTheme.bodyMedium, overflow: TextOverflow.ellipsis)),
                TextButton.icon(
                  onPressed: () => context.read<HomeworkGradingCubit>().downloadFile(question.question),
                  icon: const Icon(Icons.download_outlined),
                  label: Text(context.l10n.download),
                ),
              ],
            )
          else if (question.answer != null && question.answer!.isNotEmpty)
            Text(question.answer!, style: textTheme.bodyMedium)
          else
            Text(context.l10n.homeworkNoAnswer, style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic, color: colors.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _buildAutoGradedSection(BuildContext context, ColorScheme colors) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: colors.secondaryContainer.withAlpha(80),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 18.r, color: colors.secondary),
          SizedBox(width: 8.w),
          Text(
            '${context.l10n.homeworkAutoGraded}: ${question.marksAwarded ?? 0} / ${question.maxMarks}',
            style: TextStyle(color: colors.secondary, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildManualGradingSection(BuildContext context) {
    return BlocBuilder<HomeworkGradingCubit, HomeworkGradingState>(
      builder: (context, state) {
        final currentMark = state.questionMarks[question.question] ?? (question.marksAwarded ?? 0);
        final currentNote = state.questionNotes[question.question] ?? (question.note ?? '');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(context.l10n.homeworkAssignMarks, style: const TextStyle(fontWeight: FontWeight.w600)),
                const Spacer(),
                SizedBox(
                  width: 100.w,
                  child: TextFormField(
                    initialValue: '$currentMark',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 8.r),
                      border: const OutlineInputBorder(),
                      suffixText: '/ ${question.maxMarks}',
                    ),
                    onChanged: (val) {
                      final parsed = num.tryParse(val) ?? 0;
                      context.read<HomeworkGradingCubit>().setMark(question.question, parsed, question.maxMarks);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            TextFormField(
              initialValue: currentNote,
              decoration: InputDecoration(
                labelText: context.l10n.homeworkQuestionNote,
                hintText: context.l10n.homeworkAddNoteHint,
                isDense: true,
                border: const OutlineInputBorder(),
              ),
              onChanged: (val) => context.read<HomeworkGradingCubit>().setNote(question.question, val),
            ),
          ],
        );
      },
    );
  }
}
