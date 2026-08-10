import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../../core/localization/localization_extension.dart';
import '../../cubit/grading/quiz_grading_cubit.dart';
import '../../cubit/grading/quiz_grading_state.dart';

class QuizSubmissionFooter extends StatelessWidget {
  const QuizSubmissionFooter({required this.state, super.key});

  final QuizGradingState state;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: state.status == QuizGradingStatus.loading || state.status == QuizGradingStatus.submitting
                ? null
                : () {
                    context.read<QuizGradingCubit>().submitGrade();
                  },
            child: state.status == QuizGradingStatus.submitting
                ? SizedBox(
                    width: 24.r,
                    height: 24.r,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(context.l10n.quizSubmitGrade),
          ),
        ),
      ),
    );
  }
}
