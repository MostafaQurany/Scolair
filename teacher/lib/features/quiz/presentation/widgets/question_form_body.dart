import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';
import 'question_form_sections.dart';
import 'quiz_section_card.dart';

class QuestionFormBody extends StatefulWidget {
  const QuestionFormBody({
    this.initialQuestion,
    this.initialMarks = 1,
    super.key,
  });

  final QuestionModel? initialQuestion;
  final int initialMarks;

  @override
  State<QuestionFormBody> createState() => QuestionFormBodyState();
}

class QuestionFormBodyState extends State<QuestionFormBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _questionController;
  late final TextEditingController _option1Controller;
  late final TextEditingController _option2Controller;
  late final TextEditingController _option3Controller;
  late final TextEditingController _option4Controller;
  late final TextEditingController _option5Controller;
  late final TextEditingController _explanation1Controller;
  late final TextEditingController _explanation2Controller;
  late final TextEditingController _explanation3Controller;
  late final TextEditingController _explanation4Controller;
  late final TextEditingController _explanation5Controller;
  late final TextEditingController _possibility1Controller;
  late final TextEditingController _possibility2Controller;
  late final TextEditingController _possibility3Controller;
  late final TextEditingController _possibility4Controller;
  late final TextEditingController _possibility5Controller;
  late final TextEditingController _marksController;
  ApiQuestionType _type = ApiQuestionType.choices;
  bool _multiple = false;
  List<int> _correctOptions = [1];

  bool get isEditing => widget.initialQuestion != null;

  @override
  void initState() {
    super.initState();
    final q = widget.initialQuestion;
    _questionController = TextEditingController(text: q?.question ?? '');
    _option1Controller = TextEditingController(text: q?.option1 ?? '');
    _option2Controller = TextEditingController(text: q?.option2 ?? '');
    _option3Controller = TextEditingController(text: q?.option3 ?? '');
    _option4Controller = TextEditingController(text: q?.option4 ?? '');
    _option5Controller = TextEditingController(text: q?.option5 ?? '');
    _explanation1Controller = TextEditingController(
      text: q?.explanation1 ?? '',
    );
    _explanation2Controller = TextEditingController(
      text: q?.explanation2 ?? '',
    );
    _explanation3Controller = TextEditingController(
      text: q?.explanation3 ?? '',
    );
    _explanation4Controller = TextEditingController(
      text: q?.explanation4 ?? '',
    );
    _explanation5Controller = TextEditingController(
      text: q?.explanation5 ?? '',
    );
    _possibility1Controller = TextEditingController(
      text: q?.possibility1 ?? '',
    );
    _possibility2Controller = TextEditingController(
      text: q?.possibility2 ?? '',
    );
    _possibility3Controller = TextEditingController(
      text: q?.possibility3 ?? '',
    );
    _possibility4Controller = TextEditingController(
      text: q?.possibility4 ?? '',
    );
    _possibility5Controller = TextEditingController(
      text: q?.possibility5 ?? '',
    );
    _marksController = TextEditingController(
      text: widget.initialMarks.toString(),
    );
    _type = q?.type ?? ApiQuestionType.choices;
    _multiple = (q?.multiple ?? 0) == 1;
    if (q != null) {
      _correctOptions = [];
      if (q.isCorrect1 == 1) _correctOptions.add(1);
      if (q.isCorrect2 == 1) _correctOptions.add(2);
      if (q.isCorrect3 == 1) _correctOptions.add(3);
      if (q.isCorrect4 == 1) _correctOptions.add(4);
      if (q.isCorrect5 == 1) _correctOptions.add(5);
      if (_correctOptions.isEmpty) _correctOptions = [1];
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    _option5Controller.dispose();
    _explanation1Controller.dispose();
    _explanation2Controller.dispose();
    _explanation3Controller.dispose();
    _explanation4Controller.dispose();
    _explanation5Controller.dispose();
    _possibility1Controller.dispose();
    _possibility2Controller.dispose();
    _possibility3Controller.dispose();
    _possibility4Controller.dispose();
    _possibility5Controller.dispose();
    _marksController.dispose();
    super.dispose();
  }

  void _toggleCorrect(int index) {
    setState(() {
      if (_multiple) {
        if (_correctOptions.contains(index)) {
          _correctOptions.remove(index);
        } else {
          _correctOptions.add(index);
        }
      } else {
        _correctOptions = [index];
      }
    });
  }

  Map<String, dynamic>? getFormData() {
    if (!_formKey.currentState!.validate()) return null;

    final body = <String, dynamic>{
      'question': _questionController.text.trim(),
      'type': _type == ApiQuestionType.choices
          ? 'Choices'
          : _type == ApiQuestionType.userInput
          ? 'User Input'
          : 'Open Ended',
    };

    if (isEditing) {
      body['question'] = widget.initialQuestion!.name;
    }

    if (_type == ApiQuestionType.choices) {
      _addNonEmpty(body, 'option_1', _option1Controller);
      _addNonEmpty(body, 'option_2', _option2Controller);
      _addNonEmpty(body, 'option_3', _option3Controller);
      _addNonEmpty(body, 'option_4', _option4Controller);
      _addNonEmpty(body, 'option_5', _option5Controller);
      body['is_correct_1'] = _correctOptions.contains(1) ? 1 : 0;
      body['is_correct_2'] = _correctOptions.contains(2) ? 1 : 0;
      body['is_correct_3'] = _correctOptions.contains(3) ? 1 : 0;
      body['is_correct_4'] = _correctOptions.contains(4) ? 1 : 0;
      body['is_correct_5'] = _correctOptions.contains(5) ? 1 : 0;
      _addNonEmpty(body, 'explanation_1', _explanation1Controller);
      _addNonEmpty(body, 'explanation_2', _explanation2Controller);
      _addNonEmpty(body, 'explanation_3', _explanation3Controller);
      _addNonEmpty(body, 'explanation_4', _explanation4Controller);
      _addNonEmpty(body, 'explanation_5', _explanation5Controller);
      if (_multiple) body['multiple'] = 1;
    } else if (_type == ApiQuestionType.userInput) {
      _addNonEmpty(body, 'possibility_1', _possibility1Controller);
      _addNonEmpty(body, 'possibility_2', _possibility2Controller);
      _addNonEmpty(body, 'possibility_3', _possibility3Controller);
      _addNonEmpty(body, 'possibility_4', _possibility4Controller);
      _addNonEmpty(body, 'possibility_5', _possibility5Controller);
    }
    return body;
  }

  int getMarks() {
    return int.tryParse(_marksController.text.trim()) ?? 1;
  }

  void _addNonEmpty(
    Map<String, dynamic> body,
    String key,
    TextEditingController controller,
  ) {
    final value = controller.text.trim();
    if (value.isNotEmpty) body[key] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: QuestionTypeSelector(
                  value: _type,
                  onChanged: (type) => setState(() => _type = type),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: _marksController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: context.l10n
                        .questionPointsLabel(0)
                        .split(' ')[1], // Quick hack for "Points"
                  ),
                  validator: (value) {
                  if (value == null || value.trim().isEmpty) { return 'Required'; }
                  if (int.tryParse(value.trim()) == null) { return 'Invalid'; }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          QuizSectionCard(
            title: context.l10n.questionTextLabel,
            children: [
              TextFormField(
                controller: _questionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: context.l10n.questionTextLabel,
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.l10n.questionTextRequired;
                  }
                  return null;
                },
              ),
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.image_outlined),
                  label: Text(context.l10n.questionAttachMedia),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (_type == ApiQuestionType.choices) ...[
            ChoicesSection(
              option1: _option1Controller,
              option2: _option2Controller,
              option3: _option3Controller,
              option4: _option4Controller,
              option5: _option5Controller,
              explanation1: _explanation1Controller,
              explanation2: _explanation2Controller,
              explanation3: _explanation3Controller,
              explanation4: _explanation4Controller,
              explanation5: _explanation5Controller,
              correctOptions: _correctOptions,
              multiple: _multiple,
              onToggleCorrect: _toggleCorrect,
              onMultipleChanged: (v) => setState(() => _multiple = v),
            ),
          ] else if (_type == ApiQuestionType.userInput) ...[
            UserInputSection(
              possibility1: _possibility1Controller,
              possibility2: _possibility2Controller,
              possibility3: _possibility3Controller,
              possibility4: _possibility4Controller,
              possibility5: _possibility5Controller,
            ),
          ] else ...[
            const OpenEndedHint(),
          ],
        ],
      ),
    );
  }
}
