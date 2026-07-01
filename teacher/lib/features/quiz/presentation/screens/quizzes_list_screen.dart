import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quizzes_cubit.dart';
import '../cubit/quizzes_state.dart';
import '../widgets/quiz_card.dart';
import '../widgets/quiz_filter_chip.dart';
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
              const _QuizFilters(),
              SizedBox(height: 8.h),
              const Expanded(child: _QuizzesBody()),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuizFilters extends StatelessWidget {
  const _QuizFilters();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizzesCubit, QuizzesState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            QuizFilterChip(
              label: context.l10n.quizFilterAll,
              selected: state.typeFilter == null,
              value: null,
              onSelected: context.read<QuizzesCubit>().filterByType,
            ),
            QuizFilterChip(
              label: context.l10n.quizTypeQuiz,
              selected: state.typeFilter == QuizType.quiz,
              value: QuizType.quiz,
              onSelected: context.read<QuizzesCubit>().filterByType,
            ),
            QuizFilterChip(
              label: context.l10n.quizTypeMidterm,
              selected: state.typeFilter == QuizType.midterm,
              value: QuizType.midterm,
              onSelected: context.read<QuizzesCubit>().filterByType,
            ),
            QuizFilterChip(
              label: context.l10n.quizTypeFinal,
              selected: state.typeFilter == QuizType.final_,
              value: QuizType.final_,
              onSelected: context.read<QuizzesCubit>().filterByType,
            ),
          ],
        );
      },
    );
  }
}

class _QuizzesBody extends StatelessWidget {
  const _QuizzesBody();

  Future<void> _editQuiz(BuildContext context, QuizModel quiz) async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => QuizFormScreen(editingQuiz: quiz)),
    );
    if (updated == true && context.mounted) {
      context.read<QuizzesCubit>().loadQuizzes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizzesCubit, QuizzesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.errorMessage != null) {
          return _ErrorState(message: state.errorMessage!);
        }
        final quizzes = (state.quizzes ?? const [])
            .where(
              (quiz) =>
                  state.typeFilter == null || quiz.type == state.typeFilter,
            )
            .toList();

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
                    builder: (_) => QuizDetailsScreen(quizId: quiz.id),
                  ),
                ),
                onEdit: () => _editQuiz(context, quiz),
              );
            },
          ),
        );
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            FilledButton(
              onPressed: context.read<QuizzesCubit>().loadQuizzes,
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
