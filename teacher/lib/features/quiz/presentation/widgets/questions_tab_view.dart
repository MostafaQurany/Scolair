import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

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
    required this.onDeleteQuestion,
    required this.onAddQuestion,
    super.key,
  });

  final QuizModel quiz;
  final ValueChanged<QuizQuestionModel> onDeleteQuestion;
  final VoidCallback onAddQuestion;

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
      padding: EdgeInsets.symmetric(horizontal: horizontalPad),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          if (index == quiz.questions.length) {
            return SizedBox(height: 80.h);
          }

          final question = quiz.questions[index];
          return QuestionCard(
            index: index + 1,
            question: question,
            onEdit: () => _navigateToSlider(context, index),
            onDelete: () => onDeleteQuestion(question),
          );
        }, childCount: quiz.questions.length + 1),
      ),
    );
  }

  void _navigateToSlider(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<QuizDetailsCubit>(),
          child: QuizQuestionsSliderScreen(quiz: quiz, initialIndex: index),
        ),
      ),
    );
  }
}
