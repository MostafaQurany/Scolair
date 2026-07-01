import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/quiz_form_cubit.dart';
import '../cubit/quiz_form_state.dart';
import '../widgets/forms/quiz_form_fields.dart';
import '../widgets/quiz_bottom_action_bar.dart';
import '../widgets/quiz_section_card.dart';
import '../widgets/quiz_type_segment.dart';
import '../widgets/security_results_accordion.dart';

class QuizFormScreen extends StatefulWidget {
  const QuizFormScreen({this.editingQuiz, super.key});

  final QuizModel? editingQuiz;

  @override
  State<QuizFormScreen> createState() => _QuizFormScreenState();
}

class _QuizFormScreenState extends State<QuizFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _durationController;
  late final TextEditingController _maxGradeController;
  late final TextEditingController _minPassingController;
  late final TextEditingController _maxAttemptsController;
  QuizType _type = QuizType.quiz;
  QuizFormat _format = QuizFormat.online;
  DateTime? _startDateTime;
  bool _randomizeQuestions = false;
  bool _randomizeAnswers = false;
  bool _showResultImmediately = false;
  bool _showCorrectAnswers = false;
  bool _allowRetake = false;
  bool _preventLateSubmission = false;

  @override
  void initState() {
    super.initState();
    final quiz = widget.editingQuiz;
    _titleController = TextEditingController(text: quiz?.title ?? '');
    _descriptionController = TextEditingController(
      text: quiz?.description ?? '',
    );
    _durationController = TextEditingController(
      text: (quiz?.durationMinutes ?? 90).toString(),
    );
    _maxGradeController = TextEditingController(
      text: (quiz?.maxGrade ?? 100).toString(),
    );
    _minPassingController = TextEditingController(
      text: (quiz?.minPassing ?? 60).toString(),
    );
    _maxAttemptsController = TextEditingController(
      text: (quiz?.maxAttempts ?? 1).toString(),
    );
    _type = quiz?.type ?? QuizType.quiz;
    _format = quiz?.format ?? QuizFormat.online;
    _startDateTime = quiz?.startDateTime;
    _randomizeQuestions = quiz?.randomizeQuestions ?? false;
    _randomizeAnswers = quiz?.randomizeAnswers ?? false;
    _showResultImmediately = quiz?.showResultImmediately ?? false;
    _showCorrectAnswers = quiz?.showCorrectAnswers ?? false;
    _allowRetake = quiz?.allowRetake ?? false;
    _preventLateSubmission = quiz?.preventLateSubmission ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _maxGradeController.dispose();
    _minPassingController.dispose();
    _maxAttemptsController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDateTime ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startDateTime ?? DateTime.now()),
    );
    if (time == null) return;
    setState(() {
      _startDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    if (_startDateTime == null) return;

    final quiz = QuizModel(
      id: widget.editingQuiz?.id ?? '',
      type: _type,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      format: _format,
      startDateTime: _startDateTime!,
      durationMinutes: int.tryParse(_durationController.text) ?? 90,
      maxGrade: int.tryParse(_maxGradeController.text) ?? 100,
      minPassing: int.tryParse(_minPassingController.text) ?? 60,
      timelineStatus:
          widget.editingQuiz?.timelineStatus ?? QuizTimelineStatus.upcoming,
      totalStudents: widget.editingQuiz?.totalStudents ?? 0,
      submittedCount: widget.editingQuiz?.submittedCount ?? 0,
      gradedCount: widget.editingQuiz?.gradedCount ?? 0,
      questions: widget.editingQuiz?.questions ?? const [],
      randomizeQuestions: _randomizeQuestions,
      randomizeAnswers: _randomizeAnswers,
      showResultImmediately: _showResultImmediately,
      showCorrectAnswers: _showCorrectAnswers,
      allowRetake: _allowRetake,
      preventLateSubmission: _preventLateSubmission,
      maxAttempts: int.tryParse(_maxAttemptsController.text) ?? 1,
    );

    final cubit = context.read<QuizFormCubit>();
    if (widget.editingQuiz == null) {
      cubit.createQuiz(quiz);
    } else {
      cubit.updateQuiz(quiz);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<QuizFormCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.quizCreateTitle),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(context.l10n.quizSaveDraft),
            ),
          ],
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

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.all(16.r),
                      children: [
                        QuizSectionCard(
                          title: context.l10n.quizAssessmentTypeSection,
                          children: [
                            QuizTypeSegment(
                              value: _type,
                              onChanged: (value) =>
                                  setState(() => _type = value),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        QuizSectionCard(
                          title: context.l10n.quizBasicInfoSection,
                          children: [
                            QuizBasicInfoFields(
                              titleController: _titleController,
                              descriptionController: _descriptionController,
                              format: _format,
                              onFormatChanged: (value) =>
                                  setState(() => _format = value),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        QuizSectionCard(
                          title: context.l10n.quizTimingSection,
                          children: [
                            QuizTimingFields(
                              startDateTime: _startDateTime,
                              onPickDateTime: _pickDateTime,
                              durationController: _durationController,
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        QuizSectionCard(
                          title: context.l10n.quizGradingSection,
                          children: [
                            QuizGradingFields(
                              maxGradeController: _maxGradeController,
                              minPassingController: _minPassingController,
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        SecurityResultsAccordion(
                          randomizeQuestions: _randomizeQuestions,
                          randomizeAnswers: _randomizeAnswers,
                          showResultImmediately: _showResultImmediately,
                          showCorrectAnswers: _showCorrectAnswers,
                          allowRetake: _allowRetake,
                          preventLateSubmission: _preventLateSubmission,
                          maxAttemptsController: _maxAttemptsController,
                          onRandomizeQuestionsChanged: (v) =>
                              setState(() => _randomizeQuestions = v),
                          onRandomizeAnswersChanged: (v) =>
                              setState(() => _randomizeAnswers = v),
                          onShowResultImmediatelyChanged: (v) =>
                              setState(() => _showResultImmediately = v),
                          onShowCorrectAnswersChanged: (v) =>
                              setState(() => _showCorrectAnswers = v),
                          onAllowRetakeChanged: (v) =>
                              setState(() => _allowRetake = v),
                          onPreventLateSubmissionChanged: (v) =>
                              setState(() => _preventLateSubmission = v),
                        ),
                      ],
                    ),
                  ),
                  QuizBottomActionBar(
                    isLoading: isLoading,
                    onSchedule: () => _submit(context),
                    onPublish: () => _submit(context),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
