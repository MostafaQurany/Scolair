import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/extensions/adaptive_layout_extension.dart';
import '../../../../core/localization/localization_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quiz_details_cubit.dart';
import 'quiz_section_card.dart';

/// Settings tab with grouped card sections matching the
/// Stitch "Quiz Settings & Configuration" design.
class QuizSettingsTab extends StatefulWidget {
  const QuizSettingsTab({required this.quiz, super.key});

  final QuizModel quiz;

  @override
  State<QuizSettingsTab> createState() => _QuizSettingsTabState();
}

class _QuizSettingsTabState extends State<QuizSettingsTab> {
  late bool _shuffleQuestions;
  late bool _showAnswers;
  late bool _enableNegativeMarking;

  late TextEditingController _marksToCutCtrl;
  late TextEditingController _maxAttemptsCtrl;
  late TextEditingController _limitQuestionsCtrl;

  @override
  void initState() {
    super.initState();
    _syncFromQuiz(widget.quiz);
  }

  @override
  void didUpdateWidget(covariant QuizSettingsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.quiz != oldWidget.quiz) {
      _syncFromQuiz(widget.quiz);
    }
  }

  void _syncFromQuiz(QuizModel quiz) {
    _shuffleQuestions = quiz.shuffleQuestions == 1;
    _showAnswers = quiz.showAnswers == 1;
    _enableNegativeMarking = quiz.enableNegativeMarking == 1;

    _marksToCutCtrl = TextEditingController(text: '${quiz.marksToCut}');
    _maxAttemptsCtrl = TextEditingController(text: '${quiz.maxAttempts}');
    _limitQuestionsCtrl = TextEditingController(
      text: '${quiz.limitQuestionsTo}',
    );
  }

  @override
  void dispose() {
    _marksToCutCtrl.dispose();
    _maxAttemptsCtrl.dispose();
    _limitQuestionsCtrl.dispose();
    super.dispose();
  }

  void _saveSettings() {
    final settings = {
      'shuffle_questions': _shuffleQuestions ? 1 : 0,
      'show_answers': _showAnswers ? 1 : 0,
      'enable_negative_marking': _enableNegativeMarking ? 1 : 0,
      'marks_to_cut':
          int.tryParse(_marksToCutCtrl.text) ?? widget.quiz.marksToCut,
      'max_attempts':
          int.tryParse(_maxAttemptsCtrl.text) ?? widget.quiz.maxAttempts,
      'limit_questions_to':
          int.tryParse(_limitQuestionsCtrl.text) ??
          widget.quiz.limitQuestionsTo,
    };
    context.read<QuizDetailsCubit>().updateSettings(settings);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTabletLayout;
    final pad = isTablet ? 24.0.w : 16.0.w;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: pad, vertical: 16.h),
      children: [
        if (isTablet) _tabletLayout() else _mobileLayout(),
        SizedBox(height: 24.h),
        FilledButton(
          onPressed: _saveSettings,
          child: Text(context.l10n.quizSaveSettings),
        ),
      ],
    );
  }

  Widget _mobileLayout() => Column(
    children: [
      _buildGradingSection(),
      SizedBox(height: 16.h),
      _buildBehaviorSection(),
    ],
  );

  Widget _tabletLayout() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: _buildGradingSection()),
      SizedBox(width: 16.w),
      Expanded(child: _buildBehaviorSection()),
    ],
  );

  Widget _buildGradingSection() => QuizSectionCard(
    title: context.l10n.quizGradingLimits,
    children: [
      TextFormField(
        controller: _maxAttemptsCtrl,
        decoration: InputDecoration(
          labelText: context.l10n.quizMaxAttemptsLabel,
          helperText: context.l10n.quizMaxAttemptsHelper,
        ),
        keyboardType: TextInputType.number,
      ),
      SizedBox(height: 14.h),
      TextFormField(
        controller: _limitQuestionsCtrl,
        decoration: InputDecoration(
          labelText: context.l10n.quizLimitQuestions,
          helperText: context.l10n.quizLimitQuestionsHelper,
        ),
        keyboardType: TextInputType.number,
      ),
      SizedBox(height: 14.h),
      TextFormField(
        controller: _marksToCutCtrl,
        decoration: InputDecoration(labelText: context.l10n.quizMarksToCut),
        keyboardType: TextInputType.number,
      ),
    ],
  );

  Widget _buildBehaviorSection() => QuizSectionCard(
    title: context.l10n.quizBehavior,
    children: [
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(context.l10n.quizShuffleQuestions),
        value: _shuffleQuestions,
        onChanged: (val) => setState(() => _shuffleQuestions = val),
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(context.l10n.quizShowCorrectAnswersToggle),
        value: _showAnswers,
        onChanged: (val) => setState(() => _showAnswers = val),
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(context.l10n.quizNegativeMarkingToggle),
        value: _enableNegativeMarking,
        onChanged: (val) => setState(() => _enableNegativeMarking = val),
      ),
    ],
  );
}
