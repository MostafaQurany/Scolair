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
  String get biometricRequestTitle => 'Enable Biometric Login';

  @override
  String get biometricRequestSubtitle =>
      'Speed up your sign-in with fingerprint or face recognition.';

  @override
  String get biometricEnableButton => 'Enable Biometric';

  @override
  String get biometricNotNowButton => 'Not now';

  @override
  String get biometricDontShowAgainLabel => 'Don\'t show this again';

  @override
  String get biometricUnavailable =>
      'Biometric authentication is not available on this device.';

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

  @override
  String get registerTitle => 'Create account';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get agreeTermsLabel => 'I agree to the Terms & Conditions';

  @override
  String get createAccountButton => 'Create account';

  @override
  String get registerSuccess => 'Account created successfully. Please log in.';

  @override
  String get alreadyHaveAccountLink => 'Already have an account? Log in';

  @override
  String get continueWithGoogleButton => 'Continue with Google';

  @override
  String get changePasswordTitle => 'Change password';

  @override
  String get currentPasswordLabel => 'Current password';

  @override
  String get updatePasswordButton => 'Update password';

  @override
  String get updatePasswordSuccess => 'Password updated successfully';

  @override
  String get logoutButton => 'Log out';

  @override
  String get navHome => 'Home';

  @override
  String get navClasses => 'Classes';

  @override
  String get navStudents => 'Students';

  @override
  String get navMessages => 'Messages';

  @override
  String get navSchedule => 'Schedule';

  @override
  String get navClassesPlaceholder => 'Class tools will appear here.';

  @override
  String get navStudentsPlaceholder => 'Student records will appear here.';

  @override
  String get navMessagesPlaceholder => 'Messages will appear here.';

  @override
  String get navSchedulePlaceholder => 'Schedule tools will appear here.';

  @override
  String get coursesMyCoursesTab => 'My Courses';

  @override
  String get coursesBrowseAllTab => 'Browse All';

  @override
  String get coursesSearchHint => 'Search courses';

  @override
  String get coursesFilterAll => 'All';

  @override
  String get coursesFilterPublished => 'Published';

  @override
  String get coursesFilterUnpublished => 'Unpublished';

  @override
  String get coursesNoCoursesTitle => 'No courses found';

  @override
  String get coursesNoMatchesMessage => 'Try a different search or filter.';

  @override
  String get coursesNoMyCoursesMessage =>
      'You are not enrolled in or teaching any courses yet.';

  @override
  String get coursesNoBrowseCoursesMessage =>
      'Check back later for new courses.';

  @override
  String get coursesDefaultStatusActive => 'Active';

  @override
  String coursesLessonsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lessons',
      one: '1 lesson',
      zero: '0 lessons',
    );
    return '$_temp0';
  }

  @override
  String coursesEnrollmentsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count enrolled',
      one: '1 enrolled',
      zero: '0 enrolled',
    );
    return '$_temp0';
  }

  @override
  String get courseDetails => 'Course Details';

  @override
  String get courseOutline => 'Course Outline';

  @override
  String get instructors => 'Instructors';

  @override
  String get createCourse => 'Create Course';

  @override
  String get editCourse => 'Edit Course';

  @override
  String get deleteCourse => 'Delete Course';

  @override
  String get deleteCourseConfirmTitle => 'Delete Course';

  @override
  String get deleteCourseConfirmBody =>
      'Are you sure you want to delete this course?';

  @override
  String get courseCreatedSuccess => 'Course created successfully';

  @override
  String get courseUpdatedSuccess => 'Course updated successfully';

  @override
  String get courseDeletedSuccess => 'Course deleted successfully';

  @override
  String get courseTitleLabel => 'Course Title';

  @override
  String get courseDescriptionLabel => 'Description';

  @override
  String get courseShortIntroLabel => 'Short Introduction';

  @override
  String get courseTagsLabel => 'Tags';

  @override
  String get courseVideoLinkLabel => 'Intro Video Link';

  @override
  String get coursePublishedLabel => 'Published';

  @override
  String get courseEnableCertificationLabel => 'Enable Certification';

  @override
  String get courseTitleRequired => 'Title is required';

  @override
  String get courseShortIntroRequired => 'Short introduction is required';

  @override
  String get courseDescriptionRequired => 'Description is required';

  @override
  String get courseImageLabel => 'Course Image';

  @override
  String get courseImageHint => 'Paste image URL or upload a file';

  @override
  String get selectCourseImage => 'Select Course Image';

  @override
  String get courseBasicInfoSection => 'Basic Info';

  @override
  String get courseMediaSection => 'Media';

  @override
  String get courseTagsSection => 'Tags';

  @override
  String get courseSettingsSection => 'Settings';

  @override
  String get courseTagsHint => 'Comma-separated, e.g. python, beginner';

  @override
  String get noChaptersOrLessons =>
      'No chapters or lessons listed for this course yet.';

  @override
  String get createChapter => 'Create Chapter';

  @override
  String get editChapter => 'Edit Chapter';

  @override
  String get deleteChapter => 'Delete Chapter';

  @override
  String get deleteChapterConfirmTitle => 'Delete Chapter';

  @override
  String get deleteChapterConfirmBody =>
      'Are you sure you want to delete this chapter?';

  @override
  String get chapterCreatedSuccess => 'Chapter created successfully';

  @override
  String get chapterUpdatedSuccess => 'Chapter updated successfully';

  @override
  String get chapterDeletedSuccess => 'Chapter deleted successfully';

  @override
  String get chapterTitleLabel => 'Chapter Title';

  @override
  String get chapterTitleRequired => 'Title is required';

  @override
  String get isScormPackageLabel => 'Is SCORM Package';

  @override
  String get lessonMaterial => 'Lesson Material';

  @override
  String get createLesson => 'Create Lesson';

  @override
  String get editLesson => 'Edit Lesson';

  @override
  String get deleteLesson => 'Delete Lesson';

  @override
  String get deleteLessonConfirmTitle => 'Delete Lesson';

  @override
  String get deleteLessonConfirmBody =>
      'Are you sure you want to delete this lesson?';

  @override
  String get lessonCreatedSuccess => 'Lesson created successfully';

  @override
  String get lessonUpdatedSuccess => 'Lesson updated successfully';

  @override
  String get lessonDeletedSuccess => 'Lesson deleted successfully';

  @override
  String get lessonTitleLabel => 'Lesson Title';

  @override
  String get lessonTitleRequired => 'Title is required';

  @override
  String get includeInPreviewLabel => 'Include in Preview';

  @override
  String get contentTypeLabel => 'Content Type';

  @override
  String get instructorNotes => 'Instructor Notes';

  @override
  String get contentTypeText => 'Text';

  @override
  String get contentTypeYouTube => 'YouTube Video';

  @override
  String get contentTypeVideo => 'Upload Video';

  @override
  String get contentTypePdf => 'Upload PDF';

  @override
  String get contentTypeQuiz => 'Quiz';

  @override
  String get contentTypeCode => 'Code Box';

  @override
  String get lessonMarkdownLabel => 'Lesson Text';

  @override
  String get lessonMarkdownHint => 'Write lesson text. Markdown is supported.';

  @override
  String get lessonPartContentRequired => 'Every lesson part needs content.';

  @override
  String get youtubeUrlLabel => 'YouTube Video URL';

  @override
  String get youtubeUrlHint => 'Enter YouTube link';

  @override
  String get youtubeUrlInvalid => 'Invalid YouTube URL';

  @override
  String get quizNameLabel => 'Quiz Name';

  @override
  String get codeContentLabel => 'Code Snippet';

  @override
  String get codeLanguageLabel => 'Programming Language';

  @override
  String get selectFile => 'Select File';

  @override
  String get uploadingFile => 'Uploading File...';

  @override
  String get uploadSuccess => 'File uploaded successfully';

  @override
  String get uploadError => 'Failed to upload file';

  @override
  String get youtubeVideoLink => 'YouTube Video Link';

  @override
  String get copyVideoLink => 'Copy Video Link';

  @override
  String get linkCopied => 'Link copied to clipboard';

  @override
  String get codeCopiedToClipboard => 'Code copied to clipboard';

  @override
  String get interactiveAssessment => 'Interactive Assessment';

  @override
  String get startQuizNow => 'Start Quiz Now';

  @override
  String get openVideo => 'Open Video';

  @override
  String get downloadFile => 'Download File';

  @override
  String get unableToStreamPrivateFile =>
      'This is a private school resource. Tap below to download or view it in an external app.';

  @override
  String get viewPdf => 'View PDF';

  @override
  String get openPdf => 'Open PDF';

  @override
  String get unsupportedBlockType => 'Unsupported block type';

  @override
  String get malformedContent => 'Malformed content';

  @override
  String get openLink => 'Open Link';

  @override
  String get quizPlaceholder => 'Quizzes are currently read-only';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';
}
