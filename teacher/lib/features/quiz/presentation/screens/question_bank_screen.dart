import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/extensions/adaptive_layout_extension.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/question_bank_cubit.dart';
import '../cubit/question_bank_state.dart';
import '../widgets/question_type_badge.dart';
import '../widgets/quiz_state_widgets.dart';

/// Question Bank screen with multi-select, search, and
/// filter chips matching the Stitch design.
class QuestionBankScreen extends StatefulWidget {
  const QuestionBankScreen({super.key});

  @override
  State<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends State<QuestionBankScreen> {
  final Set<String> _selectedNames = {};
  final List<QuestionModel> _selectedQuestions = [];
  final _scrollController = ScrollController();
  late final QuestionBankCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<QuestionBankCubit>();
    _cubit.fetchQuestions();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _cubit.fetchQuestions();
    }
  }

  void _toggleSelection(QuestionModel q) {
    setState(() {
      if (_selectedNames.contains(q.name)) {
        _selectedNames.remove(q.name);
        _selectedQuestions.removeWhere((item) => item.name == q.name);
      } else {
        _selectedNames.add(q.name);
        _selectedQuestions.add(q);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedNames.clear();
      _selectedQuestions.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: _BankAppBar(onSearch: _cubit.search),
        body: _BankBody(
          scrollController: _scrollController,
          selectedNames: _selectedNames,
          onToggle: _toggleSelection,
        ),
        bottomNavigationBar: _BankBottomBar(
          selectedCount: _selectedQuestions.length,
          onClear: _clearSelection,
          onConfirm: _selectedQuestions.isEmpty
              ? null
              : () => Navigator.pop(context, _selectedQuestions),
        ),
      ),
    );
  }
}

class _BankAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _BankAppBar({required this.onSearch});

  final ValueChanged<String> onSearch;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 64.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(context.l10n.questionBankTitle),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(64.h),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
          child: TextField(
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: context.l10n.search,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
            ),
          ),
        ),
      ),
    );
  }
}

class _BankBody extends StatelessWidget {
  const _BankBody({
    required this.scrollController,
    required this.selectedNames,
    required this.onToggle,
  });

  final ScrollController scrollController;
  final Set<String> selectedNames;
  final ValueChanged<QuestionModel> onToggle;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionBankCubit, QuestionBankState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const QuizQuestionsShimmer(),
          error: (msg) => QuizErrorState(
            message: msg,
            onRetry: () =>
                context.read<QuestionBankCubit>().fetchQuestions(refresh: true),
          ),
          loaded: (questions, hasReachedMax) {
            if (questions.isEmpty) {
              return QuizEmptyState(onAdd: () {});
            }
            return _QuestionsList(
              scrollController: scrollController,
              questions: questions,
              hasReachedMax: hasReachedMax,
              selectedNames: selectedNames,
              onToggle: onToggle,
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

class _QuestionsList extends StatelessWidget {
  const _QuestionsList({
    required this.scrollController,
    required this.questions,
    required this.hasReachedMax,
    required this.selectedNames,
    required this.onToggle,
  });

  final ScrollController scrollController;
  final List<QuestionModel> questions;
  final bool hasReachedMax;
  final Set<String> selectedNames;
  final ValueChanged<QuestionModel> onToggle;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTabletLayout;
    final pad = isTablet ? 24.0.w : 16.0.w;

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: 8.h),
      itemCount: questions.length + (hasReachedMax ? 0 : 1),
      itemBuilder: (context, index) {
        if (index >= questions.length) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: const CircularProgressIndicator(),
            ),
          );
        }
        final q = questions[index];
        final isSelected = selectedNames.contains(q.name);
        return _BankQuestionCard(
          question: q,
          isSelected: isSelected,
          onTap: () => onToggle(q),
        );
      },
    );
  }
}

class _BankQuestionCard extends StatelessWidget {
  const _BankQuestionCard({
    required this.question,
    required this.isSelected,
    required this.onTap,
  });

  final QuestionModel question;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.outlineVariant.withValues(alpha: 0.4),
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: (_) => onTap(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.question,
                        style: textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      QuestionTypeBadge(type: question.type),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BankBottomBar extends StatelessWidget {
  const _BankBottomBar({
    required this.selectedCount,
    required this.onClear,
    required this.onConfirm,
  });

  final int selectedCount;
  final VoidCallback onClear;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 14.h + bottomPadding),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedCount > 0)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.questionBankSelectedCount(selectedCount),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: onClear,
                    child: Text(context.l10n.questionBankClear),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.l10n.cancel),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: FilledButton(
                  onPressed: onConfirm,
                  child: Text(context.l10n.addToQuiz),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
