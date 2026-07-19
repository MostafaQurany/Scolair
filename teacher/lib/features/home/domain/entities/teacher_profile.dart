class TeacherProfile {
  const TeacherProfile({
    required this.id,
    required this.displayName,
    this.imageUrl,
  });

  final String id;
  final String displayName;
  final String? imageUrl;
}
