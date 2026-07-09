import '../../../quiz/data/models/quiz_models.dart';

class QuestionFilterData {
  const QuestionFilterData({
    this.type,
    this.quiz,
    this.homework,
    this.lesson,
    this.chapter,
    this.course,
  });

  final ApiQuestionType? type;
  final String? quiz;
  final String? homework;
  final String? lesson;
  final String? chapter;
  final String? course;

  bool get hasActiveFilters =>
      type != null ||
      quiz != null ||
      homework != null ||
      lesson != null ||
      chapter != null ||
      course != null;

  QuestionFilterData copyWith({
    Object? type = _unset,
    Object? quiz = _unset,
    Object? homework = _unset,
    Object? lesson = _unset,
    Object? chapter = _unset,
    Object? course = _unset,
  }) {
    return QuestionFilterData(
      type: identical(type, _unset) ? this.type : type as ApiQuestionType?,
      quiz: identical(quiz, _unset) ? this.quiz : quiz as String?,
      homework: identical(homework, _unset)
          ? this.homework
          : homework as String?,
      lesson: identical(lesson, _unset) ? this.lesson : lesson as String?,
      chapter: identical(chapter, _unset) ? this.chapter : chapter as String?,
      course: identical(course, _unset) ? this.course : course as String?,
    );
  }

  QuestionFilterData clearCourseTree() {
    return copyWith(course: null, chapter: null, lesson: null);
  }
}

const Object _unset = Object();

String? apiQuestionTypeValue(ApiQuestionType? type) {
  return switch (type) {
    ApiQuestionType.choices => 'Choices',
    ApiQuestionType.userInput => 'User Input',
    ApiQuestionType.openEnded => 'Open Ended',
    ApiQuestionType.fileUpload => 'File Upload',
    null => null,
  };
}
