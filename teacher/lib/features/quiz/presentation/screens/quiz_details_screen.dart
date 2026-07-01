import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../cubit/quiz_details_cubit.dart';
import '../cubit/quiz_details_state.dart';
import 'question_form_screen.dart';
import '../widgets/questions_tab_view.dart';
import '../widgets/quiz_details_header_card.dart';
import '../widgets/quiz_read_only_tabs.dart';
import '../widgets/quiz_viewer_role.dart';

class QuizDetailsScreen extends StatelessWidget {
  const QuizDetailsScreen({
    required this.quizId,
    this.viewerRole = QuizViewerRole.teacher,
    super.key,
  });

  final String quizId;
  final QuizViewerRole viewerRole;

  bool get _isTeacher => viewerRole == QuizViewerRole.teacher;

  @override
  Widget build(BuildContext context) {
    final tabCount = _isTeacher ? 4 : 2;

    return BlocProvider(
      create: (_) => getIt<QuizDetailsCubit>()..loadQuiz(quizId),
      child: DefaultTabController(
        length: tabCount,
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.quizDetailsTitle),
            actions: [
              if (_isTeacher)
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizDetailsScreen(
                        quizId: quizId,
                        viewerRole: QuizViewerRole.student,
                      ),
                    ),
                  ),
                  child: Text(context.l10n.quizPreviewAction),
                ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(text: context.l10n.quizTabDetails),
                Tab(text: context.l10n.quizTabQuestions),
                if (_isTeacher) ...[
                  Tab(text: context.l10n.quizTabSettings),
                  Tab(text: context.l10n.quizTabResults),
                ],
              ],
            ),
          ),
          body: _QuizDetailsBody(viewerRole: viewerRole),
        ),
      ),
    );
  }
}

class _QuizDetailsBody extends StatelessWidget {
  const _QuizDetailsBody({required this.viewerRole});

  final QuizViewerRole viewerRole;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizDetailsCubit, QuizDetailsState>(
      listener: (context, state) {
        final mutationError = state.mutationError;
        if (mutationError != null) {
          AppSnackBar.showError(context, mutationError);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        final errorMessage = state.errorMessage;
        if (errorMessage != null) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }
        final quiz = state.quiz;
        if (quiz == null) return const SizedBox.shrink();

        final isTeacher = viewerRole == QuizViewerRole.teacher;

        return TabBarView(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: QuizDetailsHeaderCard(quiz: quiz),
            ),
            QuestionsTabView(
              quiz: quiz,
              viewerRole: viewerRole,
              onAddQuestion: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuestionFormScreen(quizId: quiz.id),
                ),
              ),
              onEditQuestion: (question) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuestionFormScreen(
                    quizId: quiz.id,
                    editingQuestion: question,
                  ),
                ),
              ),
              onDuplicateQuestion: (question) =>
                  context.read<QuizDetailsCubit>().duplicateQuestion(question),
              onDeleteQuestion: (question) =>
                  context.read<QuizDetailsCubit>().deleteQuestion(question.id),
            ),
            if (isTeacher) ...[
              QuizSettingsTab(quiz: quiz),
              QuizResultsTab(quiz: quiz),
            ],
          ],
        );
      },
    );
  }
}
