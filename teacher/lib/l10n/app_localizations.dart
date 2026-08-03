import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Scolair'**
  String get appName;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Scolair Home'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your school workspace is ready.'**
  String get homeSubtitle;

  /// No description provided for @homeSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Today at a glance'**
  String get homeSummaryTitle;

  /// No description provided for @classCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No classes} =1{1 class} other{{count} classes}}'**
  String classCount(int count);

  /// No description provided for @assignmentCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No assignments} =1{1 assignment} other{{count} assignments}}'**
  String assignmentCount(int count);

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Teacher Login'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your organization email to continue.'**
  String get loginSubtitle;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneNumberHint;

  /// No description provided for @sendOtpButton.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtpButton;

  /// No description provided for @orgLoginLink.
  ///
  /// In en, this message translates to:
  /// **'Sign in with phone instead'**
  String get orgLoginLink;

  /// No description provided for @forgotPasswordLink.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordLink;

  /// No description provided for @phoneLoginSecurityNote.
  ///
  /// In en, this message translates to:
  /// **'Your teacher account is tied to your school credentials.'**
  String get phoneLoginSecurityNote;

  /// No description provided for @orgLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Phone Login'**
  String get orgLoginTitle;

  /// No description provided for @orgLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to receive a one-time code.'**
  String get orgLoginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'your@school.edu'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @orgLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get orgLoginButton;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your identity'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to {identifier}'**
  String otpSubtitle(String identifier);

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get otpResend;

  /// No description provided for @otpVerifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpVerifyButton;

  /// No description provided for @authErrorOtpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired code. Please try again.'**
  String get authErrorOtpInvalid;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a reset code.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendResetLinkButton.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Code'**
  String get sendResetLinkButton;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordLabel;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get newPasswordHint;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter new password'**
  String get confirmPasswordHint;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordButton;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordMismatch;

  /// No description provided for @biometricTitle.
  ///
  /// In en, this message translates to:
  /// **'Biometric Unlock'**
  String get biometricTitle;

  /// No description provided for @biometricSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use biometrics to access your account.'**
  String get biometricSubtitle;

  /// No description provided for @biometricPrompt.
  ///
  /// In en, this message translates to:
  /// **'Authenticate'**
  String get biometricPrompt;

  /// No description provided for @usePasswordFallback.
  ///
  /// In en, this message translates to:
  /// **'Use password instead'**
  String get usePasswordFallback;

  /// No description provided for @biometricRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometric Login'**
  String get biometricRequestTitle;

  /// No description provided for @biometricRequestSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Speed up your sign-in with fingerprint or face recognition.'**
  String get biometricRequestSubtitle;

  /// No description provided for @biometricEnableButton.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometric'**
  String get biometricEnableButton;

  /// No description provided for @biometricNotNowButton.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get biometricNotNowButton;

  /// No description provided for @biometricDontShowAgainLabel.
  ///
  /// In en, this message translates to:
  /// **'Don\'t show this again'**
  String get biometricDontShowAgainLabel;

  /// No description provided for @biometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is not available on this device.'**
  String get biometricUnavailable;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authErrorGeneric;

  /// No description provided for @onboardingPage1Title.
  ///
  /// In en, this message translates to:
  /// **'Lead Your Classes'**
  String get onboardingPage1Title;

  /// No description provided for @onboardingPage1Body.
  ///
  /// In en, this message translates to:
  /// **'Share posts, manage class updates, moderate comments, and keep students connected.'**
  String get onboardingPage1Body;

  /// No description provided for @onboardingPage2Title.
  ///
  /// In en, this message translates to:
  /// **'Create And Manage'**
  String get onboardingPage2Title;

  /// No description provided for @onboardingPage2Body.
  ///
  /// In en, this message translates to:
  /// **'Build lessons, homework, exams, live sessions, files, attendance, and class activities.'**
  String get onboardingPage2Body;

  /// No description provided for @onboardingPage3Title.
  ///
  /// In en, this message translates to:
  /// **'Support Every Student'**
  String get onboardingPage3Title;

  /// No description provided for @onboardingPage3Body.
  ///
  /// In en, this message translates to:
  /// **'Review submissions, mark attendance, track progress, grade work, and contact parents when needed.'**
  String get onboardingPage3Body;

  /// No description provided for @onboardingNextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNextButton;

  /// No description provided for @onboardingDoneButton.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingDoneButton;

  /// No description provided for @onboardingSkipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkipButton;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get registerTitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// No description provided for @agreeTermsLabel.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms & Conditions'**
  String get agreeTermsLabel;

  /// No description provided for @createAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountButton;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully. Please log in.'**
  String get registerSuccess;

  /// No description provided for @alreadyHaveAccountLink.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log in'**
  String get alreadyHaveAccountLink;

  /// No description provided for @continueWithGoogleButton.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogleButton;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use your current password to choose a new one.'**
  String get changePasswordSubtitle;

  /// No description provided for @currentPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPasswordLabel;

  /// No description provided for @updatePasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get updatePasswordButton;

  /// No description provided for @updatePasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully'**
  String get updatePasswordSuccess;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutButton;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navClasses.
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get navClasses;

  /// No description provided for @navStudents.
  ///
  /// In en, this message translates to:
  /// **'Students'**
  String get navStudents;

  /// No description provided for @navMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get navMessages;

  /// No description provided for @navSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get navSchedule;

  /// No description provided for @navClassesPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Class tools will appear here.'**
  String get navClassesPlaceholder;

  /// No description provided for @navStudentsPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Student records will appear here.'**
  String get navStudentsPlaceholder;

  /// No description provided for @navMessagesPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Messages will appear here.'**
  String get navMessagesPlaceholder;

  /// No description provided for @navSchedulePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Schedule tools will appear here.'**
  String get navSchedulePlaceholder;

  /// No description provided for @coursesMyCoursesTab.
  ///
  /// In en, this message translates to:
  /// **'My Courses'**
  String get coursesMyCoursesTab;

  /// No description provided for @coursesBrowseAllTab.
  ///
  /// In en, this message translates to:
  /// **'Browse All'**
  String get coursesBrowseAllTab;

  /// No description provided for @coursesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search courses'**
  String get coursesSearchHint;

  /// No description provided for @coursesFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get coursesFilterAll;

  /// No description provided for @coursesFilterPublished.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get coursesFilterPublished;

  /// No description provided for @coursesFilterUnpublished.
  ///
  /// In en, this message translates to:
  /// **'Unpublished'**
  String get coursesFilterUnpublished;

  /// No description provided for @coursesNoCoursesTitle.
  ///
  /// In en, this message translates to:
  /// **'No courses found'**
  String get coursesNoCoursesTitle;

  /// No description provided for @coursesNoMatchesMessage.
  ///
  /// In en, this message translates to:
  /// **'Try a different search or filter.'**
  String get coursesNoMatchesMessage;

  /// No description provided for @coursesNoMyCoursesMessage.
  ///
  /// In en, this message translates to:
  /// **'You are not enrolled in or teaching any courses yet.'**
  String get coursesNoMyCoursesMessage;

  /// No description provided for @coursesNoBrowseCoursesMessage.
  ///
  /// In en, this message translates to:
  /// **'Check back later for new courses.'**
  String get coursesNoBrowseCoursesMessage;

  /// No description provided for @coursesDefaultStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get coursesDefaultStatusActive;

  /// No description provided for @coursesLessonsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 lessons} =1{1 lesson} other{{count} lessons}}'**
  String coursesLessonsCount(int count);

  /// No description provided for @coursesEnrollmentsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 enrolled} =1{1 enrolled} other{{count} enrolled}}'**
  String coursesEnrollmentsCount(int count);

  /// No description provided for @courseDetails.
  ///
  /// In en, this message translates to:
  /// **'Course Details'**
  String get courseDetails;

  /// No description provided for @courseOutline.
  ///
  /// In en, this message translates to:
  /// **'Course Outline'**
  String get courseOutline;

  /// No description provided for @instructors.
  ///
  /// In en, this message translates to:
  /// **'Instructors'**
  String get instructors;

  /// No description provided for @createCourse.
  ///
  /// In en, this message translates to:
  /// **'Create Course'**
  String get createCourse;

  /// No description provided for @editCourse.
  ///
  /// In en, this message translates to:
  /// **'Edit Course'**
  String get editCourse;

  /// No description provided for @deleteCourse.
  ///
  /// In en, this message translates to:
  /// **'Delete Course'**
  String get deleteCourse;

  /// No description provided for @deleteCourseConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Course'**
  String get deleteCourseConfirmTitle;

  /// No description provided for @deleteCourseConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this course?'**
  String get deleteCourseConfirmBody;

  /// No description provided for @courseCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Course created successfully'**
  String get courseCreatedSuccess;

  /// No description provided for @courseUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Course updated successfully'**
  String get courseUpdatedSuccess;

  /// No description provided for @courseDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Course deleted successfully'**
  String get courseDeletedSuccess;

  /// No description provided for @courseTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Course Title'**
  String get courseTitleLabel;

  /// No description provided for @courseDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get courseDescriptionLabel;

  /// No description provided for @courseShortIntroLabel.
  ///
  /// In en, this message translates to:
  /// **'Short Introduction'**
  String get courseShortIntroLabel;

  /// No description provided for @courseTagsLabel.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get courseTagsLabel;

  /// No description provided for @courseVideoLinkLabel.
  ///
  /// In en, this message translates to:
  /// **'Intro Video Link'**
  String get courseVideoLinkLabel;

  /// No description provided for @coursePublishedLabel.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get coursePublishedLabel;

  /// No description provided for @courseEnableCertificationLabel.
  ///
  /// In en, this message translates to:
  /// **'Enable Certification'**
  String get courseEnableCertificationLabel;

  /// No description provided for @courseTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get courseTitleRequired;

  /// No description provided for @courseShortIntroRequired.
  ///
  /// In en, this message translates to:
  /// **'Short introduction is required'**
  String get courseShortIntroRequired;

  /// No description provided for @courseDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get courseDescriptionRequired;

  /// No description provided for @courseImageLabel.
  ///
  /// In en, this message translates to:
  /// **'Course Image'**
  String get courseImageLabel;

  /// No description provided for @courseImageHint.
  ///
  /// In en, this message translates to:
  /// **'Paste image URL or upload a file'**
  String get courseImageHint;

  /// No description provided for @selectCourseImage.
  ///
  /// In en, this message translates to:
  /// **'Select Course Image'**
  String get selectCourseImage;

  /// No description provided for @courseBasicInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get courseBasicInfoSection;

  /// No description provided for @courseMediaSection.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get courseMediaSection;

  /// No description provided for @courseTagsSection.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get courseTagsSection;

  /// No description provided for @courseSettingsSection.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get courseSettingsSection;

  /// No description provided for @courseTagsHint.
  ///
  /// In en, this message translates to:
  /// **'Comma-separated, e.g. python, beginner'**
  String get courseTagsHint;

  /// No description provided for @noChaptersOrLessons.
  ///
  /// In en, this message translates to:
  /// **'No chapters or lessons listed for this course yet.'**
  String get noChaptersOrLessons;

  /// No description provided for @createChapter.
  ///
  /// In en, this message translates to:
  /// **'Create Chapter'**
  String get createChapter;

  /// No description provided for @editChapter.
  ///
  /// In en, this message translates to:
  /// **'Edit Chapter'**
  String get editChapter;

  /// No description provided for @deleteChapter.
  ///
  /// In en, this message translates to:
  /// **'Delete Chapter'**
  String get deleteChapter;

  /// No description provided for @deleteChapterConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Chapter'**
  String get deleteChapterConfirmTitle;

  /// No description provided for @deleteChapterConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this chapter?'**
  String get deleteChapterConfirmBody;

  /// No description provided for @chapterCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Chapter created successfully'**
  String get chapterCreatedSuccess;

  /// No description provided for @chapterUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Chapter updated successfully'**
  String get chapterUpdatedSuccess;

  /// No description provided for @chapterDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Chapter deleted successfully'**
  String get chapterDeletedSuccess;

  /// No description provided for @chapterTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Chapter Title'**
  String get chapterTitleLabel;

  /// No description provided for @chapterTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get chapterTitleRequired;

  /// No description provided for @isScormPackageLabel.
  ///
  /// In en, this message translates to:
  /// **'Is SCORM Package'**
  String get isScormPackageLabel;

  /// No description provided for @lessonMaterial.
  ///
  /// In en, this message translates to:
  /// **'Lesson Material'**
  String get lessonMaterial;

  /// No description provided for @createLesson.
  ///
  /// In en, this message translates to:
  /// **'Create Lesson'**
  String get createLesson;

  /// No description provided for @editLesson.
  ///
  /// In en, this message translates to:
  /// **'Edit Lesson'**
  String get editLesson;

  /// No description provided for @deleteLesson.
  ///
  /// In en, this message translates to:
  /// **'Delete Lesson'**
  String get deleteLesson;

  /// No description provided for @deleteLessonConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Lesson'**
  String get deleteLessonConfirmTitle;

  /// No description provided for @deleteLessonConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this lesson?'**
  String get deleteLessonConfirmBody;

  /// No description provided for @lessonCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Lesson created successfully'**
  String get lessonCreatedSuccess;

  /// No description provided for @lessonUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Lesson updated successfully'**
  String get lessonUpdatedSuccess;

  /// No description provided for @lessonDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Lesson deleted successfully'**
  String get lessonDeletedSuccess;

  /// No description provided for @confirmRemoveQuizFromLessonTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove Quiz'**
  String get confirmRemoveQuizFromLessonTitle;

  /// No description provided for @confirmRemoveQuizFromLesson.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this quiz from the lesson?'**
  String get confirmRemoveQuizFromLesson;

  /// No description provided for @selectQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Quiz'**
  String get selectQuizTitle;

  /// No description provided for @searchQuizHint.
  ///
  /// In en, this message translates to:
  /// **'Search quizzes...'**
  String get searchQuizHint;

  /// No description provided for @noQuizzesFound.
  ///
  /// In en, this message translates to:
  /// **'No quizzes found'**
  String get noQuizzesFound;

  /// No description provided for @lessonTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Lesson Title'**
  String get lessonTitleLabel;

  /// No description provided for @lessonTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get lessonTitleRequired;

  /// No description provided for @includeInPreviewLabel.
  ///
  /// In en, this message translates to:
  /// **'Include in Preview'**
  String get includeInPreviewLabel;

  /// No description provided for @contentTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Content Type'**
  String get contentTypeLabel;

  /// No description provided for @instructorNotes.
  ///
  /// In en, this message translates to:
  /// **'Instructor Notes'**
  String get instructorNotes;

  /// No description provided for @contentTypeText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get contentTypeText;

  /// No description provided for @contentTypeYouTube.
  ///
  /// In en, this message translates to:
  /// **'YouTube Video'**
  String get contentTypeYouTube;

  /// No description provided for @contentTypeVideo.
  ///
  /// In en, this message translates to:
  /// **'Upload Video'**
  String get contentTypeVideo;

  /// No description provided for @contentTypePdf.
  ///
  /// In en, this message translates to:
  /// **'Upload PDF'**
  String get contentTypePdf;

  /// No description provided for @contentTypeQuiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get contentTypeQuiz;

  /// No description provided for @contentTypeCode.
  ///
  /// In en, this message translates to:
  /// **'Code Box'**
  String get contentTypeCode;

  /// No description provided for @lessonMarkdownLabel.
  ///
  /// In en, this message translates to:
  /// **'Lesson Text'**
  String get lessonMarkdownLabel;

  /// No description provided for @lessonMarkdownHint.
  ///
  /// In en, this message translates to:
  /// **'Write lesson text. Markdown is supported.'**
  String get lessonMarkdownHint;

  /// No description provided for @lessonPartContentRequired.
  ///
  /// In en, this message translates to:
  /// **'Every lesson part needs content.'**
  String get lessonPartContentRequired;

  /// No description provided for @youtubeUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'YouTube Video URL'**
  String get youtubeUrlLabel;

  /// No description provided for @youtubeUrlHint.
  ///
  /// In en, this message translates to:
  /// **'Enter YouTube link'**
  String get youtubeUrlHint;

  /// No description provided for @youtubeUrlInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid YouTube URL'**
  String get youtubeUrlInvalid;

  /// No description provided for @quizNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Quiz Name'**
  String get quizNameLabel;

  /// No description provided for @codeContentLabel.
  ///
  /// In en, this message translates to:
  /// **'Code Snippet'**
  String get codeContentLabel;

  /// No description provided for @codeLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Programming Language'**
  String get codeLanguageLabel;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select File'**
  String get selectFile;

  /// No description provided for @uploadingFile.
  ///
  /// In en, this message translates to:
  /// **'Uploading File...'**
  String get uploadingFile;

  /// No description provided for @uploadSuccess.
  ///
  /// In en, this message translates to:
  /// **'File uploaded successfully'**
  String get uploadSuccess;

  /// No description provided for @uploadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload file'**
  String get uploadError;

  /// No description provided for @youtubeVideoLink.
  ///
  /// In en, this message translates to:
  /// **'YouTube Video Link'**
  String get youtubeVideoLink;

  /// No description provided for @copyVideoLink.
  ///
  /// In en, this message translates to:
  /// **'Copy Video Link'**
  String get copyVideoLink;

  /// No description provided for @linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied to clipboard'**
  String get linkCopied;

  /// No description provided for @codeCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Code copied to clipboard'**
  String get codeCopiedToClipboard;

  /// No description provided for @interactiveAssessment.
  ///
  /// In en, this message translates to:
  /// **'Interactive Assessment'**
  String get interactiveAssessment;

  /// No description provided for @startQuizNow.
  ///
  /// In en, this message translates to:
  /// **'Start Quiz Now'**
  String get startQuizNow;

  /// No description provided for @openVideo.
  ///
  /// In en, this message translates to:
  /// **'Open Video'**
  String get openVideo;

  /// No description provided for @downloadFile.
  ///
  /// In en, this message translates to:
  /// **'Download File'**
  String get downloadFile;

  /// No description provided for @unableToStreamPrivateFile.
  ///
  /// In en, this message translates to:
  /// **'This is a private school resource. Tap below to download or view it in an external app.'**
  String get unableToStreamPrivateFile;

  /// No description provided for @viewPdf.
  ///
  /// In en, this message translates to:
  /// **'View PDF'**
  String get viewPdf;

  /// No description provided for @openPdf.
  ///
  /// In en, this message translates to:
  /// **'Open PDF'**
  String get openPdf;

  /// No description provided for @unsupportedBlockType.
  ///
  /// In en, this message translates to:
  /// **'Unsupported block type'**
  String get unsupportedBlockType;

  /// No description provided for @malformedContent.
  ///
  /// In en, this message translates to:
  /// **'Malformed content'**
  String get malformedContent;

  /// No description provided for @openLink.
  ///
  /// In en, this message translates to:
  /// **'Open Link'**
  String get openLink;

  /// No description provided for @quizPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Quizzes are currently read-only'**
  String get quizPlaceholder;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicate;

  /// No description provided for @homeQuizzesAction.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get homeQuizzesAction;

  /// No description provided for @homeHomeworkAction.
  ///
  /// In en, this message translates to:
  /// **'Homework'**
  String get homeHomeworkAction;

  /// No description provided for @quizzesTitle.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get quizzesTitle;

  /// No description provided for @quizzesMockClassLabel.
  ///
  /// In en, this message translates to:
  /// **'CLASS MATH-10A'**
  String get quizzesMockClassLabel;

  /// No description provided for @quizCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create Quiz'**
  String get quizCreateButton;

  /// No description provided for @quizFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All Assessments'**
  String get quizFilterAll;

  /// No description provided for @quizTypeQuiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quizTypeQuiz;

  /// No description provided for @quizTypeMidterm.
  ///
  /// In en, this message translates to:
  /// **'Midterm'**
  String get quizTypeMidterm;

  /// No description provided for @quizTypeFinal.
  ///
  /// In en, this message translates to:
  /// **'Final'**
  String get quizTypeFinal;

  /// No description provided for @quizTimelineUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get quizTimelineUpcoming;

  /// No description provided for @quizTimelinePast.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get quizTimelinePast;

  /// No description provided for @quizTimelineStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Timeline Status'**
  String get quizTimelineStatusLabel;

  /// No description provided for @quizResultStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Result Status'**
  String get quizResultStatusLabel;

  /// No description provided for @quizResultPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get quizResultPending;

  /// No description provided for @quizResultGraded.
  ///
  /// In en, this message translates to:
  /// **'Graded {graded}/{submitted}'**
  String quizResultGraded(int graded, int submitted);

  /// No description provided for @quizResultNeedsGrading.
  ///
  /// In en, this message translates to:
  /// **'Needs Grading {graded}/{submitted}'**
  String quizResultNeedsGrading(int graded, int submitted);

  /// No description provided for @quizSubmittedProgress.
  ///
  /// In en, this message translates to:
  /// **'Submitted {submitted}/{total}'**
  String quizSubmittedProgress(int submitted, int total);

  /// No description provided for @quizGradedProgress.
  ///
  /// In en, this message translates to:
  /// **'Graded {graded}/{submitted}'**
  String quizGradedProgress(int graded, int submitted);

  /// No description provided for @quizzesEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No assessments found.'**
  String get quizzesEmptyMessage;

  /// No description provided for @quizCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Assessment'**
  String get quizCreateTitle;

  /// No description provided for @quizSaveDraft.
  ///
  /// In en, this message translates to:
  /// **'SAVE DRAFT'**
  String get quizSaveDraft;

  /// No description provided for @quizSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Assessment saved successfully'**
  String get quizSavedSuccess;

  /// No description provided for @quizAssessmentTypeSection.
  ///
  /// In en, this message translates to:
  /// **'Assessment Type'**
  String get quizAssessmentTypeSection;

  /// No description provided for @quizBasicInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get quizBasicInfoSection;

  /// No description provided for @quizTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get quizTitleLabel;

  /// No description provided for @quizTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Chapter 4 Functions'**
  String get quizTitleHint;

  /// No description provided for @quizTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get quizTitleRequired;

  /// No description provided for @quizDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get quizDescriptionLabel;

  /// No description provided for @quizDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Add instructions or context...'**
  String get quizDescriptionHint;

  /// No description provided for @quizFormatOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get quizFormatOnline;

  /// No description provided for @quizFormatOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get quizFormatOffline;

  /// No description provided for @quizTimingSection.
  ///
  /// In en, this message translates to:
  /// **'Timing'**
  String get quizTimingSection;

  /// No description provided for @quizStartDateTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Date & Time'**
  String get quizStartDateTimeLabel;

  /// No description provided for @quizStartDateTimeHint.
  ///
  /// In en, this message translates to:
  /// **'mm/dd/yyyy, --:-- --'**
  String get quizStartDateTimeHint;

  /// No description provided for @quizDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration (minutes)'**
  String get quizDurationLabel;

  /// No description provided for @quizMinutesSuffix.
  ///
  /// In en, this message translates to:
  /// **'mins'**
  String get quizMinutesSuffix;

  /// No description provided for @quizGradingSection.
  ///
  /// In en, this message translates to:
  /// **'Grading'**
  String get quizGradingSection;

  /// No description provided for @quizMaxGradeFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Grade'**
  String get quizMaxGradeFieldLabel;

  /// No description provided for @quizMinPassingFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Min Passing'**
  String get quizMinPassingFieldLabel;

  /// No description provided for @quizSecurityResultsSection.
  ///
  /// In en, this message translates to:
  /// **'Security & Results'**
  String get quizSecurityResultsSection;

  /// No description provided for @quizRandomizeQuestions.
  ///
  /// In en, this message translates to:
  /// **'Randomize Questions'**
  String get quizRandomizeQuestions;

  /// No description provided for @quizRandomizeAnswers.
  ///
  /// In en, this message translates to:
  /// **'Randomize Answers'**
  String get quizRandomizeAnswers;

  /// No description provided for @quizShowResultImmediately.
  ///
  /// In en, this message translates to:
  /// **'Show Result Immediately'**
  String get quizShowResultImmediately;

  /// No description provided for @quizShowCorrectAnswers.
  ///
  /// In en, this message translates to:
  /// **'Show Correct Answers'**
  String get quizShowCorrectAnswers;

  /// No description provided for @quizAllowRetake.
  ///
  /// In en, this message translates to:
  /// **'Allow Retake'**
  String get quizAllowRetake;

  /// No description provided for @quizPreventLateSubmission.
  ///
  /// In en, this message translates to:
  /// **'Prevent Late Submission'**
  String get quizPreventLateSubmission;

  /// No description provided for @quizMaxAttemptsLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Attempts'**
  String get quizMaxAttemptsLabel;

  /// No description provided for @quizScheduleButton.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get quizScheduleButton;

  /// No description provided for @quizPublishButton.
  ///
  /// In en, this message translates to:
  /// **'Publish Assessment'**
  String get quizPublishButton;

  /// No description provided for @quizDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz Details'**
  String get quizDetailsTitle;

  /// No description provided for @quizPreviewAction.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get quizPreviewAction;

  /// No description provided for @quizTabDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get quizTabDetails;

  /// No description provided for @quizTabQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get quizTabQuestions;

  /// No description provided for @quizTabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get quizTabSettings;

  /// No description provided for @quizTabResults.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get quizTabResults;

  /// No description provided for @quizDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} mins'**
  String quizDurationMinutes(int minutes);

  /// No description provided for @quizMaxGradeLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Grade: {grade}'**
  String quizMaxGradeLabel(int grade);

  /// No description provided for @quizPassingGradeLabel.
  ///
  /// In en, this message translates to:
  /// **'Passing: {grade}'**
  String quizPassingGradeLabel(int grade);

  /// No description provided for @quizQuestionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 questions} =1{1 question} other{{count} questions}}'**
  String quizQuestionsCount(int count);

  /// No description provided for @quizTotalPoints.
  ///
  /// In en, this message translates to:
  /// **'Total Points: {points}'**
  String quizTotalPoints(int points);

  /// No description provided for @quizPointsSuffix.
  ///
  /// In en, this message translates to:
  /// **'pts total'**
  String get quizPointsSuffix;

  /// No description provided for @quizImportFromBank.
  ///
  /// In en, this message translates to:
  /// **'Import from Bank'**
  String get quizImportFromBank;

  /// No description provided for @quizAddQuestion.
  ///
  /// In en, this message translates to:
  /// **'Add Question'**
  String get quizAddQuestion;

  /// No description provided for @quizNoQuestionsTitle.
  ///
  /// In en, this message translates to:
  /// **'No questions yet'**
  String get quizNoQuestionsTitle;

  /// No description provided for @quizNoQuestionsMessage.
  ///
  /// In en, this message translates to:
  /// **'Add questions to make this quiz ready for students.'**
  String get quizNoQuestionsMessage;

  /// No description provided for @questionNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Q{number}'**
  String questionNumberLabel(int number);

  /// No description provided for @questionPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String questionPointsLabel(int points);

  /// No description provided for @questionRequiredLabel.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get questionRequiredLabel;

  /// No description provided for @questionDifficultyEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get questionDifficultyEasy;

  /// No description provided for @questionDifficultyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get questionDifficultyMedium;

  /// No description provided for @questionDifficultyHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get questionDifficultyHard;

  /// No description provided for @questionTypeMultipleChoice.
  ///
  /// In en, this message translates to:
  /// **'Multiple Choice'**
  String get questionTypeMultipleChoice;

  /// No description provided for @questionTypeTrueFalse.
  ///
  /// In en, this message translates to:
  /// **'True / False'**
  String get questionTypeTrueFalse;

  /// No description provided for @questionTypeShortAnswer.
  ///
  /// In en, this message translates to:
  /// **'Short Answer'**
  String get questionTypeShortAnswer;

  /// No description provided for @questionTypeEssay.
  ///
  /// In en, this message translates to:
  /// **'Essay'**
  String get questionTypeEssay;

  /// No description provided for @questionTypeFillBlank.
  ///
  /// In en, this message translates to:
  /// **'Fill Blank'**
  String get questionTypeFillBlank;

  /// No description provided for @questionTypeMatching.
  ///
  /// In en, this message translates to:
  /// **'Matching'**
  String get questionTypeMatching;

  /// No description provided for @questionTrue.
  ///
  /// In en, this message translates to:
  /// **'True'**
  String get questionTrue;

  /// No description provided for @questionFalse.
  ///
  /// In en, this message translates to:
  /// **'False'**
  String get questionFalse;

  /// No description provided for @questionAcceptedAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Accepted answer'**
  String get questionAcceptedAnswerLabel;

  /// No description provided for @questionAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Question'**
  String get questionAddTitle;

  /// No description provided for @questionEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Question'**
  String get questionEditTitle;

  /// No description provided for @questionSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Question saved successfully'**
  String get questionSavedSuccess;

  /// No description provided for @questionTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Question Type'**
  String get questionTypeLabel;

  /// No description provided for @questionTextLabel.
  ///
  /// In en, this message translates to:
  /// **'Question Text'**
  String get questionTextLabel;

  /// No description provided for @questionTextHint.
  ///
  /// In en, this message translates to:
  /// **'Write your question here...'**
  String get questionTextHint;

  /// No description provided for @questionTextRequired.
  ///
  /// In en, this message translates to:
  /// **'Question text is required'**
  String get questionTextRequired;

  /// No description provided for @questionPointsFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get questionPointsFieldLabel;

  /// No description provided for @questionDifficultyFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get questionDifficultyFieldLabel;

  /// No description provided for @questionOptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Option {letter}'**
  String questionOptionLabel(String letter);

  /// No description provided for @questionAddOption.
  ///
  /// In en, this message translates to:
  /// **'Add Option'**
  String get questionAddOption;

  /// No description provided for @questionCorrectAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Correct Answer'**
  String get questionCorrectAnswerLabel;

  /// No description provided for @questionAcceptedAnswerHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 6x + 2'**
  String get questionAcceptedAnswerHint;

  /// No description provided for @questionEssayInfo.
  ///
  /// In en, this message translates to:
  /// **'Essay questions require manual grading.'**
  String get questionEssayInfo;

  /// No description provided for @questionExplanationLabel.
  ///
  /// In en, this message translates to:
  /// **'Explanation (Optional)'**
  String get questionExplanationLabel;

  /// No description provided for @questionExplanationHint.
  ///
  /// In en, this message translates to:
  /// **'Explain the correct answer...'**
  String get questionExplanationHint;

  /// No description provided for @questionSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Question'**
  String get questionSaveButton;

  /// No description provided for @homeworkManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Homework Management'**
  String get homeworkManagementTitle;

  /// No description provided for @homeworkMockBreadcrumb.
  ///
  /// In en, this message translates to:
  /// **'MATH-10A > Homework'**
  String get homeworkMockBreadcrumb;

  /// No description provided for @homeworkCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create Homework'**
  String get homeworkCreateButton;

  /// No description provided for @homeworkTabPublished.
  ///
  /// In en, this message translates to:
  /// **'Published ({count})'**
  String homeworkTabPublished(int count);

  /// No description provided for @homeworkTabDrafts.
  ///
  /// In en, this message translates to:
  /// **'Drafts ({count})'**
  String homeworkTabDrafts(int count);

  /// No description provided for @homeworkTabScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled ({count})'**
  String homeworkTabScheduled(int count);

  /// No description provided for @homeworkEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No homework found.'**
  String get homeworkEmptyMessage;

  /// No description provided for @homeworkDueToday.
  ///
  /// In en, this message translates to:
  /// **'Due Today, {time}'**
  String homeworkDueToday(String time);

  /// No description provided for @homeworkDueOn.
  ///
  /// In en, this message translates to:
  /// **'Due {dateTime}'**
  String homeworkDueOn(String dateTime);

  /// No description provided for @homeworkSubmissionProgress.
  ///
  /// In en, this message translates to:
  /// **'Submission Progress: {submitted}/{total}'**
  String homeworkSubmissionProgress(int submitted, int total);

  /// No description provided for @homeworkDuplicatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Homework duplicated successfully'**
  String get homeworkDuplicatedSuccess;

  /// No description provided for @homeworkDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete homework?'**
  String get homeworkDeleteConfirmTitle;

  /// No description provided for @homeworkDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete {title}.'**
  String homeworkDeleteConfirmMessage(String title);

  /// No description provided for @homeworkDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Homework deleted successfully'**
  String get homeworkDeletedSuccess;

  /// No description provided for @homeworkAddFileTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Assessment File'**
  String get homeworkAddFileTitle;

  /// No description provided for @homeworkEditFileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Assessment File'**
  String get homeworkEditFileTitle;

  /// No description provided for @homeworkSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Homework saved successfully'**
  String get homeworkSavedSuccess;

  /// No description provided for @homeworkFileDetailsSection.
  ///
  /// In en, this message translates to:
  /// **'File Details'**
  String get homeworkFileDetailsSection;

  /// No description provided for @homeworkTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get homeworkTitleLabel;

  /// No description provided for @homeworkTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Midterm Review Worksheet'**
  String get homeworkTitleHint;

  /// No description provided for @homeworkTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get homeworkTitleRequired;

  /// No description provided for @homeworkCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get homeworkCategoryLabel;

  /// No description provided for @homeworkUploadSection.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get homeworkUploadSection;

  /// No description provided for @homeworkUploadHint.
  ///
  /// In en, this message translates to:
  /// **'Click to Upload or Drag & Drop'**
  String get homeworkUploadHint;

  /// No description provided for @homeworkUploadSupportedTypes.
  ///
  /// In en, this message translates to:
  /// **'Supports PDF, DOCX, XLSX'**
  String get homeworkUploadSupportedTypes;

  /// No description provided for @homeworkTargetSection.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get homeworkTargetSection;

  /// No description provided for @homeworkTargetExamQuiz.
  ///
  /// In en, this message translates to:
  /// **'Attach to Exam/Quiz'**
  String get homeworkTargetExamQuiz;

  /// No description provided for @homeworkTargetLesson.
  ///
  /// In en, this message translates to:
  /// **'Attach to Lesson'**
  String get homeworkTargetLesson;

  /// No description provided for @homeworkSearchExamLabel.
  ///
  /// In en, this message translates to:
  /// **'Search or Select Exam'**
  String get homeworkSearchExamLabel;

  /// No description provided for @homeworkSearchLessonLabel.
  ///
  /// In en, this message translates to:
  /// **'Search or Select Lesson'**
  String get homeworkSearchLessonLabel;

  /// No description provided for @homeworkSearchTargetHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Midterm Math 101'**
  String get homeworkSearchTargetHint;

  /// No description provided for @homeworkTargetRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a target'**
  String get homeworkTargetRequired;

  /// No description provided for @homeworkUploadAndAttach.
  ///
  /// In en, this message translates to:
  /// **'Upload and Attach'**
  String get homeworkUploadAndAttach;

  /// No description provided for @classesTitle.
  ///
  /// In en, this message translates to:
  /// **'My Classes'**
  String get classesTitle;

  /// No description provided for @classesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your active courses and assignments.'**
  String get classesSubtitle;

  /// No description provided for @classesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search classes...'**
  String get classesSearchHint;

  /// No description provided for @classFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All Classes'**
  String get classFilterAll;

  /// No description provided for @classFilterMathematics.
  ///
  /// In en, this message translates to:
  /// **'Mathematics'**
  String get classFilterMathematics;

  /// No description provided for @classFilterScience.
  ///
  /// In en, this message translates to:
  /// **'Science'**
  String get classFilterScience;

  /// No description provided for @classFilterNetworking.
  ///
  /// In en, this message translates to:
  /// **'Networking'**
  String get classFilterNetworking;

  /// No description provided for @classFilterLiterature.
  ///
  /// In en, this message translates to:
  /// **'Literature'**
  String get classFilterLiterature;

  /// No description provided for @classStudentsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Students'**
  String classStudentsCount(int count);

  /// No description provided for @classNextLesson.
  ///
  /// In en, this message translates to:
  /// **'NEXT LESSON'**
  String get classNextLesson;

  /// No description provided for @classSubmissions.
  ///
  /// In en, this message translates to:
  /// **'SUBMISSIONS'**
  String get classSubmissions;

  /// No description provided for @classPendingReview.
  ///
  /// In en, this message translates to:
  /// **'{count} Pending Review'**
  String classPendingReview(int count);

  /// No description provided for @classAllCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'All Caught Up'**
  String get classAllCaughtUp;

  /// No description provided for @classUrgentAlert.
  ///
  /// In en, this message translates to:
  /// **'URGENT ALERT'**
  String get classUrgentAlert;

  /// No description provided for @classDetailViewStudents.
  ///
  /// In en, this message translates to:
  /// **'View Students'**
  String get classDetailViewStudents;

  /// No description provided for @classDetailExamsQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Exams & Quizzes'**
  String get classDetailExamsQuizzes;

  /// No description provided for @classCurriculum.
  ///
  /// In en, this message translates to:
  /// **'Curriculum'**
  String get classCurriculum;

  /// No description provided for @classCurriculumWeek.
  ///
  /// In en, this message translates to:
  /// **'Week {current} of {total}'**
  String classCurriculumWeek(int current, int total);

  /// No description provided for @classActivity.
  ///
  /// In en, this message translates to:
  /// **'Class Activity'**
  String get classActivity;

  /// No description provided for @classAttendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get classAttendance;

  /// No description provided for @classPresentToday.
  ///
  /// In en, this message translates to:
  /// **'PRESENT TODAY'**
  String get classPresentToday;

  /// No description provided for @classAbsentToday.
  ///
  /// In en, this message translates to:
  /// **'ABSENT TODAY'**
  String get classAbsentToday;

  /// No description provided for @classTakeAttendance.
  ///
  /// In en, this message translates to:
  /// **'Take Attendance'**
  String get classTakeAttendance;

  /// No description provided for @classPerformance.
  ///
  /// In en, this message translates to:
  /// **'Class Performance'**
  String get classPerformance;

  /// No description provided for @classAverage.
  ///
  /// In en, this message translates to:
  /// **'Class Average'**
  String get classAverage;

  /// No description provided for @classAssignmentCompletion.
  ///
  /// In en, this message translates to:
  /// **'Assignment Completion'**
  String get classAssignmentCompletion;

  /// No description provided for @classGradeNow.
  ///
  /// In en, this message translates to:
  /// **'Grade Now'**
  String get classGradeNow;

  /// No description provided for @classSubmitted.
  ///
  /// In en, this message translates to:
  /// **'SUBMITTED'**
  String get classSubmitted;

  /// No description provided for @myCoursesTitle.
  ///
  /// In en, this message translates to:
  /// **'My Courses'**
  String get myCoursesTitle;

  /// No description provided for @myCoursesEmpty.
  ///
  /// In en, this message translates to:
  /// **'You have no courses yet.'**
  String get myCoursesEmpty;

  /// No description provided for @myCoursesButton.
  ///
  /// In en, this message translates to:
  /// **'My Courses'**
  String get myCoursesButton;

  /// No description provided for @classStudents.
  ///
  /// In en, this message translates to:
  /// **'students'**
  String get classStudents;

  /// No description provided for @coursesLessonsLabel.
  ///
  /// In en, this message translates to:
  /// **'Lessons'**
  String get coursesLessonsLabel;

  /// No description provided for @coursesStudentsLabel.
  ///
  /// In en, this message translates to:
  /// **'Students'**
  String get coursesStudentsLabel;

  /// No description provided for @coursesRatingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get coursesRatingLabel;

  /// No description provided for @myCoursesCoTaughtBy.
  ///
  /// In en, this message translates to:
  /// **'Co-taught w/ {names}'**
  String myCoursesCoTaughtBy(String names);

  /// No description provided for @questionTypeChoices.
  ///
  /// In en, this message translates to:
  /// **'Choices'**
  String get questionTypeChoices;

  /// No description provided for @questionTypeUserInput.
  ///
  /// In en, this message translates to:
  /// **'User Input'**
  String get questionTypeUserInput;

  /// No description provided for @questionTypeOpenEnded.
  ///
  /// In en, this message translates to:
  /// **'Open Ended'**
  String get questionTypeOpenEnded;

  /// No description provided for @questionTypeFileUpload.
  ///
  /// In en, this message translates to:
  /// **'File Upload'**
  String get questionTypeFileUpload;

  /// No description provided for @quizPassingPercentage.
  ///
  /// In en, this message translates to:
  /// **'Passing Percentage'**
  String get quizPassingPercentage;

  /// No description provided for @quizMaxAttempts.
  ///
  /// In en, this message translates to:
  /// **'Max Attempts'**
  String get quizMaxAttempts;

  /// No description provided for @quizMaxAttemptsUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get quizMaxAttemptsUnlimited;

  /// No description provided for @quizShuffleQuestions.
  ///
  /// In en, this message translates to:
  /// **'Shuffle Questions'**
  String get quizShuffleQuestions;

  /// No description provided for @quizShowAnswers.
  ///
  /// In en, this message translates to:
  /// **'Show Answers'**
  String get quizShowAnswers;

  /// No description provided for @quizEnableNegativeMarking.
  ///
  /// In en, this message translates to:
  /// **'Enable Negative Marking'**
  String get quizEnableNegativeMarking;

  /// No description provided for @quizMarksToCut.
  ///
  /// In en, this message translates to:
  /// **'Marks To Cut'**
  String get quizMarksToCut;

  /// No description provided for @quizLimitQuestions.
  ///
  /// In en, this message translates to:
  /// **'Limit Questions To'**
  String get quizLimitQuestions;

  /// No description provided for @questionMultipleCorrect.
  ///
  /// In en, this message translates to:
  /// **'Multiple Correct Answers'**
  String get questionMultipleCorrect;

  /// No description provided for @questionPossibilitiesLabel.
  ///
  /// In en, this message translates to:
  /// **'Accepted Possibilities'**
  String get questionPossibilitiesLabel;

  /// No description provided for @questionPossibility.
  ///
  /// In en, this message translates to:
  /// **'Possibility'**
  String get questionPossibility;

  /// No description provided for @questionOpenEndedHint.
  ///
  /// In en, this message translates to:
  /// **'Open-ended questions require manual grading by the teacher.'**
  String get questionOpenEndedHint;

  /// No description provided for @questionFileUploadHint.
  ///
  /// In en, this message translates to:
  /// **'Students answer this question by uploading a file. It requires manual grading.'**
  String get questionFileUploadHint;

  /// No description provided for @quizMaxAttemptsHelper.
  ///
  /// In en, this message translates to:
  /// **'Enter 0 for unlimited attempts'**
  String get quizMaxAttemptsHelper;

  /// No description provided for @quizDurationHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for unlimited duration'**
  String get quizDurationHint;

  /// No description provided for @quizLimitQuestionsHelper.
  ///
  /// In en, this message translates to:
  /// **'Randomly pick N questions (0 for all)'**
  String get quizLimitQuestionsHelper;

  /// No description provided for @questionBankTitle.
  ///
  /// In en, this message translates to:
  /// **'Question Bank'**
  String get questionBankTitle;

  /// No description provided for @questionCenterTitle.
  ///
  /// In en, this message translates to:
  /// **'Question Center'**
  String get questionCenterTitle;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get search;

  /// No description provided for @addToQuiz.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addToQuiz;

  /// No description provided for @quizTabOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get quizTabOverview;

  /// No description provided for @quizTabReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get quizTabReview;

  /// No description provided for @quizTimeLimitLabel.
  ///
  /// In en, this message translates to:
  /// **'Time Limit'**
  String get quizTimeLimitLabel;

  /// No description provided for @quizPassingScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Passing Score'**
  String get quizPassingScoreLabel;

  /// No description provided for @quizNoQuestionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start building your assessment by adding questions manually or importing from the question bank.'**
  String get quizNoQuestionsSubtitle;

  /// No description provided for @quizErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get quizErrorTitle;

  /// No description provided for @quizRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get quizRetryButton;

  /// No description provided for @questionBankFilterType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get questionBankFilterType;

  /// No description provided for @questionBankFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get questionBankFilterAll;

  /// No description provided for @questionBankFilterDifficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get questionBankFilterDifficulty;

  /// No description provided for @questionBankFilterPoints.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get questionBankFilterPoints;

  /// No description provided for @questionBankFilterTopic.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get questionBankFilterTopic;

  /// No description provided for @questionBankClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get questionBankClearFilters;

  /// No description provided for @questionBankEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No questions found'**
  String get questionBankEmptyTitle;

  /// No description provided for @questionBankEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Create questions or check back later.'**
  String get questionBankEmptyMessage;

  /// No description provided for @questionBankNoMatches.
  ///
  /// In en, this message translates to:
  /// **'Try a different search or filter.'**
  String get questionBankNoMatches;

  /// No description provided for @questionBankManualTypeBlocked.
  ///
  /// In en, this message translates to:
  /// **'This quiz already has auto-graded questions, so manual question types cannot be mixed in.'**
  String get questionBankManualTypeBlocked;

  /// No description provided for @questionBankAutoTypeBlocked.
  ///
  /// In en, this message translates to:
  /// **'This quiz already has manual question types, so auto-graded questions cannot be mixed in.'**
  String get questionBankAutoTypeBlocked;

  /// No description provided for @questionDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Question deleted successfully'**
  String get questionDeletedSuccess;

  /// No description provided for @questionBankSelectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 question selected} other{{count} questions selected}}'**
  String questionBankSelectedCount(int count);

  /// No description provided for @questionBankClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get questionBankClear;

  /// No description provided for @quizSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Quiz Setup'**
  String get quizSetupTitle;

  /// No description provided for @quizGeneralDetails.
  ///
  /// In en, this message translates to:
  /// **'General Details'**
  String get quizGeneralDetails;

  /// No description provided for @quizGradingLimits.
  ///
  /// In en, this message translates to:
  /// **'Grading & Limits'**
  String get quizGradingLimits;

  /// No description provided for @quizBehavior.
  ///
  /// In en, this message translates to:
  /// **'Quiz Behavior'**
  String get quizBehavior;

  /// No description provided for @questionSavedDraft.
  ///
  /// In en, this message translates to:
  /// **'Saved Draft'**
  String get questionSavedDraft;

  /// No description provided for @questionAttachMedia.
  ///
  /// In en, this message translates to:
  /// **'Attach Media'**
  String get questionAttachMedia;

  /// No description provided for @quizReorderButton.
  ///
  /// In en, this message translates to:
  /// **'Reorder'**
  String get quizReorderButton;

  /// No description provided for @questionOfTotal.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String questionOfTotal(int current, int total);

  /// No description provided for @quizChoicesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 choice} other{{count} choices}}'**
  String quizChoicesCount(int count);

  /// No description provided for @quizSaveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save Settings'**
  String get quizSaveSettings;

  /// No description provided for @quizReviewPlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Results not available'**
  String get quizReviewPlaceholderTitle;

  /// No description provided for @quizReviewPlaceholderMessage.
  ///
  /// In en, this message translates to:
  /// **'Result tracking is not fully integrated yet.'**
  String get quizReviewPlaceholderMessage;

  /// No description provided for @quizCourseLabel.
  ///
  /// In en, this message translates to:
  /// **'Course'**
  String get quizCourseLabel;

  /// No description provided for @quizLessonLabel.
  ///
  /// In en, this message translates to:
  /// **'Lesson'**
  String get quizLessonLabel;

  /// No description provided for @quizTimeLimitToggle.
  ///
  /// In en, this message translates to:
  /// **'Time Limit'**
  String get quizTimeLimitToggle;

  /// No description provided for @quizMinutesLabel.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get quizMinutesLabel;

  /// No description provided for @quizShowCorrectAnswersToggle.
  ///
  /// In en, this message translates to:
  /// **'Show Correct Answers'**
  String get quizShowCorrectAnswersToggle;

  /// No description provided for @quizNegativeMarkingToggle.
  ///
  /// In en, this message translates to:
  /// **'Negative Marking'**
  String get quizNegativeMarkingToggle;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @saveLocally.
  ///
  /// In en, this message translates to:
  /// **'Save Locally'**
  String get saveLocally;

  /// No description provided for @addNew.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get addNew;

  /// No description provided for @questionRemoved.
  ///
  /// In en, this message translates to:
  /// **'Question removed'**
  String get questionRemoved;

  /// No description provided for @questionsAddedFromBank.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 question added from bank} other{{count} questions added from bank}}'**
  String questionsAddedFromBank(int count);

  /// No description provided for @homeworkFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get homeworkFilterLabel;

  /// No description provided for @homeworkFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get homeworkFilterAll;

  /// No description provided for @homeworkFilterPublished.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get homeworkFilterPublished;

  /// No description provided for @homeworkFilterDrafts.
  ///
  /// In en, this message translates to:
  /// **'Drafts'**
  String get homeworkFilterDrafts;

  /// No description provided for @homeworkViewDetails.
  ///
  /// In en, this message translates to:
  /// **'Homework Details'**
  String get homeworkViewDetails;

  /// No description provided for @homeworkNoCourse.
  ///
  /// In en, this message translates to:
  /// **'No course'**
  String get homeworkNoCourse;

  /// No description provided for @homeworkNoDueDate.
  ///
  /// In en, this message translates to:
  /// **'No due date set'**
  String get homeworkNoDueDate;

  /// No description provided for @homeworkUntitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled homework'**
  String get homeworkUntitled;

  /// No description provided for @homeworkLateAllowed.
  ///
  /// In en, this message translates to:
  /// **'Late submissions allowed'**
  String get homeworkLateAllowed;

  /// No description provided for @homeworkAttachmentAvailable.
  ///
  /// In en, this message translates to:
  /// **'Attachment available'**
  String get homeworkAttachmentAvailable;

  /// No description provided for @homeworkEndOfResults.
  ///
  /// In en, this message translates to:
  /// **'You have reached the end.'**
  String get homeworkEndOfResults;

  /// No description provided for @homeworkLoadMoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load more homework.'**
  String get homeworkLoadMoreFailed;

  /// No description provided for @homeworkInstructionsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No instructions provided.'**
  String get homeworkInstructionsUnavailable;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @marks.
  ///
  /// In en, this message translates to:
  /// **'Marks'**
  String get marks;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @courseLesson.
  ///
  /// In en, this message translates to:
  /// **'Lesson'**
  String get courseLesson;

  /// No description provided for @homeworkTotalMarks.
  ///
  /// In en, this message translates to:
  /// **'Total Marks'**
  String get homeworkTotalMarks;

  /// No description provided for @homeworkQuestionsTab.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get homeworkQuestionsTab;

  /// No description provided for @homeworkSubmissionsTab.
  ///
  /// In en, this message translates to:
  /// **'Submissions'**
  String get homeworkSubmissionsTab;

  /// No description provided for @homeworkSaveDraft.
  ///
  /// In en, this message translates to:
  /// **'Save as Draft'**
  String get homeworkSaveDraft;

  /// No description provided for @homeworkPublish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get homeworkPublish;

  /// No description provided for @homeworkUnpublish.
  ///
  /// In en, this message translates to:
  /// **'Unpublish'**
  String get homeworkUnpublish;

  /// No description provided for @homeworkQuestionTab.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get homeworkQuestionTab;

  /// No description provided for @homeworkAnswer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get homeworkAnswer;

  /// No description provided for @homeworkNoAnswer.
  ///
  /// In en, this message translates to:
  /// **'No answer provided.'**
  String get homeworkNoAnswer;

  /// No description provided for @homeworkAutoGraded.
  ///
  /// In en, this message translates to:
  /// **'Auto-graded'**
  String get homeworkAutoGraded;

  /// No description provided for @homeworkAssignMarks.
  ///
  /// In en, this message translates to:
  /// **'Assign Marks'**
  String get homeworkAssignMarks;

  /// No description provided for @homeworkQuestionNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get homeworkQuestionNote;

  /// No description provided for @homeworkAddNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Add feedback note...'**
  String get homeworkAddNoteHint;

  /// No description provided for @homeworkLate.
  ///
  /// In en, this message translates to:
  /// **'Late Submission'**
  String get homeworkLate;

  /// No description provided for @homeworkOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get homeworkOverview;

  /// No description provided for @homeworkCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Homework created successfully'**
  String get homeworkCreatedSuccess;

  /// No description provided for @homeworkBasicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get homeworkBasicInfo;

  /// No description provided for @homeworkReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Homework'**
  String get homeworkReviewTitle;

  /// No description provided for @homeworkFileDownloaded.
  ///
  /// In en, this message translates to:
  /// **'File downloaded successfully'**
  String get homeworkFileDownloaded;

  /// No description provided for @homeworkGradedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Submission graded successfully'**
  String get homeworkGradedSuccess;

  /// No description provided for @homeworkGradeSubmissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Grade Submission'**
  String get homeworkGradeSubmissionTitle;

  /// No description provided for @homeworkOverallFeedback.
  ///
  /// In en, this message translates to:
  /// **'Overall Feedback'**
  String get homeworkOverallFeedback;

  /// No description provided for @homeworkFeedbackHint.
  ///
  /// In en, this message translates to:
  /// **'Enter overall feedback here...'**
  String get homeworkFeedbackHint;

  /// No description provided for @homeworkSubmitGrade.
  ///
  /// In en, this message translates to:
  /// **'Submit Grade'**
  String get homeworkSubmitGrade;

  /// No description provided for @homeworkPublished.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get homeworkPublished;

  /// No description provided for @homeworkDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get homeworkDraft;

  /// No description provided for @homeworkDueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get homeworkDueDate;

  /// No description provided for @homeworkAllowLate.
  ///
  /// In en, this message translates to:
  /// **'Allow Late Submission'**
  String get homeworkAllowLate;

  /// No description provided for @homeworkDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this homework?'**
  String get homeworkDeleteConfirm;

  /// No description provided for @homeworkQuestionsLocked.
  ///
  /// In en, this message translates to:
  /// **'Questions cannot be modified after submissions are received.'**
  String get homeworkQuestionsLocked;

  /// No description provided for @homeworkNoQuestions.
  ///
  /// In en, this message translates to:
  /// **'No questions added yet.'**
  String get homeworkNoQuestions;

  /// No description provided for @homeworkAddQuestion.
  ///
  /// In en, this message translates to:
  /// **'Add Question'**
  String get homeworkAddQuestion;

  /// No description provided for @homeworkQuestionIdOrTitle.
  ///
  /// In en, this message translates to:
  /// **'Question ID or Title'**
  String get homeworkQuestionIdOrTitle;

  /// No description provided for @homeworkSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get homeworkSubmitted;

  /// No description provided for @homeworkGraded.
  ///
  /// In en, this message translates to:
  /// **'Graded'**
  String get homeworkGraded;

  /// No description provided for @homeworkNeedsGrading.
  ///
  /// In en, this message translates to:
  /// **'Needs Grading'**
  String get homeworkNeedsGrading;

  /// No description provided for @homeworkNoSubmissions.
  ///
  /// In en, this message translates to:
  /// **'No submissions found.'**
  String get homeworkNoSubmissions;

  /// No description provided for @homeworkReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get homeworkReview;

  /// No description provided for @homeworkGrade.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get homeworkGrade;

  /// No description provided for @homeworkSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get homeworkSelectDate;

  /// No description provided for @homeworkInstructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get homeworkInstructions;

  /// No description provided for @homeworkInstructionsHint.
  ///
  /// In en, this message translates to:
  /// **'Enter homework instructions here...'**
  String get homeworkInstructionsHint;

  /// No description provided for @homeGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get homeGreetingMorning;

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get homeGreetingAfternoon;

  /// No description provided for @homeGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get homeGreetingEvening;

  /// No description provided for @homeGreetingTemplate.
  ///
  /// In en, this message translates to:
  /// **'{greeting}, {teacherName}'**
  String homeGreetingTemplate(String greeting, String teacherName);

  /// No description provided for @homeGreetingSecondaryFallback.
  ///
  /// In en, this message translates to:
  /// **'Ready for today\'s lesson?'**
  String get homeGreetingSecondaryFallback;

  /// No description provided for @homeGreetingSecondaryWithActivity.
  ///
  /// In en, this message translates to:
  /// **'Ready for today\'s lesson in {activity}?'**
  String homeGreetingSecondaryWithActivity(String activity);

  /// No description provided for @organizationNoticeCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No new organization notices} =1{1 new organization notice} other{{count} new organization notices}}'**
  String organizationNoticeCount(int count);

  /// No description provided for @homeNoPostsTitle.
  ///
  /// In en, this message translates to:
  /// **'No posts yet'**
  String get homeNoPostsTitle;

  /// No description provided for @homeNoPostsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No posts are available for this class yet.'**
  String get homeNoPostsSubtitle;

  /// No description provided for @homeFeedFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All Classes'**
  String get homeFeedFilterAll;

  /// No description provided for @postTypeBadgePinned.
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get postTypeBadgePinned;

  /// No description provided for @postTypeBadgeAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Announcement'**
  String get postTypeBadgeAnnouncement;

  /// No description provided for @postTypeBadgeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get postTypeBadgeQuestion;

  /// No description provided for @postTypeBadgeDiscussion.
  ///
  /// In en, this message translates to:
  /// **'Discussion'**
  String get postTypeBadgeDiscussion;

  /// No description provided for @postTypeBadgeResource.
  ///
  /// In en, this message translates to:
  /// **'Resource'**
  String get postTypeBadgeResource;

  /// No description provided for @postTypeBadgeAssignment.
  ///
  /// In en, this message translates to:
  /// **'Assignment'**
  String get postTypeBadgeAssignment;

  /// No description provided for @postTypeBadgeQuiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get postTypeBadgeQuiz;

  /// No description provided for @postTypeBadgeAchievement.
  ///
  /// In en, this message translates to:
  /// **'Achievement'**
  String get postTypeBadgeAchievement;

  /// No description provided for @postTypeBadgePoll.
  ///
  /// In en, this message translates to:
  /// **'Poll'**
  String get postTypeBadgePoll;

  /// No description provided for @postTypeBadgeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get postTypeBadgeSystem;

  /// No description provided for @postYouLabel.
  ///
  /// In en, this message translates to:
  /// **'(You)'**
  String get postYouLabel;

  /// No description provided for @postModerateBadge.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get postModerateBadge;

  /// No description provided for @postReadMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get postReadMore;

  /// No description provided for @postShowLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get postShowLess;

  /// No description provided for @postLike.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get postLike;

  /// No description provided for @postComment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get postComment;

  /// No description provided for @postShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get postShare;

  /// No description provided for @postMenuEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get postMenuEdit;

  /// No description provided for @postMenuDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get postMenuDelete;

  /// No description provided for @postMenuPin.
  ///
  /// In en, this message translates to:
  /// **'Pin'**
  String get postMenuPin;

  /// No description provided for @postMenuUnpin.
  ///
  /// In en, this message translates to:
  /// **'Unpin'**
  String get postMenuUnpin;

  /// No description provided for @postMenuCopyText.
  ///
  /// In en, this message translates to:
  /// **'Copy text'**
  String get postMenuCopyText;

  /// No description provided for @postMenuReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get postMenuReport;

  /// No description provided for @postMenuHide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get postMenuHide;

  /// No description provided for @postMenuModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get postMenuModerate;

  /// No description provided for @postDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete post?'**
  String get postDeleteConfirmTitle;

  /// No description provided for @postDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get postDeleteConfirmBody;

  /// No description provided for @postDeleteConfirmAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get postDeleteConfirmAction;

  /// No description provided for @postImageSemantic.
  ///
  /// In en, this message translates to:
  /// **'Post image'**
  String get postImageSemantic;

  /// No description provided for @postActionComingSoon.
  ///
  /// In en, this message translates to:
  /// **'This feature is coming soon.'**
  String get postActionComingSoon;

  /// No description provided for @homeNoMorePosts.
  ///
  /// In en, this message translates to:
  /// **'You\'ve seen all posts'**
  String get homeNoMorePosts;

  /// No description provided for @notificationsBadgeSemantic.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsBadgeSemantic;

  /// No description provided for @teacherAvatarSemantic.
  ///
  /// In en, this message translates to:
  /// **'Teacher profile'**
  String get teacherAvatarSemantic;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @unsavedChangesDiscard.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. Do you want to discard them?'**
  String get unsavedChangesDiscard;

  /// No description provided for @savingQuiz.
  ///
  /// In en, this message translates to:
  /// **'Saving quiz...'**
  String get savingQuiz;

  /// No description provided for @quizUpdatedWithErrors.
  ///
  /// In en, this message translates to:
  /// **'Quiz updated with some errors. Failed to delete {count} questions.'**
  String quizUpdatedWithErrors(int count);

  /// No description provided for @pleaseCompleteQuestion.
  ///
  /// In en, this message translates to:
  /// **'Please complete question {index}'**
  String pleaseCompleteQuestion(int index);

  /// No description provided for @questionsToDeleteAndAdd.
  ///
  /// In en, this message translates to:
  /// **'You have {deleteCount} questions to delete and {addCount} questions to add/update. Proceed?'**
  String questionsToDeleteAndAdd(int deleteCount, int addCount);

  /// No description provided for @questionMarksMinError.
  ///
  /// In en, this message translates to:
  /// **'Minimum value is 1'**
  String get questionMarksMinError;

  /// No description provided for @fieldInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get fieldInvalidNumber;

  /// No description provided for @questionsChangesConfirm.
  ///
  /// In en, this message translates to:
  /// **'You have {marksCount} marks updated, {addCount} questions added/modified, and {deleteCount} questions deleted. Proceed?'**
  String questionsChangesConfirm(int marksCount, int addCount, int deleteCount);

  /// No description provided for @addToHomework.
  ///
  /// In en, this message translates to:
  /// **'Add to Homework'**
  String get addToHomework;

  /// No description provided for @homeworkManageQuestions.
  ///
  /// In en, this message translates to:
  /// **'Manage Questions'**
  String get homeworkManageQuestions;

  /// No description provided for @homeworkViewSubmissions.
  ///
  /// In en, this message translates to:
  /// **'View Submissions'**
  String get homeworkViewSubmissions;

  /// No description provided for @homeworkQuestionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Questions'**
  String homeworkQuestionsCount(int count);

  /// No description provided for @homeworkSubmissionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Submissions'**
  String homeworkSubmissionsCount(int count);

  /// No description provided for @homeworkAssignMarksTitle.
  ///
  /// In en, this message translates to:
  /// **'Assign Marks'**
  String get homeworkAssignMarksTitle;

  /// No description provided for @homeworkEditMode.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get homeworkEditMode;

  /// No description provided for @homeworkSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get homeworkSaveChanges;

  /// No description provided for @homeworkPublishAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Publish & Continue'**
  String get homeworkPublishAndContinue;

  /// No description provided for @homeworkCancelEdit.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get homeworkCancelEdit;

  /// No description provided for @homeworkSavingQuestions.
  ///
  /// In en, this message translates to:
  /// **'Saving questions...'**
  String get homeworkSavingQuestions;

  /// No description provided for @homeworkQuestionsSliderTitle.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get homeworkQuestionsSliderTitle;

  /// No description provided for @homeworkMarksHint.
  ///
  /// In en, this message translates to:
  /// **'Marks'**
  String get homeworkMarksHint;

  /// No description provided for @homeworkConfirmRemoveQuestion.
  ///
  /// In en, this message translates to:
  /// **'Remove this question from the homework?'**
  String get homeworkConfirmRemoveQuestion;

  /// No description provided for @homeworkQuestionRemovedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Question removed'**
  String get homeworkQuestionRemovedSuccess;

  /// No description provided for @homeworkQuestionsUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Questions saved successfully'**
  String get homeworkQuestionsUpdatedSuccess;

  /// No description provided for @homeworkQuestionsUpdatedWithErrors.
  ///
  /// In en, this message translates to:
  /// **'Saved with {count} errors'**
  String homeworkQuestionsUpdatedWithErrors(int count);

  /// No description provided for @homeworkMaxMarksLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Marks'**
  String get homeworkMaxMarksLabel;

  /// No description provided for @profileSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile & Settings'**
  String get profileSettingsTitle;

  /// No description provided for @profileEditBadge.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get profileEditBadge;

  /// No description provided for @profileSectionAccount.
  ///
  /// In en, this message translates to:
  /// **'Account & Profile'**
  String get profileSectionAccount;

  /// No description provided for @profileSectionPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get profileSectionPreferences;

  /// No description provided for @profileSectionSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security & Tools'**
  String get profileSectionSecurity;

  /// No description provided for @profileSectionSupport.
  ///
  /// In en, this message translates to:
  /// **'Support & About'**
  String get profileSectionSupport;

  /// No description provided for @profileEditProfileItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditProfileItem;

  /// No description provided for @profileAccountInfoItem.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get profileAccountInfoItem;

  /// No description provided for @profileLanguageItem.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguageItem;

  /// No description provided for @profileThemeItem.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get profileThemeItem;

  /// No description provided for @profileNotificationsItem.
  ///
  /// In en, this message translates to:
  /// **'Notification Preferences'**
  String get profileNotificationsItem;

  /// No description provided for @profileSecurityItem.
  ///
  /// In en, this message translates to:
  /// **'Security and Password'**
  String get profileSecurityItem;

  /// No description provided for @profileToolkitItem.
  ///
  /// In en, this message translates to:
  /// **'Toolkit & Whiteboard'**
  String get profileToolkitItem;

  /// No description provided for @profileHelpSupportItem.
  ///
  /// In en, this message translates to:
  /// **'Help and Support'**
  String get profileHelpSupportItem;

  /// No description provided for @profileLogoutButton.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogoutButton;

  /// No description provided for @profileLogoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get profileLogoutConfirmTitle;

  /// No description provided for @profileLogoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out of your account?'**
  String get profileLogoutConfirmMessage;

  /// No description provided for @profileLogoutConfirmYes.
  ///
  /// In en, this message translates to:
  /// **'Yes, Log out'**
  String get profileLogoutConfirmYes;

  /// No description provided for @profileLogoutConfirmNo.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileLogoutConfirmNo;

  /// No description provided for @editProfileScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileScreenTitle;

  /// No description provided for @editProfileFirstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get editProfileFirstName;

  /// No description provided for @editProfileLastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get editProfileLastName;

  /// No description provided for @editProfileHeadline.
  ///
  /// In en, this message translates to:
  /// **'Headline'**
  String get editProfileHeadline;

  /// No description provided for @editProfileBio.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get editProfileBio;

  /// No description provided for @editProfileOpenTo.
  ///
  /// In en, this message translates to:
  /// **'Open To'**
  String get editProfileOpenTo;

  /// No description provided for @editProfileOpenToWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get editProfileOpenToWork;

  /// No description provided for @editProfileOpenToHiring.
  ///
  /// In en, this message translates to:
  /// **'Hiring'**
  String get editProfileOpenToHiring;

  /// No description provided for @editProfileOpenToNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get editProfileOpenToNone;

  /// No description provided for @editProfileImageTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Image file size must be under 5MB'**
  String get editProfileImageTooLarge;

  /// No description provided for @editProfileLinkedin.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get editProfileLinkedin;

  /// No description provided for @editProfileGithub.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get editProfileGithub;

  /// No description provided for @editProfileTwitter.
  ///
  /// In en, this message translates to:
  /// **'Twitter / X'**
  String get editProfileTwitter;

  /// No description provided for @editProfileSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get editProfileSaveButton;

  /// No description provided for @editProfileSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving profile...'**
  String get editProfileSaving;

  /// No description provided for @editProfileSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get editProfileSavedSuccess;

  /// No description provided for @editProfileDirtyWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Unsaved Changes'**
  String get editProfileDirtyWarningTitle;

  /// No description provided for @editProfileDirtyWarningMessage.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. Are you sure you want to discard them?'**
  String get editProfileDirtyWarningMessage;

  /// No description provided for @editProfileDirtyWarningDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get editProfileDirtyWarningDiscard;

  /// No description provided for @editProfileDirtyWarningKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep Editing'**
  String get editProfileDirtyWarningKeep;

  /// No description provided for @accountInfoScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInfoScreenTitle;

  /// No description provided for @accountInfoName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get accountInfoName;

  /// No description provided for @accountInfoEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get accountInfoEmail;

  /// No description provided for @accountInfoUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get accountInfoUsername;

  /// No description provided for @accountInfoRoles.
  ///
  /// In en, this message translates to:
  /// **'Assigned Roles'**
  String get accountInfoRoles;

  /// No description provided for @accountInfoNotice.
  ///
  /// In en, this message translates to:
  /// **'Account information is managed by your institution administrator. To request a change to your primary email address or roles, please contact technical support.'**
  String get accountInfoNotice;

  /// No description provided for @languageScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Language Selection'**
  String get languageScreenTitle;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic (العربية)'**
  String get languageArabic;

  /// No description provided for @languageConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm Selection'**
  String get languageConfirmButton;

  /// No description provided for @languageUpdating.
  ///
  /// In en, this message translates to:
  /// **'Updating language...'**
  String get languageUpdating;

  /// No description provided for @themeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme Selection'**
  String get themeScreenTitle;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get themeSystem;

  /// No description provided for @notificationsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification Preferences'**
  String get notificationsScreenTitle;

  /// No description provided for @notifCourseAnnouncementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Course Announcements'**
  String get notifCourseAnnouncementsTitle;

  /// No description provided for @notifCourseAnnouncementsSub.
  ///
  /// In en, this message translates to:
  /// **'Receive notifications when new announcements are posted in your courses.'**
  String get notifCourseAnnouncementsSub;

  /// No description provided for @notifAssignmentUpdatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Assignment & Homework Updates'**
  String get notifAssignmentUpdatesTitle;

  /// No description provided for @notifAssignmentUpdatesSub.
  ///
  /// In en, this message translates to:
  /// **'Get alerted when students submit homework or when grading is required.'**
  String get notifAssignmentUpdatesSub;

  /// No description provided for @notifMessagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Direct Messages'**
  String get notifMessagesTitle;

  /// No description provided for @notifMessagesSub.
  ///
  /// In en, this message translates to:
  /// **'Notifications for incoming private messages from students or administration.'**
  String get notifMessagesSub;

  /// No description provided for @notifRemindersTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule Reminders'**
  String get notifRemindersTitle;

  /// No description provided for @notifRemindersSub.
  ///
  /// In en, this message translates to:
  /// **'Daily digest and reminders for upcoming classes and meetings.'**
  String get notifRemindersSub;

  /// No description provided for @notifProductUpdatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Product & System Updates'**
  String get notifProductUpdatesTitle;

  /// No description provided for @notifProductUpdatesSub.
  ///
  /// In en, this message translates to:
  /// **'Stay informed about new features, improvements, and scheduled maintenance.'**
  String get notifProductUpdatesSub;

  /// No description provided for @securityScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Security & Password'**
  String get securityScreenTitle;

  /// No description provided for @securityChangePasswordItem.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get securityChangePasswordItem;

  /// No description provided for @securityChangePasswordSub.
  ///
  /// In en, this message translates to:
  /// **'Update your account password regularly to keep your account secure.'**
  String get securityChangePasswordSub;

  /// No description provided for @securityPolicyNotice.
  ///
  /// In en, this message translates to:
  /// **'Security and authentication policies are enforced by your institution administrator. Contact support if you notice suspicious account activity.'**
  String get securityPolicyNotice;

  /// No description provided for @securityLogoutAllSessions.
  ///
  /// In en, this message translates to:
  /// **'Log out all other sessions'**
  String get securityLogoutAllSessions;

  /// No description provided for @securityLogoutAllSessionsSub.
  ///
  /// In en, this message translates to:
  /// **'End your active sessions on other devices and browsers.'**
  String get securityLogoutAllSessionsSub;

  /// No description provided for @helpSupportScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupportScreenTitle;

  /// No description provided for @helpFaqItem.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get helpFaqItem;

  /// No description provided for @helpContactItem.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get helpContactItem;

  /// No description provided for @helpReportItem.
  ///
  /// In en, this message translates to:
  /// **'Report a Problem'**
  String get helpReportItem;

  /// No description provided for @helpPrivacyItem.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get helpPrivacyItem;

  /// No description provided for @helpTermsItem.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get helpTermsItem;

  /// No description provided for @helpUrgentNotice.
  ///
  /// In en, this message translates to:
  /// **'For urgent technical assistance during classroom hours, please contact your institutional IT coordinator directly.'**
  String get helpUrgentNotice;

  /// No description provided for @toolkitScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Toolkit & Whiteboard'**
  String get toolkitScreenTitle;

  /// No description provided for @toolkitUnderDevTitle.
  ///
  /// In en, this message translates to:
  /// **'Under Development'**
  String get toolkitUnderDevTitle;

  /// No description provided for @toolkitUnderDevMessage.
  ///
  /// In en, this message translates to:
  /// **'The interactive whiteboard and teacher toolkit are currently under active development. Stay tuned for updates in upcoming releases.'**
  String get toolkitUnderDevMessage;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationTitle;

  /// No description provided for @notificationFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notificationFilterAll;

  /// No description provided for @notificationFilterUnread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get notificationFilterUnread;

  /// No description provided for @notificationFilterActionRequired.
  ///
  /// In en, this message translates to:
  /// **'Action Required'**
  String get notificationFilterActionRequired;

  /// No description provided for @notificationFilterSubmissions.
  ///
  /// In en, this message translates to:
  /// **'Submissions'**
  String get notificationFilterSubmissions;

  /// No description provided for @notificationGroupPinned.
  ///
  /// In en, this message translates to:
  /// **'PINNED'**
  String get notificationGroupPinned;

  /// No description provided for @notificationGroupToday.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get notificationGroupToday;

  /// No description provided for @notificationGroupYesterday.
  ///
  /// In en, this message translates to:
  /// **'YESTERDAY'**
  String get notificationGroupYesterday;

  /// No description provided for @notificationGroupEarlierThisWeek.
  ///
  /// In en, this message translates to:
  /// **'EARLIER THIS WEEK'**
  String get notificationGroupEarlierThisWeek;

  /// No description provided for @notificationGroupEarlierThisMonth.
  ///
  /// In en, this message translates to:
  /// **'EARLIER THIS MONTH'**
  String get notificationGroupEarlierThisMonth;

  /// No description provided for @notificationGroupOlder.
  ///
  /// In en, this message translates to:
  /// **'OLDER'**
  String get notificationGroupOlder;

  /// No description provided for @notificationMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get notificationMarkAllRead;

  /// No description provided for @notificationViewArchived.
  ///
  /// In en, this message translates to:
  /// **'View archived'**
  String get notificationViewArchived;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification settings'**
  String get notificationSettings;

  /// No description provided for @notificationSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search notifications...'**
  String get notificationSearchHint;

  /// No description provided for @notificationEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up'**
  String get notificationEmptyTitle;

  /// No description provided for @notificationEmptyAction.
  ///
  /// In en, this message translates to:
  /// **'Browse courses'**
  String get notificationEmptyAction;

  /// No description provided for @notificationEmptyFilteredTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here'**
  String get notificationEmptyFilteredTitle;

  /// No description provided for @notificationEmptyFilteredAction.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get notificationEmptyFilteredAction;

  /// No description provided for @notificationEmptySearchTitle.
  ///
  /// In en, this message translates to:
  /// **'No matches for \'{query}\''**
  String notificationEmptySearchTitle(String query);

  /// No description provided for @notificationEmptySearchAction.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get notificationEmptySearchAction;

  /// No description provided for @notificationOfflineBanner.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Showing cached notifications.'**
  String get notificationOfflineBanner;

  /// No description provided for @notificationUnreadCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No unread} =1{1 unread} other{{count} unread}}'**
  String notificationUnreadCount(int count);

  /// No description provided for @notificationNewPill.
  ///
  /// In en, this message translates to:
  /// **'New notifications'**
  String get notificationNewPill;

  /// No description provided for @notificationMarkRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get notificationMarkRead;

  /// No description provided for @notificationMarkUnread.
  ///
  /// In en, this message translates to:
  /// **'Mark as unread'**
  String get notificationMarkUnread;

  /// No description provided for @notificationArchive.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get notificationArchive;

  /// No description provided for @notificationPin.
  ///
  /// In en, this message translates to:
  /// **'Pin'**
  String get notificationPin;

  /// No description provided for @notificationUnpin.
  ///
  /// In en, this message translates to:
  /// **'Unpin'**
  String get notificationUnpin;

  /// No description provided for @notificationMuteCategory.
  ///
  /// In en, this message translates to:
  /// **'Mute this category'**
  String get notificationMuteCategory;

  /// No description provided for @notificationMuteCourse.
  ///
  /// In en, this message translates to:
  /// **'Mute this course'**
  String get notificationMuteCourse;

  /// No description provided for @notificationDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get notificationDelete;

  /// No description provided for @notificationDone.
  ///
  /// In en, this message translates to:
  /// **'Done ✓'**
  String get notificationDone;

  /// No description provided for @notificationCategoryAssignment.
  ///
  /// In en, this message translates to:
  /// **'Assignment Submission'**
  String get notificationCategoryAssignment;

  /// No description provided for @notificationCategoryQuiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz Submission'**
  String get notificationCategoryQuiz;

  /// No description provided for @notificationCategoryGrading.
  ///
  /// In en, this message translates to:
  /// **'Manual Grading Required'**
  String get notificationCategoryGrading;

  /// No description provided for @notificationCategoryGradesPublished.
  ///
  /// In en, this message translates to:
  /// **'Grades Published'**
  String get notificationCategoryGradesPublished;

  /// No description provided for @notificationCategoryPost.
  ///
  /// In en, this message translates to:
  /// **'Collaboration Post'**
  String get notificationCategoryPost;

  /// No description provided for @notificationCategoryComment.
  ///
  /// In en, this message translates to:
  /// **'Collaboration Comment'**
  String get notificationCategoryComment;

  /// No description provided for @notificationCategoryStudyGroup.
  ///
  /// In en, this message translates to:
  /// **'Study Group Activity'**
  String get notificationCategoryStudyGroup;

  /// No description provided for @notificationCategoryModeration.
  ///
  /// In en, this message translates to:
  /// **'Moderation'**
  String get notificationCategoryModeration;

  /// No description provided for @notificationCategorySmartNotes.
  ///
  /// In en, this message translates to:
  /// **'Smart Notes'**
  String get notificationCategorySmartNotes;

  /// No description provided for @notificationCategoryEnrollment.
  ///
  /// In en, this message translates to:
  /// **'Enrollment'**
  String get notificationCategoryEnrollment;

  /// No description provided for @notificationCategoryStudentRisk.
  ///
  /// In en, this message translates to:
  /// **'Student Risk'**
  String get notificationCategoryStudentRisk;

  /// No description provided for @notificationCategoryWorkload.
  ///
  /// In en, this message translates to:
  /// **'Workload / Capacity'**
  String get notificationCategoryWorkload;

  /// No description provided for @notificationCategorySync.
  ///
  /// In en, this message translates to:
  /// **'Integration / Sync'**
  String get notificationCategorySync;

  /// No description provided for @notificationCategorySecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get notificationCategorySecurity;

  /// No description provided for @notificationUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get notificationUrgent;

  /// No description provided for @notificationRequiresAction.
  ///
  /// In en, this message translates to:
  /// **'Requires Action'**
  String get notificationRequiresAction;

  /// No description provided for @notificationLockedPreference.
  ///
  /// In en, this message translates to:
  /// **'Required notifications cannot be disabled.'**
  String get notificationLockedPreference;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @archivedNotifications.
  ///
  /// In en, this message translates to:
  /// **'Archived Notifications'**
  String get archivedNotifications;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// No description provided for @actionRequired.
  ///
  /// In en, this message translates to:
  /// **'Action Required'**
  String get actionRequired;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
