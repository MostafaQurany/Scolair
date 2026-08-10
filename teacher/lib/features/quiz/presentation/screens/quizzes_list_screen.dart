import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';

import '../cubit/quizzes_cubit.dart';
import '../cubit/quizzes_state.dart';
import '../widgets/quiz_card.dart';

class QuizzesListScreen extends StatelessWidget {
  const QuizzesListScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<QuizzesCubit>()..loadQuizzes(),
    child: const _QuizzesListView(),
  );
}

class _QuizzesListView extends StatelessWidget {
  const _QuizzesListView();

  Future<void> _createQuiz(BuildContext context) async {
    final created = await Navigator.pushNamed(context, AppRouteNames.quizForm);
    if (created == true && context.mounted) {
      unawaited(context.read<QuizzesCubit>().loadQuizzes());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: RefreshIndicator(
      onRefresh: context.read<QuizzesCubit>().loadQuizzes,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
            title: Text(context.l10n.quizzesTitle),
            floating: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: IconButton.filled(
                  onPressed: () => _createQuiz(context),
                  icon: const Icon(Icons.add),
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    iconSize: 24.r,
                    backgroundColor: AppColors.primaryPressed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: EdgeInsets.all(16.r),
              sliver: const _QuizzesBody(),
            ),
          ),
        ],
      ),
    ),
  );
}

class _QuizzesBody extends StatelessWidget {
  const _QuizzesBody();

  void _onDeleteQuiz(BuildContext context, String quizName) {
    context.read<QuizzesCubit>().deleteQuiz(quizName);
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<QuizzesCubit, QuizzesState>(
        listener: (context, state) {
          final error = state.errorMessage;
          if (error != null) {
            AppSnackBar.showError(context, error);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final quizzes = state.quizzes?.items ?? const [];

          if (quizzes.isEmpty) {
            return SliverFillRemaining(
              child: Center(child: Text(context.l10n.quizzesEmptyMessage)),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final quiz = quizzes[index];
              return QuizCard(
                quiz: quiz,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRouteNames.quizDetails,
                  arguments: quiz.name,
                ),
                onEdit: () async {
                  final updated = await Navigator.pushNamed(
                    context,
                    AppRouteNames.quizForm,
                    arguments: quiz,
                  );
                  if (updated == true && context.mounted) {
                    unawaited(context.read<QuizzesCubit>().loadQuizzes());
                  }
                },
                onDelete: () => _onDeleteQuiz(context, quiz.name),
              );
            }, childCount: quizzes.length),
          );
        },
      );
}
