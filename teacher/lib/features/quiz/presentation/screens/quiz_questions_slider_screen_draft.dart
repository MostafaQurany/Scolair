import '../../data/models/quiz_models.dart';

class DraftQuestion {
  final String? existingQuizQuestionId;
  final QuizQuestionModel? originalData;
  final String? sourceBankQuestionName;
  final QuestionModel? bankData;
  Map<String, dynamic>? inlineData;
  int marks;

  DraftQuestion({
    this.existingQuizQuestionId,
    this.originalData,
    this.sourceBankQuestionName,
    this.bankData,
    this.marks = 1,
  });

  bool get isEdited {
    if (inlineData == null) return false;
    final Map<String, dynamic> compareTo;
    if (originalData != null) {
      compareTo = {
        'question': originalData!.questionDetail ?? originalData!.question,
        'type': _typeToString(originalData!.type ?? ApiQuestionType.choices),
        'multiple': originalData!.multiple,
        'option_1': originalData!.option1,
        'option_2': originalData!.option2,
        'option_3': originalData!.option3,
        'option_4': originalData!.option4,
        'option_5': originalData!.option5,
        'is_correct_1': originalData!.isCorrect1,
        'is_correct_2': originalData!.isCorrect2,
        'is_correct_3': originalData!.isCorrect3,
        'is_correct_4': originalData!.isCorrect4,
        'is_correct_5': originalData!.isCorrect5,
        'explanation_1': originalData!.explanation1,
        'explanation_2': originalData!.explanation2,
        'explanation_3': originalData!.explanation3,
        'explanation_4': originalData!.explanation4,
        'explanation_5': originalData!.explanation5,
        'possibility_1': originalData!.possibility1,
        'possibility_2': originalData!.possibility2,
        'possibility_3': originalData!.possibility3,
        'possibility_4': originalData!.possibility4,
        'possibility_5': originalData!.possibility5,
      };
    } else if (bankData != null) {
      compareTo = {
        'question': bankData!.question,
        'type': _typeToString(bankData!.type),
        'multiple': bankData!.multiple,
        'option_1': bankData!.option1,
        'option_2': bankData!.option2,
        'option_3': bankData!.option3,
        'option_4': bankData!.option4,
        'option_5': bankData!.option5,
        'is_correct_1': bankData!.isCorrect1,
        'is_correct_2': bankData!.isCorrect2,
        'is_correct_3': bankData!.isCorrect3,
        'is_correct_4': bankData!.isCorrect4,
        'is_correct_5': bankData!.isCorrect5,
        'explanation_1': bankData!.explanation1,
        'explanation_2': bankData!.explanation2,
        'explanation_3': bankData!.explanation3,
        'explanation_4': bankData!.explanation4,
        'explanation_5': bankData!.explanation5,
        'possibility_1': bankData!.possibility1,
        'possibility_2': bankData!.possibility2,
        'possibility_3': bankData!.possibility3,
        'possibility_4': bankData!.possibility4,
        'possibility_5': bankData!.possibility5,
      };
    } else {
      return true; // New draft is considered edited if it has inlineData
    }

    final currentType = inlineData!['type'] as String?;
    bool isDifferent(String key) {
      final val1 = _normalize(inlineData![key]);
      final val2 = _normalize(compareTo[key]);
      return val1 != val2;
    }

    if (isDifferent('question') || isDifferent('type')) return true;

    if (currentType == 'Choices') {
      if (isDifferent('multiple')) return true;
      for (int i = 1; i <= 5; i++) {
        if (isDifferent('option_$i')) return true;
        if (isDifferent('is_correct_$i')) return true;
        if (isDifferent('explanation_$i')) return true;
      }
    } else if (currentType == 'User Input') {
      for (int i = 1; i <= 5; i++) {
        if (isDifferent('possibility_$i')) return true;
      }
    }

    return false;
  }

  String _typeToString(ApiQuestionType type) {
    return switch (type) {
      ApiQuestionType.choices => 'Choices',
      ApiQuestionType.userInput => 'User Input',
      ApiQuestionType.openEnded => 'Open Ended',
      ApiQuestionType.fileUpload => 'File Upload',
    };
  }

  dynamic _normalize(dynamic value) {
    if (value == null) return '';
    if (value is String) return value.trim();
    if (value is int) {
      // Sometimes UI gives int boolean, sometimes server gives 0/1 or null
      return value.toString();
    }
    return value;
  }

  bool get isEmptyDraft =>
      originalData == null &&
      bankData == null &&
      (inlineData == null ||
          (inlineData!['question'] as String?)?.trim().isEmpty == true);

  Map<String, dynamic>? toPayload() {
    if (isEmptyDraft) return null;

    if (isEdited || (originalData == null && bankData == null)) {
      return {'inline': inlineData, 'marks': marks};
    }

    if (sourceBankQuestionName != null) {
      return {'question': sourceBankQuestionName, 'marks': marks};
    }

    // Existing question, not edited -> omit
    return null;
  }
}
