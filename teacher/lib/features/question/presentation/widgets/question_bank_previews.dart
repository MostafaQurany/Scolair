import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../quiz/data/models/quiz_models.dart';
import 'question_bank_list.dart';
import 'question_bank_list_shimmer.dart';
import 'question_bank_state_views.dart';

const _sampleQuestion = QuestionModel(
  name: 'QTS-2026-00009',
  question:
      'Which of the following can be added to a course in Frappe Learning?',
  type: ApiQuestionType.choices,
  option1: 'Lessons',
  option2: 'Issues',
  isCorrect1: 1,
);

Widget _previewShell(Widget child) => ScreenUtilPlusInit(
    designSize: const Size(390, 844),
    builder: (context, _) => MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    ),
  );

@Preview(name: 'Question bank loading', group: 'Question Bank')
Widget questionBankLoadingPreview() => _previewShell(
    const CustomScrollView(slivers: [QuestionBankListShimmer()]),
  );

@Preview(name: 'Question bank empty', group: 'Question Bank')
Widget questionBankEmptyPreview() => _previewShell(const QuestionBankEmptyView(hasActiveFilters: false));

@Preview(name: 'Question bank filtered', group: 'Question Bank')
Widget questionBankFilteredPreview() => _previewShell(
    CustomScrollView(
      slivers: [
        QuestionBankList(
          questions: const [_sampleQuestion],
          selectedQuestions: const {},
          hasNextPage: false,
          isLoadingMore: false,
          hasActiveFilters: true,
          onRefresh: () async {},
          onLoadMore: () {},
          onToggle: (_) {},
        ),
      ],
    ),
  );

@Preview(name: 'Question bank selected', group: 'Question Bank')
Widget questionBankSelectedPreview() => _previewShell(
    CustomScrollView(
      slivers: [
        QuestionBankList(
          questions: const [_sampleQuestion],
          selectedQuestions: const {'QTS-2026-00009': _sampleQuestion},
          hasNextPage: false,
          isLoadingMore: false,
          hasActiveFilters: false,
          onRefresh: () async {},
          onLoadMore: () {},
          onToggle: (_) {},
        ),
      ],
    ),
  );

@Preview(name: 'Question bank error', group: 'Question Bank')
Widget questionBankErrorPreview() => _previewShell(
    QuestionBankErrorView(message: 'Unable to load questions.', onRetry: () {}),
  );
