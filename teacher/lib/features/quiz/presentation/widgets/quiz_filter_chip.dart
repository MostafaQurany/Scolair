import 'package:flutter/material.dart';

import '../../data/models/quiz_models.dart';

class QuizFilterChip extends StatelessWidget {
  const QuizFilterChip({
    required this.label,
    required this.selected,
    required this.value,
    required this.onSelected,
    super.key,
  });

  final String label;
  final bool selected;
  final QuizType? value;
  final ValueChanged<QuizType?> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(value),
    );
  }
}
