import 'teacher_feed_filter.dart';
import 'teacher_profile.dart';

class TeacherHome {
  const TeacherHome({
    required this.teacher,
    required this.noticficationCount, required this.filters, this.greetingActivityTitle,
  });

  final TeacherProfile teacher;
  final String? greetingActivityTitle;
  final int noticficationCount;
  final List<TeacherFeedFilter> filters;
}
