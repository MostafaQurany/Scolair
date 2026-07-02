import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../cubit/quiz_details_cubit.dart';
import '../cubit/quiz_details_state.dart';
import 'question_form_screen.dart';
import '../widgets/questions_tab_view.dart';
import '../widgets/quiz_details_header_card.dart';
import '../widgets/quiz_read_only_tabs.dart';
import '../widgets/quiz_segment_bar.dart';

/// Displays full quiz details for the teacher: header, questions,
/// settings, and results — all in a single scrollable layout
/// driven by a [QuizSegmentBar] instead of a [TabBar].
class QuizDetailsScreen extends StatefulWidget {
  const QuizDetailsScreen({required this.quizId, super.key});

  final String quizId;

  @override
  State<QuizDetailsScreen> createState() => _QuizDetailsScreenState();
}

class _QuizDetailsScreenState extends State<QuizDetailsScreen> {
  final _pageController = PageController();
  final _selectedSection = ValueNotifier<int>(QuizSection.questions);

  @override
  void dispose() {
    _pageController.dispose();
    _selectedSection.dispose();
    super.dispose();
  }

  void _onSegmentChanged(int index) {
    _selectedSection.value = index;
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<QuizDetailsCubit>()..loadQuiz(widget.quizId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.quizDetailsTitle),
        ),
        body: BlocConsumer<QuizDetailsCubit, QuizDetailsState>(
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
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            }
            final quiz = state.quiz;
            if (quiz == null) return const SizedBox.shrink();

            return Column(
              children: [
                // Always-visible header (replaces the old "Details" tab).
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                  child: QuizDetailsHeaderCard(quiz: quiz),
                ),
                // Pill segment bar — inside the body, not in AppBar.
                ValueListenableBuilder<int>(
                  valueListenable: _selectedSection,
                  builder: (context, selected, _) => QuizSegmentBar(
                    selectedIndex: selected,
                    onChanged: _onSegmentChanged,
                  ),
                ),
                // PageView content area.
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    // Disable swipe so questions list scrolling isn't
                    // interrupted; users navigate via the segment bar.
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      _selectedSection.value = index;
                    },
                    children: [
                      QuestionsTabView(
                        quiz: quiz,
                        onAddQuestion: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                QuestionFormScreen(quizId: quiz.id),
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
                        onDuplicateQuestion: (question) => context
                            .read<QuizDetailsCubit>()
                            .duplicateQuestion(question),
                        onDeleteQuestion: (question) => context
                            .read<QuizDetailsCubit>()
                            .deleteQuestion(question.id),
                      ),
                      QuizSettingsTab(quiz: quiz),
                      QuizResultsTab(quiz: quiz),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
