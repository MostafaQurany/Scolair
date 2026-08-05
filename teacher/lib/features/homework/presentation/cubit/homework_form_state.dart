enum HomeworkFormStatus { initial, submitting, success, failure }

class HomeworkFormState {
  const HomeworkFormState({
    this.status = HomeworkFormStatus.initial,
    this.editingHomeworkName,
    this.createdHomeworkName,
    this.title = '',
    this.dueDate,
    this.course,
    this.courseTitle,
    this.lesson,
    this.lessonTitle,
    this.batch,
    this.instructions = '',
    this.allowLateSubmission = false,
    this.errorMessage,
  });

  final HomeworkFormStatus status;
  final String? editingHomeworkName;
  final String? createdHomeworkName;
  final String title;
  final DateTime? dueDate;
  final String? course;
  final String? courseTitle;
  final String? lesson;
  final String? lessonTitle;
  final String? batch;
  final String instructions;
  final bool allowLateSubmission;
  final String? errorMessage;

  bool get isEditing => editingHomeworkName != null;

  bool get isFormValid => title.trim().isNotEmpty && dueDate != null && (lesson != null || course != null);

  HomeworkFormState copyWith({
    HomeworkFormStatus? status,
    String? editingHomeworkName,
    String? createdHomeworkName,
    String? title,
    DateTime? dueDate,
    String? course,
    String? courseTitle,
    String? lesson,
    String? lessonTitle,
    String? batch,
    bool clearBatch = false,
    String? instructions,
    bool? allowLateSubmission,
    String? errorMessage,
  }) => HomeworkFormState(
      status: status ?? this.status,
      editingHomeworkName: editingHomeworkName ?? this.editingHomeworkName,
      createdHomeworkName: createdHomeworkName ?? this.createdHomeworkName,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      course: course ?? this.course,
      courseTitle: courseTitle ?? this.courseTitle,
      lesson: lesson ?? this.lesson,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      batch: clearBatch ? null : (batch ?? this.batch),
      instructions: instructions ?? this.instructions,
      allowLateSubmission: allowLateSubmission ?? this.allowLateSubmission,
      errorMessage: errorMessage ?? this.errorMessage,
    );
}
