import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../../quiz/data/models/quiz_models.dart';
import '../cubit/question_bank_cubit.dart';
import '../cubit/question_bank_state.dart';
import '../widgets/question_bank_list.dart';
import '../widgets/question_bank_list_shimmer.dart';
import '../widgets/question_bank_state_views.dart';
import '../widgets/question_filter_bar.dart';

class QuestionCenterScreen extends StatefulWidget {
  const QuestionCenterScreen({super.key});

  @override
  State<QuestionCenterScreen> createState() => _QuestionCenterScreenState();
}

class _QuestionCenterScreenState extends State<QuestionCenterScreen> {
  late final QuestionBankCubit _cubit;
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = getIt<QuestionBankCubit>()..loadInitial();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      _cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<QuestionBankCubit, QuestionBankState>(
        listenWhen: (previous, current) =>
            previous.mutationError != current.mutationError ||
            previous.mutationSuccess != current.mutationSuccess,
        listener: _handleState,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text(context.l10n.questionCenterTitle)),
            body: RefreshIndicator(
              onRefresh: _cubit.refresh,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: QuestionFilterBar(
                      state: state,
                      searchController: _searchController,
                      onSearchChanged: _cubit.search,
                      onClearSearch: _clearSearch,
                      onTypeChanged: _cubit.updateType,
                      onCourseChanged: _cubit.updateCourse,
                      onChapterChanged: _cubit.updateChapter,
                      onLessonChanged: _cubit.updateLesson,
                      onQuizChanged: _cubit.updateQuiz,
                      onHomeworkChanged: _cubit.updateHomework,
                      onClearFilters: _cubit.clearFilters,
                    ),
                  ),
                  if (state.isFiltering ||
                      state.isRefreshing ||
                      state.isMutating)
                    const SliverToBoxAdapter(
                      child: LinearProgressIndicator(minHeight: 2),
                    ),
                  _CenterContent(state: state, cubit: _cubit),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _openForm(context),
              icon: const Icon(Icons.add),
              label: Text(context.l10n.questionAddTitle),
            ),
          );
        },
      ),
    );
  }

  void _handleState(BuildContext context, QuestionBankState state) {
    if (state.mutationError != null) {
      AppSnackBar.showError(context, state.mutationError!);
      _cubit.clearMutationState();
    } else if (state.mutationSuccess != null) {
      AppSnackBar.showSuccess(context, context.l10n.questionDeletedSuccess);
      _cubit.clearMutationState();
    }
  }

  Future<void> _openForm(
    BuildContext context, {
    QuestionModel? question,
  }) async {
    final changed = await Navigator.pushNamed(
      context,
      AppRouteNames.questionForm,
      arguments: question,
    );
    if (changed != null) {
      await _cubit.refresh();
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _cubit.search('');
  }
}

class _CenterContent extends StatelessWidget {
  const _CenterContent({required this.state, required this.cubit});

  final QuestionBankState state;
  final QuestionBankCubit cubit;

  @override
  Widget build(BuildContext context) {
    if (state.isInitialLoading) {
      return const QuestionBankListShimmer();
    }
    final error = state.errorMessage;
    if (error != null && state.loadedQuestions.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: QuestionBankErrorView(
          message: error,
          onRetry: cubit.loadInitial,
        ),
      );
    }
    final screen = context
        .findAncestorStateOfType<_QuestionCenterScreenState>()!;
    return QuestionBankList(
      questions: state.visibleQuestions,
      selectedQuestions: const {},
      hasNextPage: state.hasNextPage,
      isLoadingMore: state.isLoadingMore,
      hasActiveFilters:
          state.filters.hasActiveFilters || state.searchText.isNotEmpty,
      onRefresh: cubit.refresh,
      onLoadMore: cubit.loadMore,
      onToggle: (question) => screen._openForm(context, question: question),
      onEdit: (question) => screen._openForm(context, question: question),
      onDelete: (question) => cubit.deleteQuestion(question.name),
    );
  }
}
