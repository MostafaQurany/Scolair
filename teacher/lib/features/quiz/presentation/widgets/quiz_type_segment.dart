import 'package:flutter/material.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../data/models/quiz_models.dart';

class QuizTypeSegment extends StatelessWidget {
  const QuizTypeSegment({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final QuizType value;
  final ValueChanged<QuizType> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<QuizType>(
      segments: [
        ButtonSegment(
          value: QuizType.quiz,
          label: Text(context.l10n.quizTypeQuiz),
        ),
        ButtonSegment(
          value: QuizType.midterm,
          label: Text(context.l10n.quizTypeMidterm),
        ),
        ButtonSegment(
          value: QuizType.final_,
          label: Text(context.l10n.quizTypeFinal),
        ),
      ],
      selected: {value},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
