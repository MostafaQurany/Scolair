import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/extensions/adaptive_layout_extension.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quiz_form_cubit.dart';
import '../cubit/quiz_form_state.dart';
import '../widgets/quiz_section_card.dart';

class QuizFormScreen extends StatefulWidget {
  const QuizFormScreen({this.editingQuiz, super.key});

  final QuizSummaryModel? editingQuiz;

  @override
  State<QuizFormScreen> createState() => _QuizFormScreenState();
}

class _QuizFormScreenState extends State<QuizFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _passingPercentageController;
  late final TextEditingController _maxAttemptsController;
  late final TextEditingController _durationController;
  late final TextEditingController _marksToCutController;
  late final TextEditingController _limitQuestionsToController;
  bool _showAnswers = true;
  bool _shuffleQuestions = false;
  bool _enableNegativeMarking = false;

  bool get _isEditing => widget.editingQuiz != null;

  @override
  void initState() {
    super.initState();
    final quiz = widget.editingQuiz;
    _titleController = TextEditingController(text: quiz?.title ?? '');
    _passingPercentageController = TextEditingController(
      text: (quiz?.passingPercentage ?? 50).toString(),
    );
    _maxAttemptsController = TextEditingController(
      text: (quiz?.maxAttempts ?? 0).toString(),
    );
    _durationController = TextEditingController(text: quiz?.duration ?? '');
    _marksToCutController = TextEditingController(
      text: (quiz?.marksToCut ?? 1).toString(),
    );
    _limitQuestionsToController = TextEditingController(
      text: (quiz?.limitQuestionsTo ?? 0).toString(),
    );
    _showAnswers = (quiz?.showAnswers ?? 1) == 1;
    _shuffleQuestions = (quiz?.shuffleQuestions ?? 0) == 1;
    _enableNegativeMarking = (quiz?.enableNegativeMarking ?? 0) == 1;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _passingPercentageController.dispose();
    _maxAttemptsController.dispose();
    _durationController.dispose();
    _marksToCutController.dispose();
    _limitQuestionsToController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final body = <String, dynamic>{
      'title': _titleController.text.trim(),
      'passing_percentage':
          int.tryParse(_passingPercentageController.text) ?? 50,
      'max_attempts': int.tryParse(_maxAttemptsController.text) ?? 0,
      'show_answers': _showAnswers ? 1 : 0,
      'shuffle_questions': _shuffleQuestions ? 1 : 0,
      'enable_negative_marking': _enableNegativeMarking ? 1 : 0,
      'marks_to_cut': int.tryParse(_marksToCutController.text) ?? 1,
      'limit_questions_to': int.tryParse(_limitQuestionsToController.text) ?? 0,
    };

    final duration = _durationController.text.trim();
    if (duration.isNotEmpty) {
      body['duration'] = duration;
    }

    final cubit = context.read<QuizFormCubit>();
    if (_isEditing) {
      body['quiz'] = widget.editingQuiz!.name;
      cubit.updateQuiz(body);
    } else {
      cubit.createQuiz(body);
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<QuizFormCubit>(),
    child: Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(
            _isEditing
                ? context
                      .l10n
                      .quizCreateTitle // or edit title if available
                : context.l10n.quizCreateTitle,
          ),
        ),
        body: BlocConsumer<QuizFormCubit, QuizFormState>(
          listener: (context, state) {
            state.whenOrNull(
              success: () {
                AppSnackBar.showSuccess(context, context.l10n.quizSavedSuccess);
                Navigator.pop(context, true);
              },
              error: (message) => AppSnackBar.showError(context, message),
            );
          },
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              submitting: () => true,
              orElse: () => false,
            );

            return _QuizFormBody(
              formKey: _formKey,
              titleController: _titleController,
              passingPercentageController: _passingPercentageController,
              maxAttemptsController: _maxAttemptsController,
              durationController: _durationController,
              marksToCutController: _marksToCutController,
              limitQuestionsToController: _limitQuestionsToController,
              showAnswers: _showAnswers,
              shuffleQuestions: _shuffleQuestions,
              enableNegativeMarking: _enableNegativeMarking,
              onShowAnswersChanged: (v) => setState(() => _showAnswers = v),
              onShuffleQuestionsChanged: (v) =>
                  setState(() => _shuffleQuestions = v),
              onNegativeMarkingChanged: (v) =>
                  setState(() => _enableNegativeMarking = v),
              isLoading: isLoading,
              onSubmit: () => _submit(context),
            );
          },
        ),
      ),
    ),
  );
}

