import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubit/quiz_details_cubit.dart';
import '../widgets/quiz_details_body.dart';

class QuizDetailsScreen extends StatelessWidget {
  const QuizDetailsScreen({required this.quizName, super.key});

  final String quizName;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<QuizDetailsCubit>()..loadQuiz(quizName),
    child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: QuizDetailsBody(quizName: quizName),
    ),
  );
}
