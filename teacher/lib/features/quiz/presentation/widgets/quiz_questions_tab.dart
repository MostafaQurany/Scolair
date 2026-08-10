import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quiz_details_state.dart';
import 'questions_tab_view.dart';

class QuizQuestionsTab extends StatelessWidget {
  const QuizQuestionsTab({
    required this.quiz,
    required this.state,
    required this.isSelectionMode,
    required this.selectedQuestions,
    required this.onToggleSelectionMode,
    required this.onDeleteSelected,
    required this.onToggleQuestionSelection,
    required this.onAddQuestion,
    super.key,
  });

  final QuizModel quiz;
  final QuizDetailsState state;
  final bool isSelectionMode;
  final Set<String> selectedQuestions;
  final VoidCallback onToggleSelectionMode;
  final Future<void> Function() onDeleteSelected;
  final void Function(String) onToggleQuestionSelection;
  final VoidCallback onAddQuestion;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: state.isUpdating
              ? LinearProgressIndicator(
                  color: colorScheme.primary,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                )
              : const SizedBox.shrink(),
        ),
        if (isSelectionMode)
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Text(
                    context.l10n.quizSelectedCount(selectedQuestions.length),
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: colorScheme.error,
                      size: 22.r,
                    ),
                    onPressed: onDeleteSelected,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: colorScheme.onSurface,
                      size: 22.r,
                    ),
                    onPressed: onToggleSelectionMode,
                  ),
                ],
              ),
            ),
          )
        else
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Container(
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
                  const Spacer(),
                  if (quiz.questions.isNotEmpty)
                    IconButton(
                      icon: Icon(
                        Icons.checklist,
                        color: colorScheme.onSurface,
                        size: 22.r,
                      ),
                      onPressed: onToggleSelectionMode,
                      tooltip: context.l10n.quizSelectTooltip,
                    ),
                ],
              ),
            ),
          ),
        QuestionsTabView(
          quiz: quiz,
          isSelectionMode: isSelectionMode,
          selectedQuestions: selectedQuestions,
          onToggleSelection: onToggleQuestionSelection,
          onAddQuestion: onAddQuestion,
        ),
      ],
    );
  }
}
