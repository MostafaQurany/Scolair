import 'models/class_model.dart';

/// Static mock data matching the provided mockup designs.
///
/// This data will be replaced with real API calls once
/// a backend classes endpoint is available.
abstract final class MockClassesData {
  static const List<String> categories = [
    'All Classes',
    'Mathematics',
    'Science',
    'Networking',
    'Literature',
  ];

  static List<ClassModel> get classes => [
    _mathClass,
    _physicsClass,
    _chemistryClass,
  ];

  static ClassModel getClassByCode(String code) =>
      classes.firstWhere((c) => c.code == code);

  static const _mathClass = ClassModel(
    code: 'MATH-10A',
    subject: 'Advanced Mathematics',
    description: 'Advanced Mathematics',
    studentCount: 24,
    scheduleTime: '10:30 AM',
    scheduleDays: 'Mon, Wed, Fri • 09:00 - 10:30 AM',
    category: 'Mathematics',
    nextLesson: 'Matrices & Transformations',
    submissionStatus: SubmissionStatus(pendingCount: 12, isAllCaughtUp: false),
    curriculum: [
      CurriculumItem(
        title: 'Matrices & Determinants',
        subtitle: '5 Lessons • 1 Assignment',
        status: CurriculumStatus.completed,
        type: CurriculumType.chapter,
        itemNumber: '1',
      ),
      CurriculumItem(
        title: '4.1 Introduction to Matrix Operations',
        subtitle: 'Completed • Sep 15',
        status: CurriculumStatus.completed,
        type: CurriculumType.lesson,
      ),
      CurriculumItem(
        title: '4.2 Multiplying Matrices',
        subtitle: 'Current Lesson • In Progress',
        status: CurriculumStatus.current,
        type: CurriculumType.lesson,
      ),
      CurriculumItem(
        title: '4.3 Inverse Matrices',
        subtitle: 'Upcoming • Oct 16',
        status: CurriculumStatus.upcoming,
        type: CurriculumType.lesson,
      ),
      CurriculumItem(
        title: 'Problem Set A4',
        subtitle: '',
        status: CurriculumStatus.overdue,
        type: CurriculumType.problemSet,
        dueDate: 'Due Oct 18',
      ),
      CurriculumItem(
        title: 'Vector Spaces',
        subtitle: '4 Lessons • Starts Oct 21',
        status: CurriculumStatus.upcoming,
        type: CurriculumType.chapter,
        itemNumber: '5',
      ),
    ],
    activities: [
      ClassActivity(
        type: ClassActivityType.announcement,
        title: 'Announcement',
        description:
            'Midterm room dates have been finalized for '
            'next month. Please review the syllabus '
            'updates posted in the documents section.',
        timestamp: '2 hours ago',
      ),
      ClassActivity(
        type: ClassActivityType.grading,
        title: 'Needs Grading',
        description: 'Assignment 3',
        actionLabel: 'Grade Now',
        badgeLabel: 'Assignment 3',
        submittedCount: 28,
        totalCount: 32,
      ),
    ],
    attendance: AttendanceData(
      percentage: 98,
      presentToday: 31,
      absentToday: 1,
    ),
    performance: PerformanceData(classAverage: 86, assignmentCompletion: 93),
  );

  static const _physicsClass = ClassModel(
    code: 'PHY-11B',
    subject: 'AP Physics 1',
    description: 'AP Physics 1',
    studentCount: 18,
    scheduleTime: '1:15 PM',
    scheduleDays: 'Tue, Thu • 01:15 - 02:45 PM',
    category: 'Science',
    nextLesson: 'Kinematics Review',
    submissionStatus: SubmissionStatus(pendingCount: 0, isAllCaughtUp: true),
    curriculum: [
      CurriculumItem(
        title: 'Kinematics',
        subtitle: '6 Lessons • 2 Assignments',
        status: CurriculumStatus.current,
        type: CurriculumType.chapter,
        itemNumber: '1',
      ),
      CurriculumItem(
        title: 'Newton\'s Laws',
        subtitle: '4 Lessons • Starts Nov 01',
        status: CurriculumStatus.upcoming,
        type: CurriculumType.chapter,
        itemNumber: '2',
      ),
    ],
    activities: [
      ClassActivity(
        type: ClassActivityType.grading,
        title: 'Needs Grading',
        description: 'Lab Report 2',
        actionLabel: 'Grade Now',
        badgeLabel: 'Lab Report 2',
        submittedCount: 18,
        totalCount: 18,
      ),
    ],
    attendance: AttendanceData(
      percentage: 95,
      presentToday: 17,
      absentToday: 1,
    ),
    performance: PerformanceData(classAverage: 82, assignmentCompletion: 89),
  );

  static const _chemistryClass = ClassModel(
    code: 'CHEM-10C',
    subject: 'Intro to Chemistry',
    description: 'Intro to Chemistry',
    studentCount: 30,
    scheduleTime: 'Tomorrow, 9:00 AM',
    scheduleDays: 'Mon, Wed • 09:00 - 10:30 AM',
    category: 'Science',
    nextLesson: 'Periodic Table Trends',
    submissionStatus: SubmissionStatus(pendingCount: 4, isAllCaughtUp: false),
    urgentAlert:
        '2 flagged posts in Class Wall require '
        'moderation review.',
    curriculum: [
      CurriculumItem(
        title: 'Atomic Structure',
        subtitle: '4 Lessons • 1 Assignment',
        status: CurriculumStatus.completed,
        type: CurriculumType.chapter,
        itemNumber: '1',
      ),
      CurriculumItem(
        title: 'Periodic Table',
        subtitle: '5 Lessons • In Progress',
        status: CurriculumStatus.current,
        type: CurriculumType.chapter,
        itemNumber: '2',
      ),
    ],
    activities: [
      ClassActivity(
        type: ClassActivityType.announcement,
        title: 'Urgent Alert',
        description:
            '2 flagged posts in Class Wall require '
            'moderation review.',
        timestamp: '30 minutes ago',
      ),
    ],
    attendance: AttendanceData(
      percentage: 91,
      presentToday: 28,
      absentToday: 2,
    ),
    performance: PerformanceData(classAverage: 78, assignmentCompletion: 85),
  );
}
