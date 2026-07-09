import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';

import '../cubit/quizzes_cubit.dart';
import '../cubit/quizzes_state.dart';
import '../widgets/quiz_card.dart';
import 'quiz_details_screen.dart';
import 'quiz_form_screen.dart';

class QuizzesListScreen extends StatelessWidget {
  const QuizzesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<QuizzesCubit>()..loadQuizzes(),
      child: const _QuizzesListView(),
    );
  }
}

class _QuizzesListView extends StatelessWidget {
  const _QuizzesListView();

  Future<void> _createQuiz(BuildContext context) async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const QuizFormScreen()),
    );
    if (created == true && context.mounted) {
      context.read<QuizzesCubit>().loadQuizzes();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.quizzesTitle)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.quizzesMockClassLabel,
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 12.h),
              FilledButton.icon(
                onPressed: () => _createQuiz(context),
                icon: const Icon(Icons.add),
                label: Text(context.l10n.quizCreateButton),
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 48.h),
                ),
              ),
              SizedBox(height: 16.h),
              const Expanded(child: _QuizzesBody()),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuizzesBody extends StatelessWidget {
  const _QuizzesBody();

  void _onDeleteQuiz(BuildContext context, String quizName) {
    context.read<QuizzesCubit>().deleteQuiz(quizName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizzesCubit, QuizzesState>(
      listener: (context, state) {
        final error = state.errorMessage;
        if (error != null) {
          AppSnackBar.showError(context, error);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final quizzes = state.quizzes?.items ?? const [];

        if (quizzes.isEmpty) {
          return Center(child: Text(context.l10n.quizzesEmptyMessage));
        }

        return RefreshIndicator(
          onRefresh: context.read<QuizzesCubit>().loadQuizzes,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              final quiz = quizzes[index];
              return QuizCard(
                quiz: quiz,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizDetailsScreen(quizName: quiz.name),
                  ),
                ),
                onEdit: () async {
                  final updated = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizFormScreen(editingQuiz: quiz),
                    ),
                  );
                  if (updated == true && context.mounted) {
                    context.read<QuizzesCubit>().loadQuizzes();
                  }
                },
                onDelete: () => _onDeleteQuiz(context, quiz.name),
              );
            },
          ),
        );
      },
    );
  }
}
