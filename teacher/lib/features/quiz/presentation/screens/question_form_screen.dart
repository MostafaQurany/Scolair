import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/localization/localization_extension.dart';
import '../../../../core/widgets/app_snack_bar.dart';
import '../../data/models/quiz_models.dart';
import '../cubit/question_form_cubit.dart';
import '../cubit/question_form_state.dart';
import '../widgets/forms/question_settings_fields.dart';
import '../widgets/question_type_body.dart';

class QuestionFormScreen extends StatefulWidget {
  const QuestionFormScreen({
    required this.quizId,
    this.editingQuestion,
    super.key,
  });

  final String quizId;
  final QuestionModel? editingQuestion;

  @override
  State<QuestionFormScreen> createState() => _QuestionFormScreenState();
}

class _QuestionFormScreenState extends State<QuestionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _textController;
  late final TextEditingController _pointsController;
  late final TextEditingController _acceptedAnswerController;
  late final TextEditingController _explanationController;
  late List<TextEditingController> _optionControllers;
  late List<bool> _optionCorrect;
  QuestionType _type = QuestionType.multipleChoice;
  QuestionDifficulty _difficulty = QuestionDifficulty.medium;
  bool _required = true;
  bool? _boolAnswer = true;

  @override
  void initState() {
    super.initState();
    final question = widget.editingQuestion;
    _textController = TextEditingController(text: question?.text ?? '');
    _pointsController = TextEditingController(
      text: (question?.points ?? 5).toString(),
    );
    _acceptedAnswerController = TextEditingController(
      text: question?.acceptedAnswer ?? '',
    );
    _explanationController = TextEditingController(
      text: question?.explanation ?? '',
    );
    _type = question?.type ?? QuestionType.multipleChoice;
    _difficulty = question?.difficulty ?? QuestionDifficulty.medium;
    _required = question?.required ?? true;
    _boolAnswer = question?.correctBoolAnswer ?? true;
    final options = question?.options ?? const [];
    _optionControllers = options.isEmpty
        ? List.generate(4, (_) => TextEditingController())
        : options.map((o) => TextEditingController(text: o.text)).toList();
    _optionCorrect = options.isEmpty
        ? List.generate(4, (index) => index == 0)
        : options.map((o) => o.isCorrect).toList();
  }

  @override
  void dispose() {
    _textController.dispose();
    _pointsController.dispose();
    _acceptedAnswerController.dispose();
    _explanationController.dispose();
    for (final controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    setState(() {
      _optionControllers.add(TextEditingController());
      _optionCorrect.add(false);
    });
  }

  void _removeOption(int index) {
    setState(() {
      _optionControllers.removeAt(index).dispose();
      _optionCorrect.removeAt(index);
    });
  }

  void _selectCorrectOption(int index) {
    setState(() {
      _optionCorrect = List.generate(_optionCorrect.length, (i) => i == index);
    });
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    final question = QuestionModel(
      id:
          widget.editingQuestion?.id ??
          'q_${DateTime.now().microsecondsSinceEpoch}',
      type: _type,
      text: _textController.text.trim(),
      points: int.tryParse(_pointsController.text) ?? 5,
      difficulty: _difficulty,
      required: _required,
      options: _type == QuestionType.multipleChoice
          ? List.generate(
              _optionControllers.length,
              (index) => QuestionOptionModel(
                id: 'opt_$index',
                text: _optionControllers[index].text.trim(),
                isCorrect: _optionCorrect[index],
              ),
            )
          : const [],
      correctBoolAnswer: _type == QuestionType.trueFalse ? _boolAnswer : null,
      acceptedAnswer: _type == QuestionType.shortAnswer
          ? _acceptedAnswerController.text.trim()
          : null,
      explanation: _explanationController.text.trim(),
    );

    final cubit = context.read<QuestionFormCubit>();
    if (widget.editingQuestion == null) {
      cubit.createQuestion(widget.quizId, question);
    } else {
      cubit.updateQuestion(widget.quizId, question);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editingQuestion != null;

    return BlocProvider(
      create: (_) => getIt<QuestionFormCubit>(),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(
              isEditing
                  ? context.l10n.questionEditTitle
                  : context.l10n.questionAddTitle,
            ),
            actions: [
              TextButton(
                onPressed: () => _submit(context),
                child: Text(context.l10n.save),
              ),
            ],
          ),
          body: BlocConsumer<QuestionFormCubit, QuestionFormState>(
            listener: (context, state) {
              state.whenOrNull(
                success: () {
                  AppSnackBar.showSuccess(
                    context,
                    context.l10n.questionSavedSuccess,
                  );
                  Navigator.pop(context, true);
                },
                error: (message) => AppSnackBar.showError(context, message),
              );
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(16.r),
                        children: [
                          QuestionTypeAndTextFields(
                            type: _type,
                            onTypeChanged: (value) =>
                                setState(() => _type = value),
                            textController: _textController,
                          ),
                          SizedBox(height: 16.h),
                          QuestionSettingsFields(
                            pointsController: _pointsController,
                            difficulty: _difficulty,
                            onDifficultyChanged: (value) =>
                                setState(() => _difficulty = value),
                            required: _required,
                            onRequiredChanged: (value) =>
                                setState(() => _required = value),
                          ),
                          SizedBox(height: 16.h),
                          QuestionTypeBody(
                            type: _type,
                            optionControllers: _optionControllers,
                            optionCorrect: _optionCorrect,
                            onAddOption: _addOption,
                            onRemoveOption: _removeOption,
                            onSelectCorrectOption: _selectCorrectOption,
                            boolAnswer: _boolAnswer,
                            onBoolAnswerChanged: (value) =>
                                setState(() => _boolAnswer = value),
                            acceptedAnswerController: _acceptedAnswerController,
                          ),
                          SizedBox(height: 16.h),
                          TextFormField(
                            controller: _explanationController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              labelText: context.l10n.questionExplanationLabel,
                              hintText: context.l10n.questionExplanationHint,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        16.w,
                        12.h,
                        16.w,
                        16.h + MediaQuery.of(context).padding.bottom,
                      ),
                      child: FilledButton(
                        onPressed: () => _submit(context),
                        style: FilledButton.styleFrom(
                          minimumSize: Size(double.infinity, 52.h),
                        ),
                        child: Text(context.l10n.questionSaveButton),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
