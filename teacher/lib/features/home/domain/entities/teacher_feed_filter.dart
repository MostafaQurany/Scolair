enum TeacherFeedFilterType { all, classRoom, course, subject, group }

class TeacherFeedFilter {
  const TeacherFeedFilter({
    required this.id,
    required this.label,
    required this.type,
  });

  final String id;
  final String label;
  final TeacherFeedFilterType type;
}
