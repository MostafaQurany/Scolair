import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class QuestionOptionTile extends StatelessWidget {
  const QuestionOptionTile({
    required this.label,
    required this.controller,
    required this.isCorrect,
    required this.onSelectCorrect,
    this.onRemove,
    super.key,
  });

  final String label;
  final TextEditingController controller;
  final bool isCorrect;
  final VoidCallback onSelectCorrect;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              isCorrect ? Icons.check_circle : Icons.circle_outlined,
              color: isCorrect ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: onSelectCorrect,
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(labelText: label),
            ),
          ),
          if (onRemove != null)
            IconButton(icon: const Icon(Icons.close), onPressed: onRemove),
        ],
      ),
    );
  }
}
