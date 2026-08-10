import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/localization_extension.dart';
import '../cubit/quiz_details_cubit.dart';
import '../cubit/quiz_details_state.dart';
import '../widgets/quiz_read_only_tabs.dart';

class QuizSettingsScreen extends StatelessWidget {
  const QuizSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.quizTabSettings)),
    body: BlocBuilder<QuizDetailsCubit, QuizDetailsState>(
      builder: (context, state) {
        final quiz = state.quiz;
        if (quiz == null) return const SizedBox.shrink();

        return Column(
          children: [
            if (state.isUpdating)
              LinearProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
              ),
            Expanded(child: QuizSettingsTab(quiz: quiz)),
          ],
        );
      },
    ),
  );
}
