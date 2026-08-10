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
  Widget build(BuildContext context) => BlocProvider(
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
                                  ...List.generate(sub.questions.length, (index) => HomeworkQuestionGradingCard(
                                      question: sub.questions[index],
                                      index: index,
                                    )),
                                  SizedBox(height: 16.h),
                                  const _FeedbackSection(),
                                  SizedBox(height: 32.h),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
            bottomNavigationBar: sub == null
                ? null
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: FilledButton(
                        onPressed: state.status == HomeworkGradingStatus.submitting
                            ? null
                            : () => context.read<HomeworkGradingCubit>().submitGrade(),
                        child: state.status == HomeworkGradingStatus.submitting
                            ? SizedBox(
                                width: 24.r,
                                height: 24.r,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(context.l10n.homeworkSubmitGrade),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
}

class _FeedbackSection extends StatefulWidget {
  const _FeedbackSection();

  @override
  State<_FeedbackSection> createState() => _FeedbackSectionState();
}

class _FeedbackSectionState extends State<_FeedbackSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<HomeworkGradingCubit>();
    _controller = TextEditingController(text: cubit.state.overallFeedback);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.homeworkOverallFeedback, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          SizedBox(height: 8.h),
          TextFormField(
            controller: _controller,
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
}
