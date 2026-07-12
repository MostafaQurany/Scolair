import 'package:flutter/widgets.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../quiz/data/models/quiz_models.dart';

extension QuestionTypeLabel on ApiQuestionType {
  String label(BuildContext context) {
    return switch (this) {
      ApiQuestionType.choices => context.l10n.questionTypeChoices,
      ApiQuestionType.userInput => context.l10n.questionTypeUserInput,
      ApiQuestionType.openEnded => context.l10n.questionTypeOpenEnded,
      ApiQuestionType.fileUpload => context.l10n.questionTypeFileUpload,
    };
  }

  bool get isManualGraded {
    return this == ApiQuestionType.openEnded ||
        this == ApiQuestionType.fileUpload;
  }
}
