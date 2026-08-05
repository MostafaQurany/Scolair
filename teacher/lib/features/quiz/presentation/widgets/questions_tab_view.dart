import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/extensions/adaptive_layout_extension.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quiz_details_cubit.dart';
import '../screens/quiz_questions_slider_screen.dart';
import 'question_card.dart';
import 'quiz_state_widgets.dart';

/// Sliver question list inside the quiz details screen.
class QuestionsTabView extends StatelessWidget {
  const QuestionsTabView({
    required this.quiz,
    required this.onAddQuestion, this.onDeleteQuestion,
    this.isSelectionMode = false,
    this.selectedQuestions = const {},
    this.onToggleSelection,
    super.key,
  });

  final QuizModel quiz;
  final ValueChanged<QuizQuestionModel>? onDeleteQuestion;
  final VoidCallback onAddQuestion;
  final bool isSelectionMode;
  final Set<String> selectedQuestions;
  final ValueChanged<String>? onToggleSelection;

  @override
  Widget build(BuildContext context) {
    if (quiz.questions.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: QuizEmptyState(onAdd: onAddQuestion),
      );
    }

    final isTablet = context.isTabletLayout;
    final horizontalPad = isTablet ? 24.0.w : 16.0.w;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPad, vertical: 16.h),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index == quiz.questions.length) {
            return SizedBox(height: 80.h);
          }

          final question = quiz.questions[index];
          return QuestionCard(
            index: index + 1,
            question: question,
            isSelectionMode: isSelectionMode,
            isSelected: selectedQuestions.contains(question.name),
            onToggleSelection: () => onToggleSelection?.call(question.name),
            onEdit: () => _navigateToSlider(context, index),
            onDelete: onDeleteQuestion != null
                ? () => onDeleteQuestion!(question)
                : null,
          );
        }, childCount: quiz.questions.length + 1),
      ),
    );
  }

  void _navigateToSlider(BuildContext context, int index) {
    Navigator.pushNamed(
      context,
      AppRouteNames.quizQuestionsSlider,
      arguments: QuizQuestionsSliderScreenArgs(
        cubit: context.read<QuizDetailsCubit>(),
        quiz: quiz,
        initialIndex: index,
      ),
    );
  }
}
