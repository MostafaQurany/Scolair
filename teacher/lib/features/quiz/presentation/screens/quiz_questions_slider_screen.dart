import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quiz_details_cubit.dart';
import '../cubit/quiz_details_state.dart';
import '../widgets/question_form_body.dart';
import '../../../question/presentation/screens/question_bank_screen.dart';
import '../../../question/presentation/widgets/question_type_label.dart';

import '../widgets/quiz_slider_app_bar.dart';
import '../widgets/quiz_slider_body.dart';
import '../widgets/quiz_slider_bottom_bar.dart';
import 'quiz_questions_slider_screen_draft.dart';

class QuizQuestionsSliderScreen extends StatefulWidget {
  const QuizQuestionsSliderScreen({
    required this.quiz,
    required this.initialIndex,
    super.key,
  });

  final QuizModel quiz;
  final int initialIndex;

  @override
  State<QuizQuestionsSliderScreen> createState() =>
      _QuizQuestionsSliderScreenState();
}

class _QuizQuestionsSliderScreenState extends State<QuizQuestionsSliderScreen> {
  late final PageController _pageController;
  late int _currentIndex;
  late List<GlobalKey<QuestionFormBodyState>> _formKeys;
  final List<DraftQuestion> _drafts = [];
  final Set<String> _pendingDeletions = {};
  bool _wasBatchSaving = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _initDrafts();
  }

  void _initDrafts() {
    for (final q in widget.quiz.questions) {
      _drafts.add(
        DraftQuestion(
          existingQuizQuestionId: q.name,
          originalData: q,
          marks: q.marks,
        ),
      );
    }
    if (_drafts.isEmpty) _drafts.add(DraftQuestion());
    _initFormKeys();
  }

  void _initFormKeys() {
    _formKeys = List.generate(
      _drafts.length,
      (_) => GlobalKey<QuestionFormBodyState>(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  void _goToBank() async {
    final blocked = _drafts
        .map((d) => d.existingQuizQuestionId ?? d.sourceBankQuestionName)
        .whereType<String>()
        .toSet();

    final selected = await Navigator.push<List<QuestionModel>>(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionBankScreen(
          blockedTypes: _blockedBankTypes(),
          blockedQuestionNames: blocked,
        ),
      ),
    );

    if (selected != null && selected.isNotEmpty && mounted) {
      setState(() {
        if (_drafts.length == 1 && _drafts[0].isEmptyDraft) {
          _drafts.clear();
        }
        for (final q in selected) {
          _drafts.add(
            DraftQuestion(
              sourceBankQuestionName: q.name,
              bankData: q,
              marks: 1,
            ),
          );
        }
        _initFormKeys();
      });
      if (mounted) {
        AppSnackBar.showSuccess(
          context,
          context.l10n.questionsAddedFromBank(selected.length),
        );
      }
    }
  }

  bool _saveCurrentQuestionLocally() {
    final formKey = _formKeys[_currentIndex];
    final bodyData = formKey.currentState?.getFormData();
    if (bodyData == null) return false;

    final marks = formKey.currentState?.getMarks() ?? 1;

    setState(() {
      _drafts[_currentIndex].inlineData = bodyData;
      _drafts[_currentIndex].marks = marks;
    });
    return true;
  }

  void _onNext() {
    if (_saveCurrentQuestionLocally()) {
      if (_currentIndex < _drafts.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void _onAddNew() {
    if (_saveCurrentQuestionLocally()) {
      setState(() {
        _drafts.add(DraftQuestion());
        _initFormKeys();
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onDone() {
    _saveCurrentQuestionLocally();

    final additions = <Map<String, dynamic>>[];
    final marksUpdates = <Map<String, dynamic>>[];
    final deletions = Set<String>.from(_pendingDeletions);

    for (int i = 0; i < _drafts.length; i++) {
      final draft = _drafts[i];
      if (draft.isEmptyDraft) continue;

      // Ensure we don't allow partially filled drafts
      if (draft.inlineData == null &&
          draft.bankData == null &&
          draft.originalData == null) {
        AppSnackBar.showError(
          context,
          context.l10n.pleaseCompleteQuestion(i + 1),
        );
        _pageController.jumpToPage(i);
        return;
      }

      final payload = draft.toPayload();
      if (payload != null) {
        additions.add(payload);
        // If an existing question was edited (inline payload), we must delete the original
        if (draft.existingQuizQuestionId != null) {
          deletions.add(draft.existingQuizQuestionId!);
        }
      } else if (draft.existingQuizQuestionId != null) {
        final marksPayload = draft.toMarksPayload();
        if (marksPayload != null) {
          marksUpdates.add(marksPayload);
        }
        // If it's an existing question that wasn't edited, ensure it's not in pendingDeletions
        // (This handles the case where it might have been restored to original state)
        deletions.remove(draft.existingQuizQuestionId!);
      }
    }

    if (additions.isEmpty && deletions.isEmpty && marksUpdates.isEmpty) {
      Navigator.pop(context);
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.confirm),
        content: Text(
          context.l10n.questionsChangesConfirm(
            marksUpdates.length,
            additions.length,
            deletions.length,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(context.l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<QuizDetailsCubit>().saveQuizQuestions(
                additions,
                deletions,
                marksUpdates: marksUpdates,
              );
            },
            child: Text(context.l10n.confirm),
          ),
        ],
      ),
    );
  }

  void _removeCurrentQuestion() {
    if (_drafts.isEmpty) return;

    final draft = _drafts[_currentIndex];
    if (draft.existingQuizQuestionId != null) {
      _pendingDeletions.add(draft.existingQuizQuestionId!);
    }

    setState(() {
      _drafts.removeAt(_currentIndex);
      if (_drafts.isEmpty) {
        _drafts.add(DraftQuestion());
        _currentIndex = 0;
      } else if (_currentIndex >= _drafts.length) {
        _currentIndex = _drafts.length - 1;
      }
      _initFormKeys();
      _pageController.jumpToPage(_currentIndex);
    });
    AppSnackBar.showSuccess(context, context.l10n.questionRemoved);
  }

  QuestionModel? _buildInitialQuestion(int index) {
    if (index >= _drafts.length) return null;
    final draft = _drafts[index];

    if (draft.inlineData != null) {
      return _questionFromInline(draft);
    } else if (draft.bankData != null) {
      return draft.bankData;
    } else if (draft.originalData != null) {
      return _questionFromOriginal(draft.originalData!);
    }
    return null;
  }

  QuestionModel _questionFromInline(DraftQuestion draft) {
    final data = draft.inlineData!;
    final typeStr = data['type'] as String?;
    final type = switch (typeStr) {
      'User Input' => ApiQuestionType.userInput,
      'Open Ended' => ApiQuestionType.openEnded,
      'File Upload' => ApiQuestionType.fileUpload,
      _ => ApiQuestionType.choices,
    };

    return QuestionModel(
      name: draft.existingQuizQuestionId ?? draft.sourceBankQuestionName ?? '',
      question: data['question'] ?? '',
      type: type,
      multiple: data['multiple'] ?? 0,
      option1: data['option_1'],
      option2: data['option_2'],
      option3: data['option_3'],
      option4: data['option_4'],
      option5: data['option_5'],
      isCorrect1: data['is_correct_1'] ?? 0,
      isCorrect2: data['is_correct_2'] ?? 0,
      isCorrect3: data['is_correct_3'] ?? 0,
      isCorrect4: data['is_correct_4'] ?? 0,
      isCorrect5: data['is_correct_5'] ?? 0,
      explanation1: data['explanation_1'],
      explanation2: data['explanation_2'],
      explanation3: data['explanation_3'],
      explanation4: data['explanation_4'],
      explanation5: data['explanation_5'],
      possibility1: data['possibility_1'],
      possibility2: data['possibility_2'],
      possibility3: data['possibility_3'],
      possibility4: data['possibility_4'],
      possibility5: data['possibility_5'],
    );
  }

  Set<ApiQuestionType> _blockedBankTypes() {
    final existingTypes = widget.quiz.questions
        .map((question) => question.type ?? ApiQuestionType.choices)
        .toSet();
    final hasManual = existingTypes.any((type) => type.isManualGraded);
    final hasAuto = existingTypes.any((type) => !type.isManualGraded);
    if (hasManual) {
      return {ApiQuestionType.choices, ApiQuestionType.userInput};
    }
    if (hasAuto) {
      return {ApiQuestionType.openEnded, ApiQuestionType.fileUpload};
    }
    return const {};
  }

  QuestionModel _questionFromOriginal(QuizQuestionModel q) {
    return QuestionModel(
      name: q.question,
      question: q.questionDetail ?? q.question,
      type: q.type ?? ApiQuestionType.choices,
      multiple: q.multiple,
      option1: q.option1,
      option2: q.option2,
      option3: q.option3,
      option4: q.option4,
      option5: q.option5,
      isCorrect1: q.isCorrect1,
      isCorrect2: q.isCorrect2,
      isCorrect3: q.isCorrect3,
      isCorrect4: q.isCorrect4,
      isCorrect5: q.isCorrect5,
      explanation1: q.explanation1,
      explanation2: q.explanation2,
      explanation3: q.explanation3,
      explanation4: q.explanation4,
      explanation5: q.explanation5,
      possibility1: q.possibility1,
      possibility2: q.possibility2,
      possibility3: q.possibility3,
      possibility4: q.possibility4,
      possibility5: q.possibility5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPendingChanges =
        _pendingDeletions.isNotEmpty ||
        _drafts.any((d) => d.toPayload() != null || d.toMarksPayload() != null);

    return PopScope(
      canPop: !hasPendingChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final confirm = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(context.l10n.confirm),
            content: Text(context.l10n.unsavedChangesDiscard),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(context.l10n.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(context.l10n.discard),
              ),
            ],
          ),
        );
        if (confirm == true && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: BlocConsumer<QuizDetailsCubit, QuizDetailsState>(
        listener: (context, state) {
          if (_wasBatchSaving && !state.isBatchSaving) {
            if (state.mutationError != null && state.batchDeleteTotal == 0) {
              // Failed during additions phase
              AppSnackBar.showError(context, state.mutationError!);
            } else {
              // Finished deletions phase
              if (state.batchDeleteFailures.isNotEmpty) {
                AppSnackBar.showError(
                  context,
                  context.l10n.quizUpdatedWithErrors(
                    state.batchDeleteFailures.length,
                  ),
                );
              } else {
                AppSnackBar.showSuccess(context, context.l10n.quizSavedSuccess);
              }
              Navigator.pop(context);
            }
          }
          _wasBatchSaving = state.isBatchSaving;
        },
        builder: (context, quizState) {
          final isLastSlide = _currentIndex == _drafts.length - 1;

          return Stack(
            children: [
              Scaffold(
                appBar: SliderAppBar(
                  currentIndex: _currentIndex,
                  total: _drafts.length,
                  onDelete: _removeCurrentQuestion,
                  onBank: isLastSlide ? _goToBank : null,
                ),
                body: SliderBody(
                  pageController: _pageController,
                  onPageChanged: _onPageChanged,
                  drafts: _drafts,
                  formKeys: _formKeys,
                  buildInitialQuestion: _buildInitialQuestion,
                ),
                bottomNavigationBar: SliderBottomBar(
                  currentIndex: _currentIndex,
                  isLastSlide: isLastSlide,
                  onBack: _onBack,
                  onNext: _onNext,
                  onAddNew: _onAddNew,
                  onDone: _onDone,
                  onSave: _onSaveLocally,
                ),
              ),
              if (quizState.isBatchSaving)
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              value: quizState.batchDeleteTotal > 0
                                  ? quizState.batchDeleteCompleted /
                                        quizState.batchDeleteTotal
                                  : null,
                            ),
                            SizedBox(height: 16.h),
                            Text(context.l10n.savingQuiz),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _onBack() {
    _saveCurrentQuestionLocally();
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onSaveLocally() {
    _saveCurrentQuestionLocally();
    AppSnackBar.showSuccess(context, context.l10n.questionSavedDraft);
  }
}
