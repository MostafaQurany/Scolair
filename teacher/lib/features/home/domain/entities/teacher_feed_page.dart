import 'teacher_wall_post.dart';

class TeacherFeedPage {
  const TeacherFeedPage({
    required this.posts,
    required this.hasMore,
    required this.nextPage,
  });

  final List<TeacherWallPost> posts;
  final bool hasMore;
  final int nextPage;
}
