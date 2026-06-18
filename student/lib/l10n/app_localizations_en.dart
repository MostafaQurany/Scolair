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
  String get loginTitle => 'Student Login';

  @override
  String get loginSubtitle => 'Sign in to access your academic workspace.';

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
  String get otpTitle => 'Verify your email';

  @override
  String otpSubtitle(Object email) {
    return 'We sent a 6-digit code to $email';
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
  String get biometricSubtitle => 'Use biometrics to sign in';

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
  String get onboardingPage1Title => 'Welcome';

  @override
  String get onboardingPage1Body =>
      'Welcome to Scolair — your academic workspace.';

  @override
  String get onboardingPage2Title => 'Learn';

  @override
  String get onboardingPage2Body =>
      'Track your classes, assignments, and progress.';

  @override
  String get onboardingPage3Title => 'Get Started';

  @override
  String get onboardingPage3Body =>
      'Everything you need for school, in one place.';

  @override
  String get onboardingNextButton => 'Next';

  @override
  String get onboardingDoneButton => 'Get Started';

  @override
  String get onboardingSkipButton => 'Skip';
}
