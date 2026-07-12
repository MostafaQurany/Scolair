import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../quiz/data/models/quiz_models.dart';
import 'question_bank_state_views.dart';
import 'question_selection_card.dart';

class QuestionBankList extends StatelessWidget {
  const QuestionBankList({
    required this.questions,
    required this.selectedQuestions,
    required this.hasNextPage,
    required this.isLoadingMore,
    required this.hasActiveFilters,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onToggle,
    this.disabledReasonFor,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final List<QuestionModel> questions;
  final Map<String, QuestionModel> selectedQuestions;
  final bool hasNextPage;
  final bool isLoadingMore;
  final bool hasActiveFilters;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final ValueChanged<QuestionModel> onToggle;
  final String? Function(QuestionModel question)? disabledReasonFor;
  final ValueChanged<QuestionModel>? onEdit;
  final ValueChanged<QuestionModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: QuestionBankEmptyView(hasActiveFilters: hasActiveFilters),
      );
    }

    final showFooter = hasNextPage || isLoadingMore;
    return SliverPadding(
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 8.h, 16.w, 96.h),
      sliver: SliverList.builder(
        itemCount: questions.length + (showFooter ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= questions.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          }

          final question = questions[index];
          return QuestionSelectionCard(
            question: question,
            isSelected: selectedQuestions.containsKey(question.name),
            disabledReason: disabledReasonFor?.call(question),
            onTap: () => onToggle(question),
            onEdit: onEdit == null ? null : () => onEdit!(question),
            onDelete: onDelete == null ? null : () => onDelete!(question),
          );
        },
      ),
    );
  }
}
