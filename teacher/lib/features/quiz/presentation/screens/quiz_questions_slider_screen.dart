import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/adaptive_layout_extension.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quiz_details_cubit.dart';
import '../cubit/quiz_details_state.dart';
import '../widgets/question_form_body.dart';
import '../../../question/presentation/screens/question_bank_screen.dart';
import '../../../question/presentation/widgets/question_type_label.dart';

class _DraftQuestion {
  final String? existingQuestionId;
  final QuizQuestionModel? originalData;
  final QuestionModel? bankData;
  Map<String, dynamic>? inlineData;
  int marks;

  _DraftQuestion({
    this.existingQuestionId,
    this.originalData,
    this.bankData,
    this.marks = 1,
  });

  Map<String, dynamic> toPayload() {
    if (inlineData != null) {
      return {'inline': inlineData, 'marks': marks};
    } else if (existingQuestionId != null) {
      return {'question': existingQuestionId, 'marks': marks};
    }
    return {};
  }
}

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
  final List<_DraftQuestion> _drafts = [];

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
        _DraftQuestion(
          existingQuestionId: q.question,
          originalData: q,
          marks: q.marks,
        ),
      );
    }
    if (_drafts.isEmpty) _drafts.add(_DraftQuestion());
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
    final selected = await Navigator.push<List<QuestionModel>>(
      context,
      MaterialPageRoute(
        builder: (_) => QuestionBankScreen(blockedTypes: _blockedBankTypes()),
      ),
    );

    if (selected != null && selected.isNotEmpty && mounted) {
      setState(() {
        if (_drafts.length == 1 &&
            _drafts[0].existingQuestionId == null &&
            _drafts[0].inlineData == null &&
            _drafts[0].bankData == null &&
            _drafts[0].originalData == null) {
          _drafts.clear();
        }
        for (final q in selected) {
          _drafts.add(
            _DraftQuestion(existingQuestionId: q.name, bankData: q, marks: 1),
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
        _drafts.add(_DraftQuestion());
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

    final payload = _drafts.map((d) => d.toPayload()).toList();
    payload.removeWhere((element) => element.isEmpty);
    context.read<QuizDetailsCubit>().updateSettings({'questions': payload});

    if (mounted) {
      AppSnackBar.showSuccess(context, context.l10n.quizSavedSuccess);
      Navigator.pop(context);
    }
  }

  void _removeCurrentQuestion() {
    if (_drafts.isEmpty) return;

    setState(() {
      _drafts.removeAt(_currentIndex);
      if (_drafts.isEmpty) {
        _drafts.add(_DraftQuestion());
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

  QuestionModel _questionFromInline(_DraftQuestion draft) {
    final data = draft.inlineData!;
    final typeStr = data['type'] as String?;
    final type = switch (typeStr) {
      'User Input' => ApiQuestionType.userInput,
      'Open Ended' => ApiQuestionType.openEnded,
      'File Upload' => ApiQuestionType.fileUpload,
      _ => ApiQuestionType.choices,
    };

    return QuestionModel(
      name: draft.existingQuestionId ?? '',
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
    return BlocBuilder<QuizDetailsCubit, QuizDetailsState>(
      builder: (context, quizState) {
        final isLastSlide = _currentIndex == _drafts.length - 1;

        return Scaffold(
          appBar: _SliderAppBar(
            currentIndex: _currentIndex,
            total: _drafts.length,
            onDelete: _removeCurrentQuestion,
            onBank: isLastSlide ? _goToBank : null,
          ),
          body: _SliderBody(
            pageController: _pageController,
            onPageChanged: _onPageChanged,
            drafts: _drafts,
            formKeys: _formKeys,
            buildInitialQuestion: _buildInitialQuestion,
          ),
          bottomNavigationBar: _SliderBottomBar(
            currentIndex: _currentIndex,
            isLastSlide: isLastSlide,
            onBack: _onBack,
            onNext: _onNext,
            onAddNew: _onAddNew,
            onDone: _onDone,
            onSave: _onSaveLocally,
          ),
        );
      },
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

class _SliderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _SliderAppBar({
    required this.currentIndex,
    required this.total,
    required this.onDelete,
    this.onBank,
  });

  final int currentIndex;
  final int total;
  final VoidCallback onDelete;
  final VoidCallback? onBank;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      leadingWidth: 20.w,
      title: Text(
        context.l10n.questionOfTotal(currentIndex + 1, total),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 1.w),
      actions: [
        if (onBank != null)
          TextButton.icon(
            onPressed: onBank,
            icon: Icon(Icons.library_books_outlined, size: 16.r),
            label: Text(context.l10n.questionBankTitle),
          ),
        IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          onPressed: onDelete,
        ),
      ],
    );
  }
}

class _SliderBody extends StatelessWidget {
  const _SliderBody({
    required this.pageController,
    required this.onPageChanged,
    required this.drafts,
    required this.formKeys,
    required this.buildInitialQuestion,
  });

  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final List<_DraftQuestion> drafts;
  final List<GlobalKey<QuestionFormBodyState>> formKeys;
  final QuestionModel? Function(int) buildInitialQuestion;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTabletLayout;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isTablet ? 720.w : double.infinity,
        ),
        child: PageView.builder(
          controller: pageController,
          onPageChanged: onPageChanged,
          itemCount: drafts.length,
          itemBuilder: (context, index) {
            final initialQuestion = buildInitialQuestion(index);
            final initialMarks = drafts[index].marks;

            return QuestionFormBody(
              key: formKeys[index],
              initialQuestion: initialQuestion,
              initialMarks: initialMarks,
            );
          },
        ),
      ),
    );
  }
}

class _SliderBottomBar extends StatelessWidget {
  const _SliderBottomBar({
    required this.currentIndex,
    required this.isLastSlide,
    required this.onBack,
    required this.onNext,
    required this.onAddNew,
    required this.onDone,
    required this.onSave,
  });

  final int currentIndex;
  final bool isLastSlide;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onAddNew;
  final VoidCallback onDone;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
        child: Row(
          children: [
            TextButton(
              onPressed: currentIndex > 0 ? onBack : null,
              child: Text(context.l10n.back),
            ),
            const Spacer(),
            if (isLastSlide) ...[
              FilledButton(onPressed: onDone, child: Text(context.l10n.done)),
              SizedBox(width: 8.w),
              OutlinedButton(
                onPressed: onAddNew,
                child: Text(context.l10n.addNew),
              ),
            ] else ...[
              OutlinedButton(
                onPressed: onSave,
                child: Text(context.l10n.saveLocally),
              ),
              SizedBox(width: 8.w),
              FilledButton(onPressed: onNext, child: Text(context.l10n.next)),
            ],
          ],
        ),
      ),
    );
  }
}
