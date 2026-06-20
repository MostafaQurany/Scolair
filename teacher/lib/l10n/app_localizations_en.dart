// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Scolair';

  @override
  String get homeTitle => 'Scolair Home';

  @override
  String get homeSubtitle => 'Your school workspace is ready.';

  @override
  String get homeSummaryTitle => 'Today at a glance';

  @override
  String classCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count classes',
      one: '1 class',
      zero: 'No classes',
    );
    return '$_temp0';
  }

  @override
  String assignmentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count assignments',
      one: '1 assignment',
      zero: 'No assignments',
    );
    return '$_temp0';
  }

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading';

  @override
  String get loginTitle => 'Teacher Login';

  @override
  String get loginSubtitle =>
      'Sign in with your organization email to continue.';

  @override
  String get phoneNumberLabel => 'Phone Number';

  @override
  String get phoneNumberHint => 'Enter your phone number';

  @override
  String get sendOtpButton => 'Send OTP';

  @override
  String get orgLoginLink => 'Sign in with phone instead';

  @override
  String get forgotPasswordLink => 'Forgot password?';

  @override
  String get phoneLoginSecurityNote =>
      'Your teacher account is tied to your school credentials.';

  @override
  String get orgLoginTitle => 'Phone Login';

  @override
  String get orgLoginSubtitle =>
      'Enter your phone number to receive a one-time code.';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'your@school.edu';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get orgLoginButton => 'Sign In';

  @override
  String get otpTitle => 'Verify your identity';

  @override
  String otpSubtitle(String identifier) {
    return 'Enter the 6-digit code sent to $identifier';
  }

  @override
  String get otpResend => 'Resend code';

  @override
  String get otpVerifyButton => 'Verify';

  @override
  String get authErrorOtpInvalid =>
      'Invalid or expired code. Please try again.';

  @override
  String get forgotPasswordTitle => 'Forgot Password?';

  @override
  String get forgotPasswordSubtitle => 'We\'ll send you a reset code.';

  @override
  String get sendResetLinkButton => 'Send Reset Code';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get newPasswordLabel => 'New Password';

  @override
  String get newPasswordHint => 'Enter new password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get confirmPasswordHint => 'Re-enter new password';

  @override
  String get resetPasswordButton => 'Reset Password';

  @override
  String get passwordMismatch => 'Passwords do not match.';

  @override
  String get biometricTitle => 'Biometric Unlock';

  @override
  String get biometricSubtitle => 'Use biometrics to access your account.';

  @override
  String get biometricPrompt => 'Authenticate';

  @override
  String get usePasswordFallback => 'Use password instead';

  @override
  String get authErrorGeneric => 'Something went wrong. Please try again.';

  @override
  String get onboardingPage1Title => 'Lead Your Classes';

  @override
  String get onboardingPage1Body =>
      'Share posts, manage class updates, moderate comments, and keep students connected.';

  @override
  String get onboardingPage2Title => 'Create And Manage';

  @override
  String get onboardingPage2Body =>
      'Build lessons, homework, exams, live sessions, files, attendance, and class activities.';

  @override
  String get onboardingPage3Title => 'Support Every Student';

  @override
  String get onboardingPage3Body =>
      'Review submissions, mark attendance, track progress, grade work, and contact parents when needed.';

  @override
  String get onboardingNextButton => 'Next';

  @override
  String get onboardingDoneButton => 'Get Started';

  @override
  String get onboardingSkipButton => 'Skip';
}
