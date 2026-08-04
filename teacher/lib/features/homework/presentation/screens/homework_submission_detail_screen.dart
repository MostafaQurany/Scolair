import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../cubit/grading/homework_grading_cubit.dart';
import '../cubit/grading/homework_grading_state.dart';
import '../widgets/grading/homework_question_grading_card.dart';
import '../widgets/grading/homework_submission_info_card.dart';
import '../widgets/homework_submission_detail_shimmer.dart';

class HomeworkSubmissionDetailScreen extends StatelessWidget {
  const HomeworkSubmissionDetailScreen({required this.submissionName, super.key});

  final String submissionName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeworkGradingCubit>()..loadSubmission(submissionName),
      child: BlocConsumer<HomeworkGradingCubit, HomeworkGradingState>(
        listener: (context, state) {
          if (state.status == HomeworkGradingStatus.failure && state.errorMessage != null) {
            AppSnackBar.showError(context, state.errorMessage!);
          } else if (state.status == HomeworkGradingStatus.success && state.downloadedFileBytes != null) {
            AppSnackBar.showSuccess(context, context.l10n.homeworkFileDownloaded);
          } else if (state.status == HomeworkGradingStatus.submittedSuccess && state.submission != null) {
            AppSnackBar.showSuccess(context, context.l10n.homeworkGradedSuccess);
            Navigator.of(context).pop(true);
          }
        },
        builder: (context, state) {
          final sub = state.submission;

          return Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.homeworkGradeSubmissionTitle),
              elevation: 0,
            ),
            body: state.status == HomeworkGradingStatus.loading && sub == null
                ? const HomeworkSubmissionDetailShimmer()
                : sub == null
                    ? Center(child: Text(state.errorMessage ?? context.l10n.errorOccurred))
                    : Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  HomeworkSubmissionInfoCard(submission: sub),
                                  ...List.generate(sub.questions.length, (index) {
                                    return HomeworkQuestionGradingCard(
                                      question: sub.questions[index],
                                      index: index,
                                    );
                                  }),
                                  SizedBox(height: 16.h),
                                  _buildOverallFeedbackSection(context, state),
                                  SizedBox(height: 32.h),
                                ],
                              ),
                            ),
                          ),
                          _buildBottomBar(context, state),
                        ],
                      ),
          );
        },
      ),
    );
  }

  Widget _buildOverallFeedbackSection(BuildContext context, HomeworkGradingState state) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.homeworkOverallFeedback, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          SizedBox(height: 8.h),
          TextFormField(
            initialValue: state.overallFeedback,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: context.l10n.homeworkFeedbackHint,
              border: const OutlineInputBorder(),
            ),
            onChanged: (val) => context.read<HomeworkGradingCubit>().setFeedback(val),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, HomeworkGradingState state) {
    final colors = Theme.of(context).colorScheme;
    final submission = state.submission!;
          
    final hasManualQuestions = submission.questions.any((q) => q.isManualGraded);
    final isAlreadyGraded = submission.status.toLowerCase() == 'graded';

    if (isAlreadyGraded || !hasManualQuestions) {
      return const SizedBox.shrink();
    }

    final isSubmitting = state.status == HomeworkGradingStatus.submitting;
    final isValid = state.isValidMarks();

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.outlineVariant)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 14.r)),
          onPressed: !isValid || isSubmitting
              ? null
              : () => context.read<HomeworkGradingCubit>().submitGrade(),
          child: isSubmitting
              ? SizedBox(
                  height: 20.r,
                  width: 20.r,
                  child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : Text(context.l10n.homeworkSubmitGrade),
        ),
      ),
    );
  }
}
