import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../../core/extensions/adaptive_layout_extension.dart';
import '../../data/models/quiz_models.dart';
import '../screens/quiz_questions_slider_screen_draft.dart';
import 'question_form_body.dart';

class SliderBody extends StatelessWidget {
  const SliderBody({
    required this.pageController,
    required this.onPageChanged,
    required this.drafts,
    required this.formKeys,
    required this.buildInitialQuestion,
  });

  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final List<DraftQuestion> drafts;
  final List<GlobalKey<QuestionFormBodyState>> formKeys;
  final QuestionModel? Function(int) buildInitialQuestion;

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTabletLayout;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isTablet ? 720.w : double.infinity,
        ),
        child: PageView.builder(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
          itemCount: drafts.length,
          itemBuilder: (context, index) {
            final initialQuestion = buildInitialQuestion(index);
            final initialMarks = drafts[index].marks;

            return QuestionFormBody(
              key: formKeys[index],
              initialQuestion: initialQuestion,
              initialMarks: initialMarks,
            );
          },
        ),
      ),
    );
  }
}
