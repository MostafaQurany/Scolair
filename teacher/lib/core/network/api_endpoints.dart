abstract final class ApiEndpoints {
  static const String baseUrl = 'https://dev.scolair.site';
  static const String login = '/api/method/lms.mobile.login';
  static const String register = '/api/method/lms.mobile.sign_up';
  static const String googleLogin = '/api/method/lms.mobile.google_login';
  static const String refreshToken = '/api/method/lms.mobile.refresh';
  static const String logout = '/api/method/lms.mobile.logout';
  static const String forgotPasswordSendOtp =
      '/api/method/lms.mobile.forgot_password_send_otp';
  static const String forgotPasswordVerifyOtp =
      '/api/method/lms.mobile.forgot_password_verify_otp';
  static const String forgotPasswordReset =
      '/api/method/lms.mobile.forgot_password_reset_password';
  static const String changePassword =
      '/api/method/frappe.core.doctype.user.user.update_password';
  static const String listCourses =
      '/api/method/lms.courses.controllers.list_courses';
  static const String getCourse =
      '/api/method/lms.courses.controllers.get_course';
  static const String createCourse =
      '/api/method/lms.courses.controllers.create_course';
  static const String updateCourse =
      '/api/method/lms.courses.controllers.update_course';
  static const String deleteCourse =
      '/api/method/lms.courses.controllers.delete_course';
  static const String getChapters =
      '/api/method/lms.courses.controllers.get_chapters';
  static const String getChapter =
      '/api/method/lms.courses.controllers.get_chapter';
  static const String createChapter =
      '/api/method/lms.courses.controllers.create_chapter';
  static const String updateChapter =
      '/api/method/lms.courses.controllers.update_chapter';
  static const String deleteChapter =
      '/api/method/lms.courses.controllers.delete_chapter';
  static const String getLessons =
      '/api/method/lms.courses.controllers.get_lessons';
  static const String getLesson =
      '/api/method/lms.courses.controllers.get_lesson';
  static const String createLesson =
      '/api/method/lms.courses.controllers.create_lesson';
  static const String uploadFile = '/api/method/upload_file';
  static const String updateLesson =
      '/api/method/lms.courses.controllers.update_lesson';
  static const String deleteLesson =
      '/api/method/lms.courses.controllers.delete_lesson';
  static const String myCourses =
      '/api/method/lms.courses.controllers.my_courses';
  static const String sharedCourses =
      '/api/method/lms.courses.controllers.shared_courses';
  static const String getStudents =
      '/api/method/lms.courses.controllers.get_students';
  static const String addStudent =
      '/api/method/lms.courses.controllers.add_student';
  static const String removeStudent =
      '/api/method/lms.courses.controllers.remove_student';
  static const String getInstructors =
      '/api/method/lms.courses.controllers.get_instructors';
  static const String addInstructor =
      '/api/method/lms.courses.controllers.add_instructor';
  static const String removeInstructor =
      '/api/method/lms.courses.controllers.remove_instructor';

  // === Quiz Endpoints ===
  static const String listQuestions =
      '/api/method/lms.question.controllers.list_questions';
  static const String getQuestion =
      '/api/method/lms.question.controllers.get_question';
  static const String createQuestion =
      '/api/method/lms.question.controllers.create_question';
  static const String updateQuestion =
      '/api/method/lms.question.controllers.update_question';
  static const String deleteQuestion =
      '/api/method/lms.question.controllers.delete_question';
  static const String listQuizzes =
      '/api/method/lms.quiz.controllers.list_quizzes';
  static const String getQuiz = '/api/method/lms.quiz.controllers.get_quiz';
  static const String createQuiz =
      '/api/method/lms.quiz.controllers.create_quiz';
  static const String updateQuiz =
      '/api/method/lms.quiz.controllers.update_quiz';
  static const String deleteQuiz =
      '/api/method/lms.quiz.controllers.delete_quiz';
  static const String addQuestionToQuiz =
      '/api/method/lms.quiz.controllers.add_question';
  static const String removeQuestionFromQuiz =
      '/api/method/lms.quiz.controllers.remove_question';
  static const String getQuizSubmissions =
      '/api/method/lms.quiz.controllers.get_submissions';
  static const String getStudentQuizSubmissions =
      '/api/method/lms.quiz.controllers.get_student_submissions';
  static const String gradeQuizSubmission =
      '/api/method/lms.quiz.controllers.grade_submission';
  static const String listHomeworks =
      '/api/method/lms.homework.controllers.list_homeworks';
  static const String getHomework =
      '/api/method/lms.homework.controllers.get_homework';
  static const String createHomework =
      '/api/method/lms.homework.controllers.create_homework';
  static const String updateHomework =
      '/api/method/lms.homework.controllers.update_homework';
  static const String deleteHomework =
      '/api/method/lms.homework.controllers.delete_homework';
  static const String addHomeworkQuestion =
      '/api/method/lms.homework.controllers.add_question';
  static const String removeHomeworkQuestion =
      '/api/method/lms.homework.controllers.remove_question';
  static const String getHomeworkSubmissions =
      '/api/method/lms.homework.controllers.get_submissions';
  static const String getHomeworkSubmission =
      '/api/method/lms.homework.controllers.get_submission';
  static const String downloadAnswerFile =
      '/api/method/lms.homework.controllers.download_answer_file';
  static const String gradeHomeworkSubmission =
      '/api/method/lms.homework.controllers.grade_submission';

  // Profile and Settings
  static const String getUserInfo = '/api/method/lms.mobile.get_profile';
  static const String editProfile = '/api/method/lms.mobile.edit_profile';
  static const String uploadProfileImage =
      '/api/method/lms.mobile.upload_profile_image';

  // Notifications
  static const String listNotifications =
      '/api/method/lms.notifications.controllers.list_notifications';
  static const String markNotificationRead =
      '/api/method/lms.notifications.controllers.mark_read';
  static const String markNotificationUnread =
      '/api/method/lms.notifications.controllers.mark_unread';
  static const String markAllNotificationsRead =
      '/api/method/lms.notifications.controllers.mark_all_read';
  static const String toggleNotificationPin =
      '/api/method/lms.notifications.controllers.toggle_pin';
  static const String archiveNotification =
      '/api/method/lms.notifications.controllers.archive';
  static const String unarchiveNotification =
      '/api/method/lms.notifications.controllers.unarchive';
  static const String deleteNotification =
      '/api/method/lms.notifications.controllers.delete';
  static const String muteCategory =
      '/api/method/lms.notifications.controllers.mute_category';
  static const String muteCourse =
      '/api/method/lms.notifications.controllers.mute_course';
}
