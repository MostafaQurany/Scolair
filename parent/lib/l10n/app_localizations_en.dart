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
  String get loginTitle => 'Parent Login';

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
  String get phoneLoginSecurityNote =>
      'Your parent account protects sensitive child information.';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get forgotPasswordLink => 'Forgot password?';

  @override
  String get loginButton => 'Log in';

  @override
  String get orgLoginTitle => 'Phone Login';

  @override
  String get orgLoginSubtitle =>
      'Enter your phone number to receive a one-time code.';

  @override
  String get orgLoginButton => 'Continue';

  @override
  String get otpTitle => 'Verify your identity';

  @override
  String otpSubtitle(Object identifier) {
    return 'We sent a 6-digit code to $identifier';
  }

  @override
  String get otpResend => 'Resend code';

  @override
  String get otpVerifyButton => 'Verify';

  @override
  String get forgotPasswordTitle => 'Forgot password?';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your email and we will send you a reset code';

  @override
  String get sendResetLinkButton => 'Send reset code';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get newPasswordHint => 'Enter new password';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get confirmPasswordHint => 'Re-enter new password';

  @override
  String get resetPasswordButton => 'Reset password';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get biometricTitle => 'Welcome back';

  @override
  String get biometricSubtitle => 'Use biometrics to unlock';

  @override
  String get biometricPrompt => 'Authenticate to access Scolair';

  @override
  String get usePasswordFallback => 'Use password instead';

  @override
  String get authErrorInvalidCredentials => 'Incorrect email or password';

  @override
  String get authErrorOtpInvalid => 'Invalid or expired code';

  @override
  String get authErrorGeneric => 'Something went wrong. Please try again';

  @override
  String get onboardingPage1Title => 'Follow Every Child';

  @override
  String get onboardingPage1Body =>
      'See your children\'s homework, exams, grades, attendance, reports, and school updates quickly.';

  @override
  String get onboardingPage2Title => 'Monitor Progress';

  @override
  String get onboardingPage2Body =>
      'Review grades, homework, exams, attendance, and reports with clear child-focused details.';

  @override
  String get onboardingPage3Title => 'Stay Connected';

  @override
  String get onboardingPage3Body =>
      'Chat with teachers, receive announcements, approve events, and support your child with confidence.';

  @override
  String get onboardingNextButton => 'Next';

  @override
  String get onboardingDoneButton => 'Get Started';

  @override
  String get onboardingSkipButton => 'Skip';
}
