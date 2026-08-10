import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quiz_details_cubit.dart';
import '../cubit/quiz_details_state.dart';
import '../screens/quiz_questions_slider_screen.dart';

class QuizDetailsFab extends StatelessWidget {
  const QuizDetailsFab({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<QuizDetailsCubit, QuizDetailsState>(
        builder: (context, state) {
          final quiz = state.quiz;
          if (quiz == null || state.isLoading) {
            return const SizedBox.shrink();
          }

          final tabController = DefaultTabController.maybeOf(context);
          if (tabController == null) return const SizedBox.shrink();

          return AnimatedBuilder(
            animation: tabController,
            builder: (context, _) {
              // Only show FAB on Questions tab (index 0)
              if (tabController.index != 0) {
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
        },
      );

  void _addQuestion(BuildContext context, QuizModel quiz) {
    final cubit = context.read<QuizDetailsCubit>();
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
}
