import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/constants/app_route_names.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../../quiz/data/models/quiz_models.dart';
import '../../../quiz/presentation/screens/quiz_questions_slider_screen_draft.dart';
import '../../../quiz/presentation/widgets/question_form_body.dart';
import '../../../quiz/presentation/widgets/quiz_slider_app_bar.dart';
import '../../../quiz/presentation/widgets/quiz_slider_body.dart';
import '../../../quiz/presentation/widgets/quiz_slider_bottom_bar.dart';
import '../../../question/presentation/screens/question_bank_screen.dart';
import '../../../question/presentation/widgets/question_type_label.dart';
import '../../domain/entities/homework_detail.dart';
import '../cubit/details/homework_details_cubit.dart';
import '../cubit/details/homework_details_state.dart';
import '../widgets/forms/marks_assignment_dialog.dart';

class HomeworkQuestionsSliderScreen extends StatefulWidget {
  const HomeworkQuestionsSliderScreen({
    required this.homework,
    super.key,
  });

  final HomeworkDetail homework;

  @override
  State<HomeworkQuestionsSliderScreen> createState() =>
      _HomeworkQuestionsSliderScreenState();
}

class _HomeworkQuestionsSliderScreenState
    extends State<HomeworkQuestionsSliderScreen> {
  late final PageController _pageController;
  late int _currentIndex;
  late List<GlobalKey<QuestionFormBodyState>> _formKeys;
  final List<DraftQuestion> _drafts = [];
  final Set<String> _pendingDeletions = {};
  bool _wasBatchSaving = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pageController = PageController(initialPage: _currentIndex);
    _initDrafts();
  }

  void _initDrafts() {
    for (final q in widget.homework.questions) {
      final qModel = _questionFromHomeworkItem(q);
      _drafts.add(
        DraftQuestion(
          existingQuizQuestionId: q.name,
          bankData: qModel,
          marks: q.marks,
          initialMarks: q.marks,
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

  QuestionModel _questionFromHomeworkItem(HomeworkQuestionItem q) {
    final type = switch (q.type) {
      'User Input' => ApiQuestionType.userInput,
      'Open Ended' => ApiQuestionType.openEnded,
      'File Upload' => ApiQuestionType.fileUpload,
      _ => ApiQuestionType.choices,
    };

    String? getOption(int index) =>
        q.options.length > index ? q.options[index] : null;
    int getCorrect(int index) => q.correctOptions.length > index
        ? (q.correctOptions[index] ? 1 : 0)
        : 0;
    String? getExplanation(int index) =>
        q.explanations.length > index ? q.explanations[index] : null;

    return QuestionModel(
      name: q.name,
      question: q.question,
      attachment: q.attachment,
      type: type,
      multiple: q.multiple ? 1 : 0,
      option1: getOption(0),
      option2: getOption(1),
      option3: getOption(2),
      option4: getOption(3),
      option5: getOption(4),
      isCorrect1: getCorrect(0),
      isCorrect2: getCorrect(1),
      isCorrect3: getCorrect(2),
      isCorrect4: getCorrect(3),
      isCorrect5: getCorrect(4),
      explanation1: getExplanation(0),
      explanation2: getExplanation(1),
      explanation3: getExplanation(2),
      explanation4: getExplanation(3),
      explanation5: getExplanation(4),
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

    final selected = (await Navigator.pushNamed(
      context,
      AppRouteNames.questionBank,
      arguments: QuestionBankScreenArgs(
        blockedTypes: _blockedBankTypes(),
        blockedQuestionNames: blocked,
      ),
    )) as List<QuestionModel>?;

    if (selected != null && selected.isNotEmpty && mounted) {
      final results = await showDialog<List<MarksAssignmentResult>>(
        context: context,
        builder: (_) => MarksAssignmentDialog(selectedQuestions: selected),
      );

      if (results != null && results.isNotEmpty && mounted) {
        setState(() {
          if (_drafts.length == 1 && _drafts[0].isEmptyDraft) {
            _drafts.clear();
          }
          for (final res in results) {
            _drafts.add(
              DraftQuestion(
                sourceBankQuestionName: res.question.name,
                bankData: res.question,
                marks: res.marks,
                initialMarks: res.marks,
              ),
            );
          }
          _initFormKeys();
        });
        if (mounted) {
          AppSnackBar.showSuccess(
            context,
            context.l10n.questionsAddedFromBank(results.length),
          );
        }
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
        if (draft.existingQuizQuestionId != null) {
          deletions.add(draft.existingQuizQuestionId!);
        }
      } else if (draft.existingQuizQuestionId != null) {
        final marksPayload = draft.toMarksPayload();
        if (marksPayload != null) {
          marksUpdates.add(marksPayload);
        }
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
              context.read<HomeworkDetailsCubit>().saveHomeworkQuestions(
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
    AppSnackBar.showSuccess(context, context.l10n.homeworkQuestionRemovedSuccess);
  }

  QuestionModel? _buildInitialQuestion(int index) {
    if (index >= _drafts.length) return null;
    final draft = _drafts[index];

    if (draft.inlineData != null) {
      return _questionFromInline(draft);
    } else if (draft.bankData != null) {
      return draft.bankData;
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
      attachment: data['attachment'],
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
    final existingTypes = widget.homework.questions
        .map((question) => switch (question.type) {
              'User Input' => ApiQuestionType.userInput,
              'Open Ended' => ApiQuestionType.openEnded,
              'File Upload' => ApiQuestionType.fileUpload,
              _ => ApiQuestionType.choices,
            })
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

  @override
  Widget build(BuildContext context) {
    final bool hasPendingChanges = _pendingDeletions.isNotEmpty ||
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
      child: BlocConsumer<HomeworkDetailsCubit, HomeworkDetailsState>(
        listener: (context, state) {
          if (_wasBatchSaving && !state.isBatchSaving) {
            if (state.errorMessage != null && state.batchErrors.isNotEmpty) {
              AppSnackBar.showError(
                context,
                context.l10n.homeworkQuestionsUpdatedWithErrors(
                  state.batchErrors.length,
                ),
              );
            } else if (state.errorMessage != null) {
              AppSnackBar.showError(context, state.errorMessage!);
            } else {
              AppSnackBar.showSuccess(
                  context, context.l10n.homeworkQuestionsUpdatedSuccess);
            }
            Navigator.pop(context);
          }
          _wasBatchSaving = state.isBatchSaving;
        },
        builder: (context, detailsState) {
          final isLastSlide = _currentIndex == _drafts.length - 1;
          final isLocked = detailsState.hasSubmissions;

          return Stack(
            children: [
              Scaffold(
                appBar: SliderAppBar(
                  currentIndex: _currentIndex,
                  total: _drafts.length,
                  onDelete: isLocked ? () {} : _removeCurrentQuestion,
                  onBank: (isLastSlide && !isLocked) ? _goToBank : null,
                ),
                body: Column(
                  children: [
                    if (isLocked)
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(16.r),
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .errorContainer
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.error),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.lock_outline,
                                color: Theme.of(context).colorScheme.error),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                context.l10n.homeworkQuestionsLocked,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.error,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: SliderBody(
                        pageController: _pageController,
                        onPageChanged: _onPageChanged,
                        drafts: _drafts,
                        formKeys: _formKeys,
                        buildInitialQuestion: _buildInitialQuestion,
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: isLocked
                    ? null
                    : SliderBottomBar(
                        currentIndex: _currentIndex,
                        isLastSlide: isLastSlide,
                        onBack: _onBack,
                        onNext: _onNext,
                        onAddNew: _onAddNew,
                        onDone: _onDone,
                        onSave: _onSaveLocally,
                      ),
              ),
              if (detailsState.isBatchSaving)
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
                              value: detailsState.batchTotal > 0
                                  ? detailsState.batchProgress /
                                      detailsState.batchTotal
                                  : null,
                            ),
                            SizedBox(height: 16.h),
                            Text(context.l10n.homeworkSavingQuestions),
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
