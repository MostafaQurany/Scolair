import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quiz_details_cubit.dart';
import '../cubit/quiz_details_state.dart';
import '../screens/quiz_questions_screen.dart';
import '../screens/quiz_questions_slider_screen.dart';
import 'add_to_lesson_sheet.dart';
import 'quiz_info_card.dart';
import 'quiz_state_widgets.dart';

class QuizDetailsBody extends StatelessWidget {
  const QuizDetailsBody({required this.quizName, super.key});

  final String quizName;

  void _openSettings(BuildContext context, QuizDetailsCubit cubit) {
    Navigator.pushNamed(context, AppRouteNames.quizSettings, arguments: cubit);
  }

  void _addQuestion(
    BuildContext context,
    QuizDetailsCubit cubit,
    QuizModel quiz,
  ) {
    Navigator.pushNamed(
      context,
      AppRouteNames.quizQuestionsSlider,
      arguments: QuizQuestionsSliderScreenArgs(
        cubit: cubit,
        quiz: quiz,
        initialIndex: quiz.questions.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizDetailsCubit, QuizDetailsState>(
      listenWhen: (previous, current) =>
          previous.mutationError != current.mutationError,
      listener: (context, state) {
        final mutationError = state.mutationError;
        if (mutationError != null) {
          AppSnackBar.showError(context, mutationError);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const QuizQuestionsShimmer();
        }

        final errorMessage = state.errorMessage;
        if (errorMessage != null) {
          return QuizErrorState(
            message: errorMessage,
            onRetry: () =>
                context.read<QuizDetailsCubit>().loadQuiz(quizName),
          );
        }

        final quiz = state.quiz;
        if (quiz == null) return const SizedBox.shrink();

        final colorScheme = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<QuizDetailsCubit>();

        return RefreshIndicator(
          onRefresh: () => cubit.loadQuiz(quizName),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                surfaceTintColor: Colors.transparent,
                leading: BackButton(color: colorScheme.primary),
                title: Text(
                  quiz.title,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: colorScheme.onSurface,
                      size: 22.r,
                    ),
                    onPressed: () => _openSettings(context, cubit),
                    tooltip: context.l10n.quizTabSettings,
                  ),
                  SizedBox(width: 8.w),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.all(16.r),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Quiz Info Card
                    QuizInfoCard(quiz: quiz),
                    SizedBox(height: 16.h),

                    // 1. Add to Lesson Button
                    FilledButton.icon(
                      onPressed: () => AddToLessonSheet.show(context, quizName),
                      icon: const Icon(Icons.playlist_add),
                      label: Text(context.l10n.addToLessonTitle),
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // 2. Questions Card
                    _buildQuestionsNavCard(context, cubit, quiz),
                    SizedBox(height: 12.h),

                    // 3. Submissions Card
                    _buildSubmissionsNavCard(context, quiz),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuestionsNavCard(
    BuildContext context,
    QuizDetailsCubit cubit,
    QuizModel quiz,
  ) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final count = quiz.questions.length;
    final totalMarks = quiz.totalMarks;

    return Card(
      elevation: 0,
      color: colors.primaryContainer.withAlpha(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colors.primary.withAlpha(80)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRouteNames.quizQuestions,
            arguments: QuizQuestionsScreenArgs(cubit: cubit, quiz: quiz),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.help_outline,
                  color: colors.onPrimary,
                  size: 24.r,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.quizTabQuestions,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${context.l10n.homeworkQuestionsCount(count)} • $totalMarks ${context.l10n.marks}',
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.r,
                color: colors.onSurfaceVariant,
              ),
              SizedBox(width: 8.w),
              IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: colors.primary,
                  size: 28.r,
                ),
                onPressed: () => _addQuestion(context, cubit, quiz),
                tooltip: context.l10n.questionAddTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmissionsNavCard(BuildContext context, QuizModel quiz) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: colors.secondaryContainer.withAlpha(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: colors.secondary.withAlpha(80)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRouteNames.quizSubmissions,
            arguments: quiz.name,
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.assignment_turned_in_outlined,
                  color: colors.onSecondary,
                  size: 24.r,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.quizSubmissionsTitle,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.l10n.homeworkViewSubmissions,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.r,
                color: colors.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
