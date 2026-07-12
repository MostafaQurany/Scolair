import '../../../../core/storage/app_shared_preferences.dart';
import '../../data/models/courses_models.dart';

class CoursePermissionHelper {
  const CoursePermissionHelper._();

  static bool canManageCourse(
    CourseModel course,
    AppSharedPreferences preferences,
  ) {
    if (!preferences.isCourseCreator) return false;

    final userName = preferences.getUserName()?.trim().toLowerCase();
    final userEmail = preferences.getUserEmail()?.trim().toLowerCase();
    final username = preferences.getUsername()?.trim().toLowerCase();

    bool matchesUser(String? value) {
      if (value == null || value.isEmpty) return false;
      return value == userName || value == userEmail || value == username;
    }

    // Primary check: owner field (Frappe sets this to the creator's email/name)
    final owner = course.owner?.trim().toLowerCase();
    if (owner != null && owner.isNotEmpty) {
      return matchesUser(owner);
    }

    // Fallback: API may omit owner — check instructors list instead.
    // InstructorModel.name is the Frappe user name (email primary key).
    final instructors = course.instructors;
    if (instructors != null && instructors.isNotEmpty) {
      return instructors.any(
        (i) =>
            matchesUser(i.name.trim().toLowerCase()) ||
            matchesUser(i.username?.trim().toLowerCase()),
      );
    }

    return false;
  }
}
