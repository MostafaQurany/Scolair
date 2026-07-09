import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quiz_details_cubit.dart';
import '../cubit/quiz_details_state.dart';
import '../widgets/questions_tab_view.dart';
import '../widgets/quiz_state_widgets.dart';
import 'quiz_questions_slider_screen.dart';
import 'quiz_settings_screen.dart';

class QuizDetailsScreen extends StatelessWidget {
  const QuizDetailsScreen({required this.quizName, super.key});

  final String quizName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<QuizDetailsCubit>()..loadQuiz(quizName),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: _QuizDetailsBody(quizName: quizName),
        floatingActionButton: const _QuizFab(),
      ),
    );
  }
}

class _QuizDetailsBody extends StatelessWidget {
  const _QuizDetailsBody({required this.quizName});

  final String quizName;

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
            onRetry: () => context.read<QuizDetailsCubit>().loadQuiz(quizName),
          );
        }

        final quiz = state.quiz;
        if (quiz == null) return const SizedBox.shrink();

        return CustomScrollView(
          slivers: [
            if (state.isUpdating)
              const SliverToBoxAdapter(
                child: LinearProgressIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.neutralSoft,
                ),
              ),
            SliverToBoxAdapter(
              child: _TopControlRow(
                quiz: quiz,
                onBack: () => Navigator.maybePop(context),
                onRefresh: () =>
                    context.read<QuizDetailsCubit>().loadQuiz(quizName),
                onBulkDelete: () => _confirmDeleteAll(context, quiz),
                onSettings: () => _openSettings(context),
              ),
            ),
            QuestionsTabView(
              quiz: quiz,
              onDeleteQuestion: (question) => context
                  .read<QuizDetailsCubit>()
                  .removeQuestion(question.name),
              onAddQuestion: () => _addQuestion(context, quiz),
            ),
          ],
        );
      },
    );
  }

  void _addQuestion(BuildContext context, QuizModel quiz) {
    final cubit = context.read<QuizDetailsCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: QuizQuestionsSliderScreen(
            quiz: quiz,
            initialIndex: quiz.questions.length,
          ),
        ),
      ),
    );
  }

  void _openSettings(BuildContext context) {
    final cubit = context.read<QuizDetailsCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            BlocProvider.value(value: cubit, child: const QuizSettingsScreen()),
      ),
    );
  }

  Future<void> _confirmDeleteAll(BuildContext context, QuizModel quiz) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: Text(
          context.l10n.delete,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          '${context.l10n.delete} ${context.l10n.quizQuestionsCount(quiz.questions.length)}?',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            style: TextButton.styleFrom(foregroundColor: AppColors.textPrimary),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final cubit = context.read<QuizDetailsCubit>();
    final questionNames = quiz.questions
        .map((question) => question.name)
        .toList(growable: false);

    for (final questionName in questionNames) {
      await cubit.removeQuestion(questionName);
    }
  }
}

class _TopControlRow extends StatelessWidget {
  const _TopControlRow({
    required this.quiz,
    required this.onBack,
    required this.onRefresh,
    required this.onBulkDelete,
    required this.onSettings,
  });

  final QuizModel quiz;
  final VoidCallback onBack;
  final VoidCallback onRefresh;
  final VoidCallback onBulkDelete;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final questionCount = quiz.questions.length;
    final refreshLabel = MaterialLocalizations.of(
      context,
    ).refreshIndicatorSemanticLabel;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 16.h, 12.w, 10.h),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.iconPrimary,
                size: 22.r,
              ),
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            ),
            Expanded(
              child: Text(
                context.l10n.quizQuestionsCount(questionCount),
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: onRefresh,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.iconPrimary,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
              ),
              icon: Icon(Icons.refresh, size: 18.r),
              label: Text(refreshLabel),
            ),
            if (questionCount > 0)
              IconButton(
                onPressed: onBulkDelete,
                icon: Icon(
                  Icons.delete_outline,
                  color: AppColors.error,
                  size: 22.r,
                ),
                tooltip: context.l10n.delete,
              ),
            IconButton(
              onPressed: onSettings,
              icon: Icon(
                Icons.settings,
                color: AppColors.iconPrimary,
                size: 22.r,
              ),
              tooltip: context.l10n.quizTabSettings,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizFab extends StatelessWidget {
  const _QuizFab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizDetailsCubit, QuizDetailsState>(
      builder: (context, state) {
        final quiz = state.quiz;
        if (quiz == null || state.isLoading || quiz.questions.isEmpty) {
          return const SizedBox.shrink();
        }

        return FloatingActionButton(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          onPressed: () => _addQuestion(context, quiz),
          child: const Icon(Icons.add),
        );
      },
    );
  }

  void _addQuestion(BuildContext context, QuizModel quiz) {
    final cubit = context.read<QuizDetailsCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: QuizQuestionsSliderScreen(
            quiz: quiz,
            initialIndex: quiz.questions.length,
          ),
        ),
      ),
    );
  }
}
