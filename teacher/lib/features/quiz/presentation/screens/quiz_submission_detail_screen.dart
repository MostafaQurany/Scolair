import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/quiz_submission_models.dart';
import '../cubit/grading/quiz_grading_cubit.dart';
import '../cubit/grading/quiz_grading_state.dart';
import '../widgets/grading/quiz_question_grading_card.dart';
import '../widgets/grading/quiz_submission_footer.dart';
import '../widgets/grading/quiz_submission_header.dart';

class QuizSubmissionDetailScreen extends StatelessWidget {
  const QuizSubmissionDetailScreen({
    required this.quizName,
    required this.submission,
    super.key,
  });

  final String quizName;
  final QuizSubmissionItemModel submission;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<QuizGradingCubit>()..loadSubmission(quizName, submission),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Theme.of(context).colorScheme.primary),
          title: Text(context.l10n.quizSubmissionDetailTitle),
        ),
        body: BlocConsumer<QuizGradingCubit, QuizGradingState>(
          listener: (context, state) {
            if (state.status == QuizGradingStatus.submittedSuccess) {
              AppSnackBar.showSuccess(
                context,
                context.l10n.quizGradedSuccess,
              );
              Navigator.pop(context);
            } else if (state.status == QuizGradingStatus.failure &&
                state.errorMessage != null) {
              AppSnackBar.showError(context, state.errorMessage!);
            }
          },
          builder: (context, state) {
            if (state.status == QuizGradingStatus.loading ||
                state.quiz == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final quiz = state.quiz!;
            return Column(
              children: [
                QuizSubmissionHeader(submission: submission),
                Expanded(
                  child: ListView.builder(
                    itemCount: quiz.questions.length,
                    itemBuilder: (context, index) {
                      return QuizQuestionGradingCard(
                        question: quiz.questions[index],
                        index: index,
                      );
                    },
                  ),
                ),
                QuizSubmissionFooter(state: state),
              ],
            );
          },
        ),
      ),
    );
  }
}
