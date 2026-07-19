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
  static const String listHomeworks =
      '/api/method/lms.homework.controllers.list_homeworks';
  static const String deleteHomework =
      '/api/method/lms.homework.controllers.delete_homework';
}
