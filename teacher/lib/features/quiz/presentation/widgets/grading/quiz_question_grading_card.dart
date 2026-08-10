import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../../data/models/quiz_models.dart';
import '../../cubit/grading/quiz_grading_cubit.dart';


class QuizQuestionGradingCard extends StatelessWidget {
  const QuizQuestionGradingCard({
    required this.question,
    required this.index,
    super.key,
  });

  final QuizQuestionModel question;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isManualGraded = question.type?.name == 'open_ended' || question.type?.name == 'file_upload';

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
                    '${context.l10n.quizTabQuestions} ${index + 1}: ${question.displayText}',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Chip(
                  label: Text('${question.marks} ${context.l10n.marks}'),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            if (isManualGraded)
              _ManualGradingSection(question: question)
            else
              _buildAutoGradedSection(context, colors),
          ],
        ),
      ),
    );
  }

  Widget _buildAutoGradedSection(BuildContext context, ColorScheme colors) =>
      Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: colors.secondaryContainer.withAlpha(80),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 18.r,
              color: colors.secondary,
            ),
            SizedBox(width: 8.w),
            Text(
              context.l10n.homeworkAutoGraded, // Reuse localization
              style: TextStyle(
                color: colors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
}

class _ManualGradingSection extends StatefulWidget {
  const _ManualGradingSection({required this.question});

  final QuizQuestionModel question;

  @override
  State<_ManualGradingSection> createState() => _ManualGradingSectionState();
}

class _ManualGradingSectionState extends State<_ManualGradingSection> {
  late final TextEditingController _marksController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<QuizGradingCubit>();
    final currentMark = cubit.state.questionMarks[widget.question.name] ?? 0;

    _marksController = TextEditingController(text: '$currentMark');
  }

  @override
  void dispose() {
    _marksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          context.l10n.homeworkAssignMarks,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        SizedBox(
          width: 100.w,
          child: TextFormField(
            controller: _marksController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.r,
                vertical: 8.r,
              ),
              border: const OutlineInputBorder(),
              suffixText: '/ ${widget.question.marks}',
            ),
            onChanged: (val) {
              final parsed = num.tryParse(val) ?? 0;
              context.read<QuizGradingCubit>().setMark(
                widget.question.name,
                parsed,
                widget.question.marks,
              );
            },
          ),
        ),
      ],
    );
  }
}
