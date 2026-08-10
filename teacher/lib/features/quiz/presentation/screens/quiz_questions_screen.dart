import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quiz_details_cubit.dart';
import '../cubit/quiz_details_state.dart';
import '../widgets/quiz_questions_tab.dart';
import 'quiz_questions_slider_screen.dart';

class QuizQuestionsScreenArgs {
  const QuizQuestionsScreenArgs({required this.cubit, required this.quiz});

  final QuizDetailsCubit cubit;
  final QuizModel quiz;
}

class QuizQuestionsScreen extends StatefulWidget {
  const QuizQuestionsScreen({
    required this.cubit,
    required this.quiz,
    super.key,
  });

  final QuizDetailsCubit cubit;
  final QuizModel quiz;

  @override
  State<QuizQuestionsScreen> createState() => _QuizQuestionsScreenState();
}

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen> {
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
          context.l10n.quizDeleteConfirm(count),
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

    final toDelete = _selectedQuestions.toList();
    _toggleSelectionMode();
    await widget.cubit.bulkRemoveQuestions(toDelete);
  }

  void _addQuestion(BuildContext context, QuizModel quiz) {
    Navigator.pushNamed(
      context,
      AppRouteNames.quizQuestionsSlider,
      arguments: QuizQuestionsSliderScreenArgs(
        cubit: widget.cubit,
        quiz: quiz,
        initialIndex: quiz.questions.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cubit,
      child: BlocConsumer<QuizDetailsCubit, QuizDetailsState>(
        listenWhen: (previous, current) =>
            previous.mutationError != current.mutationError,
        listener: (context, state) {
          final mutationError = state.mutationError;
          if (mutationError != null) {
            AppSnackBar.showError(context, mutationError);
          }
        },
        builder: (context, state) {
          final quiz = state.quiz ?? widget.quiz;
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              title: Text(context.l10n.quizTabQuestions),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addQuestion(context, quiz),
                  tooltip: context.l10n.questionAddTitle,
                ),
              ],
            ),
            body: QuizQuestionsTab(
              quiz: quiz,
              state: state,
              isSelectionMode: _isSelectionMode,
              selectedQuestions: _selectedQuestions,
              onToggleSelectionMode: _toggleSelectionMode,
              onDeleteSelected: () => _deleteSelected(context, quiz),
              onToggleQuestionSelection: _toggleQuestionSelection,
              onAddQuestion: () => _addQuestion(context, quiz),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _addQuestion(context, quiz),
              icon: const Icon(Icons.add),
              label: Text(context.l10n.questionAddTitle),
            ),
          );
        },
      ),
    );
  }
}
