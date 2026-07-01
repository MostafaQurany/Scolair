import '../../models/quiz_models.dart';

abstract class QuizMockDataSource {
  Future<List<QuizModel>> listQuizzes();
  Future<QuizModel> getQuiz(String id);
  Future<QuizModel> createQuiz(QuizModel quiz);
  Future<QuizModel> updateQuiz(QuizModel quiz);
  Future<void> deleteQuiz(String id);
  Future<QuizModel> createQuestion(String quizId, QuestionModel question);
  Future<QuizModel> updateQuestion(String quizId, QuestionModel question);
  Future<QuizModel> deleteQuestion(String quizId, String questionId);
}

class QuizMockDataSourceImpl implements QuizMockDataSource {
  final List<QuizModel> _quizzes = _seedQuizzes();

  @override
  Future<List<QuizModel>> listQuizzes() async => List.unmodifiable(_quizzes);

  @override
  Future<QuizModel> getQuiz(String id) async => _findQuiz(id);

  @override
  Future<QuizModel> createQuiz(QuizModel quiz) async {
    final created = QuizModel(
      id: 'quiz_${DateTime.now().microsecondsSinceEpoch}',
      type: quiz.type,
      title: quiz.title,
      description: quiz.description,
      format: quiz.format,
      startDateTime: quiz.startDateTime,
      durationMinutes: quiz.durationMinutes,
      maxGrade: quiz.maxGrade,
      minPassing: quiz.minPassing,
      timelineStatus: QuizTimelineStatus.upcoming,
      totalStudents: quiz.totalStudents,
      randomizeQuestions: quiz.randomizeQuestions,
      randomizeAnswers: quiz.randomizeAnswers,
      showResultImmediately: quiz.showResultImmediately,
      showCorrectAnswers: quiz.showCorrectAnswers,
      allowRetake: quiz.allowRetake,
      preventLateSubmission: quiz.preventLateSubmission,
      maxAttempts: quiz.maxAttempts,
    );
    _quizzes.insert(0, created);
    return created;
  }

  @override
  Future<QuizModel> updateQuiz(QuizModel quiz) async {
    final index = _indexOf(quiz.id);
    _quizzes[index] = quiz;
    return quiz;
  }

  @override
  Future<void> deleteQuiz(String id) async {
    _quizzes.removeWhere((quiz) => quiz.id == id);
  }

  @override
  Future<QuizModel> createQuestion(
    String quizId,
    QuestionModel question,
  ) async {
    final index = _indexOf(quizId);
    final quiz = _quizzes[index];
    final created = question.copyWith();
    final updated = quiz.copyWith(questions: [...quiz.questions, created]);
    _quizzes[index] = updated;
    return updated;
  }

  @override
  Future<QuizModel> updateQuestion(
    String quizId,
    QuestionModel question,
  ) async {
    final index = _indexOf(quizId);
    final quiz = _quizzes[index];
    final questions = quiz.questions
        .map((existing) => existing.id == question.id ? question : existing)
        .toList();
    final updated = quiz.copyWith(questions: questions);
    _quizzes[index] = updated;
    return updated;
  }

  @override
  Future<QuizModel> deleteQuestion(String quizId, String questionId) async {
    final index = _indexOf(quizId);
    final quiz = _quizzes[index];
    final questions = quiz.questions
        .where((question) => question.id != questionId)
        .toList();
    final updated = quiz.copyWith(questions: questions);
    _quizzes[index] = updated;
    return updated;
  }

  QuizModel _findQuiz(String id) => _quizzes[_indexOf(id)];

  int _indexOf(String id) {
    final index = _quizzes.indexWhere((quiz) => quiz.id == id);
    if (index == -1) {
      throw StateError('Quiz not found: $id');
    }
    return index;
  }

  static List<QuizModel> _seedQuizzes() => [
    QuizModel(
      id: 'quiz_1',
      type: QuizType.midterm,
      title: 'Physics Midterm',
      description: 'Chapters 1-5: Mechanics & Kinematics',
      format: QuizFormat.online,
      startDateTime: DateTime(2023, 10, 24, 10),
      durationMinutes: 90,
      maxGrade: 100,
      minPassing: 60,
      timelineStatus: QuizTimelineStatus.upcoming,
      totalStudents: 24,
    ),
    QuizModel(
      id: 'quiz_2',
      type: QuizType.quiz,
      title: 'Weekly Quiz 4',
      description: 'Derivatives and Limits',
      format: QuizFormat.online,
      startDateTime: DateTime(2023, 10, 10, 9),
      durationMinutes: 30,
      maxGrade: 30,
      minPassing: 18,
      timelineStatus: QuizTimelineStatus.past,
      totalStudents: 30,
      submittedCount: 30,
      gradedCount: 30,
      questions: [
        QuestionModel(
          id: 'q1',
          type: QuestionType.multipleChoice,
          text: 'What is the derivative of x²?',
          points: 5,
          difficulty: QuestionDifficulty.medium,
          required: true,
          options: const [
            QuestionOptionModel(id: 'q1a', text: 'x', isCorrect: false),
            QuestionOptionModel(id: 'q1b', text: '2x', isCorrect: true),
            QuestionOptionModel(id: 'q1c', text: 'x²', isCorrect: false),
            QuestionOptionModel(id: 'q1d', text: '2', isCorrect: false),
          ],
        ),
        QuestionModel(
          id: 'q2',
          type: QuestionType.trueFalse,
          text: 'The derivative of a constant is zero.',
          points: 5,
          difficulty: QuestionDifficulty.easy,
          required: true,
          correctBoolAnswer: true,
        ),
        QuestionModel(
          id: 'q3',
          type: QuestionType.shortAnswer,
          text: 'Find the derivative of 3x² + 2x.',
          points: 10,
          difficulty: QuestionDifficulty.medium,
          required: true,
          acceptedAnswer: '6x + 2',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_3',
      type: QuizType.quiz,
      title: 'Pop Quiz: Integrals',
      description: 'Basic Integration Rules',
      format: QuizFormat.online,
      startDateTime: DateTime(2023, 10, 17, 9),
      durationMinutes: 20,
      maxGrade: 20,
      minPassing: 12,
      timelineStatus: QuizTimelineStatus.past,
      totalStudents: 20,
      submittedCount: 20,
      gradedCount: 8,
    ),
  ];
}
