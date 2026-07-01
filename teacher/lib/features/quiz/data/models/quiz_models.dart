enum QuizType { quiz, midterm, final_ }

enum QuizFormat { online, offline }

enum QuizTimelineStatus { upcoming, past }

enum QuizResultStatus { pending, graded, needsGrading }

enum QuestionType {
  multipleChoice,
  trueFalse,
  shortAnswer,
  essay,
  fillBlank,
  matching,
}

enum QuestionDifficulty { easy, medium, hard }

class QuestionOptionModel {
  const QuestionOptionModel({
    required this.id,
    required this.text,
    required this.isCorrect,
  });

  final String id;
  final String text;
  final bool isCorrect;

  QuestionOptionModel copyWith({String? text, bool? isCorrect}) =>
      QuestionOptionModel(
        id: id,
        text: text ?? this.text,
        isCorrect: isCorrect ?? this.isCorrect,
      );
}

class QuestionModel {
  const QuestionModel({
    required this.id,
    required this.type,
    required this.text,
    required this.points,
    required this.difficulty,
    required this.required,
    this.options = const [],
    this.correctBoolAnswer,
    this.acceptedAnswer,
    this.explanation,
  });

  final String id;
  final QuestionType type;
  final String text;
  final int points;
  final QuestionDifficulty difficulty;
  final bool required;
  final List<QuestionOptionModel> options;
  final bool? correctBoolAnswer;
  final String? acceptedAnswer;
  final String? explanation;

  QuestionModel copyWith({
    QuestionType? type,
    String? text,
    int? points,
    QuestionDifficulty? difficulty,
    bool? required,
    List<QuestionOptionModel>? options,
    bool? correctBoolAnswer,
    String? acceptedAnswer,
    String? explanation,
  }) => QuestionModel(
    id: id,
    type: type ?? this.type,
    text: text ?? this.text,
    points: points ?? this.points,
    difficulty: difficulty ?? this.difficulty,
    required: required ?? this.required,
    options: options ?? this.options,
    correctBoolAnswer: correctBoolAnswer ?? this.correctBoolAnswer,
    acceptedAnswer: acceptedAnswer ?? this.acceptedAnswer,
    explanation: explanation ?? this.explanation,
  );
}

class QuizModel {
  const QuizModel({
    required this.id,
    required this.type,
    required this.title,
    this.description,
    required this.format,
    required this.startDateTime,
    required this.durationMinutes,
    required this.maxGrade,
    required this.minPassing,
    required this.timelineStatus,
    this.totalStudents = 0,
    this.submittedCount = 0,
    this.gradedCount = 0,
    this.questions = const [],
    this.randomizeQuestions = false,
    this.randomizeAnswers = false,
    this.showResultImmediately = false,
    this.showCorrectAnswers = false,
    this.allowRetake = false,
    this.preventLateSubmission = false,
    this.maxAttempts = 1,
  });

  final String id;
  final QuizType type;
  final String title;
  final String? description;
  final QuizFormat format;
  final DateTime startDateTime;
  final int durationMinutes;
  final int maxGrade;
  final int minPassing;
  final QuizTimelineStatus timelineStatus;

  /// Number of students expected to take this quiz.
  final int totalStudents;

  /// Number of students who have submitted so far.
  final int submittedCount;

  /// Number of submissions that have been graded so far.
  final int gradedCount;

  final List<QuestionModel> questions;
  final bool randomizeQuestions;
  final bool randomizeAnswers;
  final bool showResultImmediately;
  final bool showCorrectAnswers;
  final bool allowRetake;
  final bool preventLateSubmission;
  final int maxAttempts;

  int get totalPoints =>
      questions.fold<int>(0, (sum, question) => sum + question.points);

  /// Class-wide grading status, derived from submission/grading counts —
  /// a quiz has many students, not a single personal score.
  QuizResultStatus get resultStatus {
    if (submittedCount == 0) return QuizResultStatus.pending;
    if (gradedCount < submittedCount) return QuizResultStatus.needsGrading;
    return QuizResultStatus.graded;
  }

  QuizModel copyWith({
    QuizType? type,
    String? title,
    String? description,
    QuizFormat? format,
    DateTime? startDateTime,
    int? durationMinutes,
    int? maxGrade,
    int? minPassing,
    QuizTimelineStatus? timelineStatus,
    int? totalStudents,
    int? submittedCount,
    int? gradedCount,
    List<QuestionModel>? questions,
    bool? randomizeQuestions,
    bool? randomizeAnswers,
    bool? showResultImmediately,
    bool? showCorrectAnswers,
    bool? allowRetake,
    bool? preventLateSubmission,
    int? maxAttempts,
  }) => QuizModel(
    id: id,
    type: type ?? this.type,
    title: title ?? this.title,
    description: description ?? this.description,
    format: format ?? this.format,
    startDateTime: startDateTime ?? this.startDateTime,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    maxGrade: maxGrade ?? this.maxGrade,
    minPassing: minPassing ?? this.minPassing,
    timelineStatus: timelineStatus ?? this.timelineStatus,
    totalStudents: totalStudents ?? this.totalStudents,
    submittedCount: submittedCount ?? this.submittedCount,
    gradedCount: gradedCount ?? this.gradedCount,
    questions: questions ?? this.questions,
    randomizeQuestions: randomizeQuestions ?? this.randomizeQuestions,
    randomizeAnswers: randomizeAnswers ?? this.randomizeAnswers,
    showResultImmediately: showResultImmediately ?? this.showResultImmediately,
    showCorrectAnswers: showCorrectAnswers ?? this.showCorrectAnswers,
    allowRetake: allowRetake ?? this.allowRetake,
    preventLateSubmission: preventLateSubmission ?? this.preventLateSubmission,
    maxAttempts: maxAttempts ?? this.maxAttempts,
  );
}
