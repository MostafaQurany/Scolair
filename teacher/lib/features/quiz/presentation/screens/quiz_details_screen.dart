import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: _QuizDetailsBody(quizName: quizName),
        floatingActionButton: const _QuizFab(),
      ),
    );
  }
}

class _QuizDetailsBody extends StatefulWidget {
  const _QuizDetailsBody({required this.quizName});

  final String quizName;

  @override
  State<_QuizDetailsBody> createState() => _QuizDetailsBodyState();
}

class _QuizDetailsBodyState extends State<_QuizDetailsBody> {
  bool _isSelectionMode = false;
  final Set<String> _selectedQuestions = {};

  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      _selectedQuestions.clear();
    });
  }

  void _toggleQuestionSelection(String questionName) {
    setState(() {
      if (_selectedQuestions.contains(questionName)) {
        _selectedQuestions.remove(questionName);
      } else {
        _selectedQuestions.add(questionName);
      }
    });
  }

  Future<void> _deleteSelected(BuildContext context, QuizModel quiz) async {
    final colorScheme = Theme.of(context).colorScheme;
    final count = _selectedQuestions.length;
    if (count == 0) {
      _toggleSelectionMode();
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colorScheme.surfaceContainer,
        title: Text(
          context.l10n.delete,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          '${context.l10n.delete} $count?',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            style: TextButton.styleFrom(foregroundColor: colorScheme.onSurface),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(foregroundColor: colorScheme.error),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final cubit = context.read<QuizDetailsCubit>();
    final toDelete = _selectedQuestions.toList();
    _toggleSelectionMode();
    await cubit.bulkRemoveQuestions(toDelete);
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
                context.read<QuizDetailsCubit>().loadQuiz(widget.quizName),
          );
        }

        final quiz = state.quiz;
        if (quiz == null) return const SizedBox.shrink();

        final colorScheme = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;

        return RefreshIndicator(
          onRefresh: () =>
              context.read<QuizDetailsCubit>().loadQuiz(widget.quizName),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: colorScheme.onSurface,
                    size: 22.r,
                  ),
                  onPressed: () => Navigator.maybePop(context),
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                ),
                title: Text(
                  context.l10n.quizTabQuestions,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                actions: [
                  if (_isSelectionMode) ...[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          '${_selectedQuestions.length} selected',
                          style: textTheme.labelLarge?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: colorScheme.error,
                        size: 22.r,
                      ),
                      onPressed: () => _deleteSelected(context, quiz),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: colorScheme.onSurface,
                        size: 22.r,
                      ),
                      onPressed: _toggleSelectionMode,
                    ),
                  ] else ...[
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          '${quiz.questions.length}',
                          style: textTheme.labelMedium?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (quiz.questions.isNotEmpty)
                      IconButton(
                        icon: Icon(
                          Icons.checklist,
                          color: colorScheme.onSurface,
                          size: 22.r,
                        ),
                        onPressed: _toggleSelectionMode,
                        tooltip: 'Select',
                      ),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: colorScheme.onSurface,
                        size: 22.r,
                      ),
                      onPressed: () => _openSettings(context),
                      tooltip: context.l10n.quizTabSettings,
                    ),
                  ],
                  SizedBox(width: 8.w),
                ],
              ),
              if (state.isUpdating)
                SliverToBoxAdapter(
                  child: LinearProgressIndicator(
                    color: colorScheme.primary,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                  ),
                ),
              QuestionsTabView(
                quiz: quiz,
                isSelectionMode: _isSelectionMode,
                selectedQuestions: _selectedQuestions,
                onToggleSelection: _toggleQuestionSelection,
                onAddQuestion: () => _addQuestion(context, quiz),
              ),
            ],
          ),
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

        final colorScheme = Theme.of(context).colorScheme;

        return FloatingActionButton(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
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