class _QuizFormBody extends StatelessWidget {
  const _QuizFormBody({
    required this.formKey,
    required this.titleController,
    required this.passingPercentageController,
    required this.maxAttemptsController,
    required this.durationController,
    required this.marksToCutController,
    required this.limitQuestionsToController,
    required this.showAnswers,
    required this.shuffleQuestions,
    required this.enableNegativeMarking,
    required this.onShowAnswersChanged,
    required this.onShuffleQuestionsChanged,
    required this.onNegativeMarkingChanged,
    required this.isLoading,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController passingPercentageController;
  final TextEditingController maxAttemptsController;
  final TextEditingController durationController;
  final TextEditingController marksToCutController;
  final TextEditingController limitQuestionsToController;
  final bool showAnswers;
  final bool shuffleQuestions;
  final bool enableNegativeMarking;
  final ValueChanged<bool> onShowAnswersChanged;
  final ValueChanged<bool> onShuffleQuestionsChanged;
  final ValueChanged<bool> onNegativeMarkingChanged;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTabletLayout;
    final pad = isTablet ? 24.0.w : 16.0.w;

    return Form(
      key: formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: pad, vertical: 16.h),
              children: [
                if (isTablet)
                  _tabletLayout(context)
                else
                  _mobileLayout(context),
              ],
            ),
          ),
          _BottomAction(isLoading: isLoading, onSubmit: onSubmit),
        ],
      ),
    );
  }

  Widget _mobileLayout(BuildContext context) => Column(
    children: [
      _buildGeneralSection(context),
      SizedBox(height: 16.h),
      _buildGradingSection(context),
      SizedBox(height: 16.h),
      _buildBehaviorSection(context),
    ],
  );

  Widget _tabletLayout(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 5,
        child: Column(
          children: [
            _buildGeneralSection(context),
            SizedBox(height: 16.h),
            _buildBehaviorSection(context),
          ],
        ),
      ),
      SizedBox(width: 16.w),
      Expanded(flex: 4, child: _buildGradingSection(context)),
    ],
  );

  Widget _buildGeneralSection(BuildContext context) => QuizSectionCard(
    title: context.l10n.quizGeneralDetails,
    children: [
      TextFormField(
        controller: titleController,
        decoration: InputDecoration(labelText: context.l10n.quizTitleLabel),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return context.l10n.quizTitleRequired;
          }
          return null;
        },
      ),
      SizedBox(height: 14.h),
      TextFormField(
        controller: durationController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: context.l10n.quizDurationLabel,
          hintText: context.l10n.quizDurationHint,
        ),
      ),
    ],
  );

  Widget _buildGradingSection(BuildContext context) => QuizSectionCard(
    title: context.l10n.quizGradingLimits,
    children: [
      TextFormField(
        controller: passingPercentageController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: context.l10n.quizPassingPercentage,
          suffixText: '%',
        ),
      ),
      SizedBox(height: 14.h),
      TextFormField(
        controller: maxAttemptsController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: context.l10n.quizMaxAttempts,
          helperText: context.l10n.quizMaxAttemptsHelper,
        ),
      ),
      SizedBox(height: 14.h),
      TextFormField(
        controller: limitQuestionsToController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: context.l10n.quizLimitQuestions,
          helperText: context.l10n.quizLimitQuestionsHelper,
        ),
      ),
    ],
  );

  Widget _buildBehaviorSection(BuildContext context) => QuizSectionCard(
    title: context.l10n.quizBehavior,
    children: [
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(context.l10n.quizShowAnswers),
        value: showAnswers,
        onChanged: onShowAnswersChanged,
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(context.l10n.quizShuffleQuestions),
        value: shuffleQuestions,
        onChanged: onShuffleQuestionsChanged,
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(context.l10n.quizEnableNegativeMarking),
        value: enableNegativeMarking,
        onChanged: onNegativeMarkingChanged,
      ),
      if (enableNegativeMarking)
        Padding(
          padding: EdgeInsets.only(top: 14.h),
          child: TextFormField(
            controller: marksToCutController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: context.l10n.quizMarksToCut),
          ),
        ),
    ],
  );
}

class _BottomAction extends StatelessWidget {
  const _BottomAction({required this.isLoading, required this.onSubmit});

  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final colorScheme = Theme.of(context).colorScheme;

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
      child: FilledButton(
        onPressed: isLoading ? null : onSubmit,
        style: FilledButton.styleFrom(minimumSize: Size(double.infinity, 52.h)),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(context.l10n.save),
      ),
    );
  }
}
