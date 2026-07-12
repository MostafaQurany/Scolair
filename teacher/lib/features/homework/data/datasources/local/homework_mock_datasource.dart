import '../../models/homework_models.dart';

abstract class HomeworkMockDataSource {
  Future<List<HomeworkModel>> listHomework();
  Future<HomeworkModel> createHomework(HomeworkModel homework);
  Future<HomeworkModel> updateHomework(HomeworkModel homework);
  Future<void> deleteHomework(String id);
  Future<HomeworkModel> duplicateHomework(String id);
}

class HomeworkMockDataSourceImpl implements HomeworkMockDataSource {
  final List<HomeworkModel> _homework = _seedHomework();

  @override
  Future<List<HomeworkModel>> listHomework() async =>
      List.unmodifiable(_homework);

  @override
  Future<HomeworkModel> createHomework(HomeworkModel homework) async {
    final created = homework.copyWith();
    final withId = HomeworkModel(
      id: 'hw_${DateTime.now().microsecondsSinceEpoch}',
      title: created.title,
      category: created.category,
      subject: created.subject,
      fileName: created.fileName,
      targetType: created.targetType,
      targetName: created.targetName,
      dueDateTime: created.dueDateTime,
      status: created.status,
      totalStudents: created.totalStudents,
      submittedCount: created.submittedCount,
    );
    _homework.insert(0, withId);
    return withId;
  }

  @override
  Future<HomeworkModel> updateHomework(HomeworkModel homework) async {
    final index = _indexOf(homework.id);
    _homework[index] = homework;
    return homework;
  }

  @override
  Future<void> deleteHomework(String id) async {
    _homework.removeWhere((homework) => homework.id == id);
  }

  @override
  Future<HomeworkModel> duplicateHomework(String id) async {
    final source = _homework[_indexOf(id)];
    final duplicated = HomeworkModel(
      id: 'hw_${DateTime.now().microsecondsSinceEpoch}',
      title: source.title,
      category: source.category,
      subject: source.subject,
      fileName: source.fileName,
      targetType: source.targetType,
      targetName: source.targetName,
      dueDateTime: source.dueDateTime,
      status: HomeworkStatus.draft,
      totalStudents: source.totalStudents,
      submittedCount: 0,
    );
    _homework.insert(0, duplicated);
    return duplicated;
  }

  int _indexOf(String id) {
    final index = _homework.indexWhere((homework) => homework.id == id);
    if (index == -1) {
      throw StateError('Homework not found: $id');
    }
    return index;
  }

  static List<HomeworkModel> _seedHomework() => [
    HomeworkModel(
      id: 'hw_1',
      title: 'Algebra Set B',
      category: 'Worksheet',
      subject: 'Algebra',
      fileName: 'algebra_set_b.pdf',
      targetType: HomeworkTargetType.lesson,
      targetName: 'Algebra Basics',
      dueDateTime: DateTime(2023, 10, 24, 23, 59),
      status: HomeworkStatus.published,
      totalStudents: 24,
      submittedCount: 18,
    ),
    HomeworkModel(
      id: 'hw_2',
      title: 'Triangle Proofs Ch.4',
      category: 'Practice Set',
      subject: 'Geometry',
      fileName: 'triangle_proofs_ch4.pdf',
      targetType: HomeworkTargetType.lesson,
      targetName: 'Geometry Proofs',
      dueDateTime: DateTime.now().copyWith(hour: 17, minute: 0),
      status: HomeworkStatus.published,
      totalStudents: 24,
      submittedCount: 8,
    ),
    HomeworkModel(
      id: 'hw_3',
      title: 'Sine Functions Intro',
      category: 'Reading',
      subject: 'Trigonometry',
      fileName: 'sine_functions_intro.pdf',
      targetType: HomeworkTargetType.examQuiz,
      targetName: 'Midterm Math 101',
      dueDateTime: DateTime(2023, 10, 30, 23, 59),
      status: HomeworkStatus.scheduled,
      totalStudents: 24,
      submittedCount: 0,
    ),
    HomeworkModel(
      id: 'hw_4',
      title: 'Quadratics Practice',
      category: 'Practice Set',
      subject: 'Algebra',
      fileName: 'quadratics_practice.pdf',
      targetType: HomeworkTargetType.lesson,
      targetName: 'Algebra Basics',
      dueDateTime: DateTime(2023, 11, 2, 23, 59),
      status: HomeworkStatus.draft,
      totalStudents: 24,
      submittedCount: 0,
    ),
    HomeworkModel(
      id: 'hw_5',
      title: 'Circle Theorems Reading',
      category: 'Reading',
      subject: 'Geometry',
      fileName: 'circle_theorems.pdf',
      targetType: HomeworkTargetType.lesson,
      targetName: 'Geometry Proofs',
      dueDateTime: DateTime(2023, 11, 5, 23, 59),
      status: HomeworkStatus.draft,
      totalStudents: 24,
      submittedCount: 0,
    ),
  ];
}
