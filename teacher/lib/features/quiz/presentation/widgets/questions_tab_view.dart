import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';
import 'question_card.dart';
import 'quiz_viewer_role.dart';

class QuestionsTabView extends StatelessWidget {
  const QuestionsTabView({
    required this.quiz,
    required this.onAddQuestion,
    required this.onEditQuestion,
    required this.onDuplicateQuestion,
    required this.onDeleteQuestion,
    this.viewerRole = QuizViewerRole.teacher,
    super.key,
  });

  final QuizModel quiz;
  final VoidCallback onAddQuestion;
  final ValueChanged<QuestionModel> onEditQuestion;
  final ValueChanged<QuestionModel> onDuplicateQuestion;
  final ValueChanged<QuestionModel> onDeleteQuestion;
  final QuizViewerRole viewerRole;

  bool get _isTeacher => viewerRole == QuizViewerRole.teacher;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isTeacher)
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Text(
                  '${quiz.totalPoints}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  context.l10n.quizPointsSuffix,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: null,
                          icon: const Icon(
                            Icons.inventory_2_outlined,
                            size: 16,
                          ),
                          label: Text(context.l10n.quizImportFromBank),
                        ),
                        SizedBox(width: 8.w),
                        FilledButton.icon(
                          onPressed: onAddQuestion,
                          icon: const Icon(Icons.add, size: 16),
                          label: Text(context.l10n.quizAddQuestion),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: quiz.questions.isEmpty
              ? _EmptyQuestions(
                  onAddQuestion: _isTeacher ? onAddQuestion : null,
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: quiz.questions.length,
                  itemBuilder: (context, index) {
                    final question = quiz.questions[index];
                    return QuestionCard(
                      index: index + 1,
                      question: question,
                      viewerRole: viewerRole,
                      onEdit: () => onEditQuestion(question),
                      onDuplicate: () => onDuplicateQuestion(question),
                      onDelete: () => onDeleteQuestion(question),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _EmptyQuestions extends StatelessWidget {
  const _EmptyQuestions({required this.onAddQuestion});

  final VoidCallback? onAddQuestion;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.quiz_outlined,
              size: 48.r,
              color: colorScheme.outlineVariant,
            ),
            SizedBox(height: 12.h),
            Text(
              context.l10n.quizNoQuestionsTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 4.h),
            Text(
              context.l10n.quizNoQuestionsMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onAddQuestion != null) ...[
              SizedBox(height: 16.h),
              FilledButton.icon(
                onPressed: onAddQuestion,
                icon: const Icon(Icons.add),
                label: Text(context.l10n.quizAddQuestion),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
