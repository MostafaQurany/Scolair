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
}
