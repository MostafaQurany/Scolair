import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../../quiz/data/models/quiz_models.dart';
import '../cubit/question_bank_cubit.dart';
import '../cubit/question_bank_state.dart';
import '../widgets/question_bank_bottom_bar.dart';
import '../widgets/question_bank_list.dart';
import '../widgets/question_bank_list_shimmer.dart';
import '../widgets/question_bank_state_views.dart';
import '../widgets/question_filter_bar.dart';
import '../widgets/question_type_label.dart';

class QuestionBankScreenArgs {
  const QuestionBankScreenArgs({
    this.blockedTypes = const {},
    this.blockedQuestionNames = const {},
    this.confirmLabel,
  });

  final Set<ApiQuestionType> blockedTypes;
  final Set<String> blockedQuestionNames;
  final String? confirmLabel;
}

class QuestionBankScreen extends StatefulWidget {
  const QuestionBankScreen({
    this.blockedTypes = const {},
    this.blockedQuestionNames = const {},
    this.confirmLabel,
    super.key,
  });

  final Set<ApiQuestionType> blockedTypes;
  final Set<String> blockedQuestionNames;
  final String? confirmLabel;

  @override
  State<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends State<QuestionBankScreen> {
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
  Widget build(BuildContext context) => BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<QuestionBankCubit, QuestionBankState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          final message = state.errorMessage;
          if (message != null) AppSnackBar.showError(context, message);
        },
        builder: (context, state) => Scaffold(
            appBar: AppBar(title: Text(context.l10n.questionBankTitle)),
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
                  if (state.isFiltering || state.isRefreshing)
                    const SliverToBoxAdapter(
                      child: LinearProgressIndicator(minHeight: 2),
                    ),
                  _BankContent(state: state, cubit: _cubit),
                ],
              ),
            ),
            bottomNavigationBar: QuestionBankBottomBar(
              selectedCount: state.selectedQuestions.length,
              onClear: _cubit.clearSelection,
              onCancel: () => Navigator.pop(context),
              onConfirm: state.selectedQuestions.isEmpty
                  ? null
                  : () => Navigator.pop(
                      context,
                      state.selectedQuestions.values.toList(growable: false),
                    ),
              confirmLabel: widget.confirmLabel ?? context.l10n.addToQuiz,
            ),
          ),
      ),
    );

  void _clearSearch() {
    _searchController.clear();
    _cubit.search('');
  }

  String? _disabledReasonFor(BuildContext context, QuestionModel question) {
    if (widget.blockedQuestionNames.contains(question.name)) {
      return 'Already in quiz';
    }
    if (!widget.blockedTypes.contains(question.type)) return null;
    return question.type.isManualGraded
        ? context.l10n.questionBankManualTypeBlocked
        : context.l10n.questionBankAutoTypeBlocked;
  }
}

class _BankContent extends StatelessWidget {
  const _BankContent({required this.state, required this.cubit});

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
    final screen = context.findAncestorStateOfType<_QuestionBankScreenState>()!;
    return QuestionBankList(
      questions: state.visibleQuestions,
      selectedQuestions: state.selectedQuestions,
      hasNextPage: state.hasNextPage,
      isLoadingMore: state.isLoadingMore,
      hasActiveFilters:
          state.filters.hasActiveFilters || state.searchText.isNotEmpty,
      onRefresh: cubit.refresh,
      onLoadMore: cubit.loadMore,
      onToggle: cubit.toggleSelection,
      disabledReasonFor: (question) =>
          screen._disabledReasonFor(context, question),
    );
  }
}
