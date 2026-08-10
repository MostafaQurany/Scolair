import 'package:flutter/material.dart';

import '../../../../core/localization/localization_extension.dart';
import '../widgets/quiz_submissions_view.dart';

class QuizSubmissionsScreen extends StatelessWidget {
  const QuizSubmissionsScreen({required this.quizName, super.key});

  final String quizName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(context.l10n.quizSubmissionsTitle),
      ),
      body: QuizSubmissionsView(quizName: quizName),
    );
  }
}
