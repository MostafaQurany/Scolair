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
