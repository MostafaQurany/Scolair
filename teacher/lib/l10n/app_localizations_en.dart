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

  @override
  String get edit => 'Edit';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get homeQuizzesAction => 'Quizzes';

  @override
  String get homeHomeworkAction => 'Homework';

  @override
  String get quizzesTitle => 'Assessments';

  @override
  String get quizzesMockClassLabel => 'CLASS MATH-10A';

  @override
  String get quizCreateButton => 'Create Quiz';

  @override
  String get quizFilterAll => 'All Assessments';

  @override
  String get quizTypeQuiz => 'Quiz';

  @override
  String get quizTypeMidterm => 'Midterm';

  @override
  String get quizTypeFinal => 'Final';

  @override
  String get quizTimelineUpcoming => 'Upcoming';

  @override
  String get quizTimelinePast => 'Past';

  @override
  String get quizTimelineStatusLabel => 'Timeline Status';

  @override
  String get quizResultStatusLabel => 'Result Status';

  @override
  String get quizResultPending => 'Pending';

  @override
  String quizResultGraded(int graded, int submitted) {
    return 'Graded $graded/$submitted';
  }

  @override
  String quizResultNeedsGrading(int graded, int submitted) {
    return 'Needs Grading $graded/$submitted';
  }

  @override
  String quizSubmittedProgress(int submitted, int total) {
    return 'Submitted $submitted/$total';
  }

  @override
  String quizGradedProgress(int graded, int submitted) {
    return 'Graded $graded/$submitted';
  }

  @override
  String get quizzesEmptyMessage => 'No assessments found.';

  @override
  String get quizCreateTitle => 'Create Assessment';

  @override
  String get quizSaveDraft => 'SAVE DRAFT';

  @override
  String get quizSavedSuccess => 'Assessment saved successfully';

  @override
  String get quizAssessmentTypeSection => 'Assessment Type';

  @override
  String get quizBasicInfoSection => 'Basic Info';

  @override
  String get quizTitleLabel => 'Title';

  @override
  String get quizTitleHint => 'e.g. Chapter 4 Functions';

  @override
  String get quizTitleRequired => 'Title is required';

  @override
  String get quizDescriptionLabel => 'Description (Optional)';

  @override
  String get quizDescriptionHint => 'Add instructions or context...';

  @override
  String get quizFormatOnline => 'Online';

  @override
  String get quizFormatOffline => 'Offline';

  @override
  String get quizTimingSection => 'Timing';

  @override
  String get quizStartDateTimeLabel => 'Start Date & Time';

  @override
  String get quizStartDateTimeHint => 'mm/dd/yyyy, --:-- --';

  @override
  String get quizDurationLabel => 'Duration (minutes)';

  @override
  String get quizMinutesSuffix => 'mins';

  @override
  String get quizGradingSection => 'Grading';

  @override
  String get quizMaxGradeFieldLabel => 'Max Grade';

  @override
  String get quizMinPassingFieldLabel => 'Min Passing';

  @override
  String get quizSecurityResultsSection => 'Security & Results';

  @override
  String get quizRandomizeQuestions => 'Randomize Questions';

  @override
  String get quizRandomizeAnswers => 'Randomize Answers';

  @override
  String get quizShowResultImmediately => 'Show Result Immediately';

  @override
  String get quizShowCorrectAnswers => 'Show Correct Answers';

  @override
  String get quizAllowRetake => 'Allow Retake';

  @override
  String get quizPreventLateSubmission => 'Prevent Late Submission';

  @override
  String get quizMaxAttemptsLabel => 'Max Attempts';

  @override
  String get quizScheduleButton => 'Schedule';

  @override
  String get quizPublishButton => 'Publish Assessment';

  @override
  String get quizDetailsTitle => 'Quiz Details';

  @override
  String get quizPreviewAction => 'Preview';

  @override
  String get quizTabDetails => 'Details';

  @override
  String get quizTabQuestions => 'Questions';

  @override
  String get quizTabSettings => 'Settings';

  @override
  String get quizTabResults => 'Results';

  @override
  String quizDurationMinutes(int minutes) {
    return '$minutes mins';
  }

  @override
  String quizMaxGradeLabel(int grade) {
    return 'Max Grade: $grade';
  }

  @override
  String quizPassingGradeLabel(int grade) {
    return 'Passing: $grade';
  }

  @override
  String quizQuestionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count questions',
      one: '1 question',
      zero: '0 questions',
    );
    return '$_temp0';
  }

  @override
  String quizTotalPoints(int points) {
    return 'Total Points: $points';
  }

  @override
  String get quizPointsSuffix => 'pts total';

  @override
  String get quizImportFromBank => 'Import from Bank';

  @override
  String get quizAddQuestion => 'Add Question';

  @override
  String get quizNoQuestionsTitle => 'No questions yet';

  @override
  String get quizNoQuestionsMessage =>
      'Add questions to make this quiz ready for students.';

  @override
  String questionNumberLabel(int number) {
    return 'Q$number';
  }

  @override
  String questionPointsLabel(int points) {
    return '$points pts';
  }

  @override
  String get questionRequiredLabel => 'Required';

  @override
  String get questionDifficultyEasy => 'Easy';

  @override
  String get questionDifficultyMedium => 'Medium';

  @override
  String get questionDifficultyHard => 'Hard';

  @override
  String get questionTypeMultipleChoice => 'Multiple Choice';

  @override
  String get questionTypeTrueFalse => 'True / False';

  @override
  String get questionTypeShortAnswer => 'Short Answer';

  @override
  String get questionTypeEssay => 'Essay';

  @override
  String get questionTypeFillBlank => 'Fill Blank';

  @override
  String get questionTypeMatching => 'Matching';

  @override
  String get questionTrue => 'True';

  @override
  String get questionFalse => 'False';

  @override
  String get questionAcceptedAnswerLabel => 'Accepted answer';

  @override
  String get questionAddTitle => 'Add Question';

  @override
  String get questionEditTitle => 'Edit Question';

  @override
  String get questionSavedSuccess => 'Question saved successfully';

  @override
  String get questionTypeLabel => 'Question Type';

  @override
  String get questionTextLabel => 'Question Text';

  @override
  String get questionTextHint => 'Write your question here...';

  @override
  String get questionTextRequired => 'Question text is required';

  @override
  String get questionPointsFieldLabel => 'Points';

  @override
  String get questionDifficultyFieldLabel => 'Difficulty';

  @override
  String questionOptionLabel(String letter) {
    return 'Option $letter';
  }

  @override
  String get questionAddOption => 'Add Option';

  @override
  String get questionCorrectAnswerLabel => 'Correct Answer';

  @override
  String get questionAcceptedAnswerHint => 'e.g. 6x + 2';

  @override
  String get questionEssayInfo => 'Essay questions require manual grading.';

  @override
  String get questionExplanationLabel => 'Explanation (Optional)';

  @override
  String get questionExplanationHint => 'Explain the correct answer...';

  @override
  String get questionSaveButton => 'Save Question';

  @override
  String get homeworkManagementTitle => 'Homework Management';

  @override
  String get homeworkMockBreadcrumb => 'MATH-10A > Homework';

  @override
  String get homeworkCreateButton => 'Create Homework';

  @override
  String homeworkTabPublished(int count) {
    return 'Published ($count)';
  }

  @override
  String homeworkTabDrafts(int count) {
    return 'Drafts ($count)';
  }

  @override
  String homeworkTabScheduled(int count) {
    return 'Scheduled ($count)';
  }

  @override
  String get homeworkEmptyMessage => 'No homework found.';

  @override
  String homeworkDueToday(String time) {
    return 'Due Today, $time';
  }

  @override
  String homeworkDueOn(String dateTime) {
    return 'Due $dateTime';
  }

  @override
  String homeworkSubmissionProgress(int submitted, int total) {
    return 'Submission Progress: $submitted/$total';
  }

  @override
  String get homeworkDuplicatedSuccess => 'Homework duplicated successfully';

  @override
  String get homeworkDeleteConfirmTitle => 'Delete homework?';

  @override
  String homeworkDeleteConfirmMessage(String title) {
    return 'This will permanently delete $title.';
  }

  @override
  String get homeworkDeletedSuccess => 'Homework deleted successfully';

  @override
  String get homeworkAddFileTitle => 'Add Assessment File';

  @override
  String get homeworkEditFileTitle => 'Edit Assessment File';

  @override
  String get homeworkSavedSuccess => 'Homework saved successfully';

  @override
  String get homeworkFileDetailsSection => 'File Details';

  @override
  String get homeworkTitleLabel => 'Title';

  @override
  String get homeworkTitleHint => 'e.g. Midterm Review Worksheet';

  @override
  String get homeworkTitleRequired => 'Title is required';

  @override
  String get homeworkCategoryLabel => 'Category';

  @override
  String get homeworkUploadSection => 'Upload';

  @override
  String get homeworkUploadHint => 'Click to Upload or Drag & Drop';

  @override
  String get homeworkUploadSupportedTypes => 'Supports PDF, DOCX, XLSX';

  @override
  String get homeworkTargetSection => 'Target';

  @override
  String get homeworkTargetExamQuiz => 'Attach to Exam/Quiz';

  @override
  String get homeworkTargetLesson => 'Attach to Lesson';

  @override
  String get homeworkSearchExamLabel => 'Search or Select Exam';

  @override
  String get homeworkSearchLessonLabel => 'Search or Select Lesson';

  @override
  String get homeworkSearchTargetHint => 'e.g. Midterm Math 101';

  @override
  String get homeworkTargetRequired => 'Please select a target';

  @override
  String get homeworkUploadAndAttach => 'Upload and Attach';

  @override
  String get classesTitle => 'My Classes';

  @override
  String get classesSubtitle => 'Manage your active courses and assignments.';

  @override
  String get classesSearchHint => 'Search classes...';

  @override
  String get classFilterAll => 'All Classes';

  @override
  String get classFilterMathematics => 'Mathematics';

  @override
  String get classFilterScience => 'Science';

  @override
  String get classFilterNetworking => 'Networking';

  @override
  String get classFilterLiterature => 'Literature';

  @override
  String classStudentsCount(int count) {
    return '$count Students';
  }

  @override
  String get classNextLesson => 'NEXT LESSON';

  @override
  String get classSubmissions => 'SUBMISSIONS';

  @override
  String classPendingReview(int count) {
    return '$count Pending Review';
  }

  @override
  String get classAllCaughtUp => 'All Caught Up';

  @override
  String get classUrgentAlert => 'URGENT ALERT';

  @override
  String get classDetailViewStudents => 'View Students';

  @override
  String get classDetailExamsQuizzes => 'Exams & Quizzes';

  @override
  String get classCurriculum => 'Curriculum';

  @override
  String classCurriculumWeek(int current, int total) {
    return 'Week $current of $total';
  }

  @override
  String get classActivity => 'Class Activity';

  @override
  String get classAttendance => 'Attendance';

  @override
  String get classPresentToday => 'PRESENT TODAY';

  @override
  String get classAbsentToday => 'ABSENT TODAY';

  @override
  String get classTakeAttendance => 'Take Attendance';

  @override
  String get classPerformance => 'Class Performance';

  @override
  String get classAverage => 'Class Average';

  @override
  String get classAssignmentCompletion => 'Assignment Completion';

  @override
  String get classGradeNow => 'Grade Now';

  @override
  String get classSubmitted => 'SUBMITTED';

  @override
  String get myCoursesTitle => 'My Courses';

  @override
  String get myCoursesEmpty => 'You have no courses yet.';

  @override
  String get myCoursesButton => 'My Courses';

  @override
  String get classStudents => 'students';

  @override
  String get coursesLessonsLabel => 'Lessons';

  @override
  String get coursesStudentsLabel => 'Students';

  @override
  String get coursesRatingLabel => 'Rating';

  @override
  String myCoursesCoTaughtBy(String names) {
    return 'Co-taught w/ $names';
  }

  @override
  String get questionTypeChoices => 'Choices';

  @override
  String get questionTypeUserInput => 'User Input';

  @override
  String get questionTypeOpenEnded => 'Open Ended';

  @override
  String get questionTypeFileUpload => 'File Upload';

  @override
  String get quizPassingPercentage => 'Passing Percentage';

  @override
  String get quizMaxAttempts => 'Max Attempts';

  @override
  String get quizMaxAttemptsUnlimited => 'Unlimited';

  @override
  String get quizShuffleQuestions => 'Shuffle Questions';

  @override
  String get quizShowAnswers => 'Show Answers';

  @override
  String get quizEnableNegativeMarking => 'Enable Negative Marking';

  @override
  String get quizMarksToCut => 'Marks To Cut';

  @override
  String get quizLimitQuestions => 'Limit Questions To';

  @override
  String get questionMultipleCorrect => 'Multiple Correct Answers';

  @override
  String get questionPossibilitiesLabel => 'Accepted Possibilities';

  @override
  String get questionPossibility => 'Possibility';

  @override
  String get questionOpenEndedHint =>
      'Open-ended questions require manual grading by the teacher.';

  @override
  String get questionFileUploadHint =>
      'Students answer this question by uploading a file. It requires manual grading.';

  @override
  String get quizMaxAttemptsHelper => 'Enter 0 for unlimited attempts';

  @override
  String get quizDurationHint => 'Leave empty for unlimited duration';

  @override
  String get quizLimitQuestionsHelper =>
      'Randomly pick N questions (0 for all)';

  @override
  String get questionBankTitle => 'Question Bank';

  @override
  String get questionCenterTitle => 'Question Center';

  @override
  String get search => 'Search...';

  @override
  String get addToQuiz => 'Add to Quiz';

  @override
  String get quizTabOverview => 'Overview';

  @override
  String get quizTabReview => 'Review';

  @override
  String get quizTimeLimitLabel => 'Time Limit';

  @override
  String get quizPassingScoreLabel => 'Passing Score';

  @override
  String get quizNoQuestionsSubtitle =>
      'Start building your assessment by adding questions manually or importing from the question bank.';

  @override
  String get quizErrorTitle => 'Something went wrong';

  @override
  String get quizRetryButton => 'Retry';

  @override
  String get questionBankFilterType => 'Type';

  @override
  String get questionBankFilterAll => 'All';

  @override
  String get questionBankFilterDifficulty => 'Difficulty';

  @override
  String get questionBankFilterPoints => 'Points';

  @override
  String get questionBankFilterTopic => 'Topic';

  @override
  String get questionBankClearFilters => 'Clear filters';

  @override
  String get questionBankEmptyTitle => 'No questions found';

  @override
  String get questionBankEmptyMessage =>
      'Create questions or check back later.';

  @override
  String get questionBankNoMatches => 'Try a different search or filter.';

  @override
  String get questionBankManualTypeBlocked =>
      'This quiz already has auto-graded questions, so manual question types cannot be mixed in.';

  @override
  String get questionBankAutoTypeBlocked =>
      'This quiz already has manual question types, so auto-graded questions cannot be mixed in.';

  @override
  String get questionDeletedSuccess => 'Question deleted successfully';

  @override
  String questionBankSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count questions selected',
      one: '1 question selected',
    );
    return '$_temp0';
  }

  @override
  String get questionBankClear => 'Clear';

  @override
  String get quizSetupTitle => 'Quiz Setup';

  @override
  String get quizGeneralDetails => 'General Details';

  @override
  String get quizGradingLimits => 'Grading & Limits';

  @override
  String get quizBehavior => 'Quiz Behavior';

  @override
  String get questionSavedDraft => 'Saved Draft';

  @override
  String get questionAttachMedia => 'Attach Media';

  @override
  String get quizReorderButton => 'Reorder';

  @override
  String questionOfTotal(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String quizChoicesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count choices',
      one: '1 choice',
    );
    return '$_temp0';
  }

  @override
  String get quizSaveSettings => 'Save Settings';

  @override
  String get quizReviewPlaceholderTitle => 'Results not available';

  @override
  String get quizReviewPlaceholderMessage =>
      'Result tracking is not fully integrated yet.';

  @override
  String get quizCourseLabel => 'Course';

  @override
  String get quizLessonLabel => 'Lesson';

  @override
  String get quizTimeLimitToggle => 'Time Limit';

  @override
  String get quizMinutesLabel => 'Minutes';

  @override
  String get quizShowCorrectAnswersToggle => 'Show Correct Answers';

  @override
  String get quizNegativeMarkingToggle => 'Negative Marking';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get done => 'Done';

  @override
  String get saveLocally => 'Save Locally';

  @override
  String get addNew => 'Add New';

  @override
  String get questionRemoved => 'Question removed';

  @override
  String questionsAddedFromBank(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count questions added from bank',
      one: '1 question added from bank',
    );
    return '$_temp0';
  }

  @override
  String get homeworkFilterLabel => 'Status';

  @override
  String get homeworkFilterAll => 'All';

  @override
  String get homeworkFilterPublished => 'Published';

  @override
  String get homeworkFilterDrafts => 'Drafts';

  @override
  String get homeworkViewDetails => 'View Details';

  @override
  String get homeworkNoCourse => 'No course';

  @override
  String get homeworkNoDueDate => 'No due date';

  @override
  String get homeworkUntitled => 'Untitled homework';

  @override
  String get homeworkLateAllowed => 'Late submissions allowed';

  @override
  String get homeworkAttachmentAvailable => 'Attachment available';

  @override
  String get homeworkEndOfResults => 'You have reached the end.';

  @override
  String get homeworkLoadMoreFailed => 'Could not load more homework.';

  @override
  String get homeworkInstructionsUnavailable => 'No instructions provided.';

  @override
  String get homeGreetingMorning => 'Good Morning';

  @override
  String get homeGreetingAfternoon => 'Good Afternoon';

  @override
  String get homeGreetingEvening => 'Good Evening';

  @override
  String homeGreetingTemplate(String greeting, String teacherName) {
    return '$greeting, $teacherName';
  }

  @override
  String get homeGreetingSecondaryFallback => 'Ready for today\'s lesson?';

  @override
  String homeGreetingSecondaryWithActivity(String activity) {
    return 'Ready for today\'s lesson in $activity?';
  }

  @override
  String organizationNoticeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count new organization notices',
      one: '1 new organization notice',
      zero: 'No new organization notices',
    );
    return '$_temp0';
  }

  @override
  String get homeNoPostsTitle => 'No posts yet';

  @override
  String get homeNoPostsSubtitle =>
      'No posts are available for this class yet.';

  @override
  String get homeFeedFilterAll => 'All Classes';

  @override
  String get postTypeBadgePinned => 'Pinned';

  @override
  String get postTypeBadgeAnnouncement => 'Announcement';

  @override
  String get postTypeBadgeQuestion => 'Question';

  @override
  String get postTypeBadgeDiscussion => 'Discussion';

  @override
  String get postTypeBadgeResource => 'Resource';

  @override
  String get postTypeBadgeAssignment => 'Assignment';

  @override
  String get postTypeBadgeQuiz => 'Quiz';

  @override
  String get postTypeBadgeAchievement => 'Achievement';

  @override
  String get postTypeBadgePoll => 'Poll';

  @override
  String get postTypeBadgeSystem => 'System';

  @override
  String get postYouLabel => '(You)';

  @override
  String get postModerateBadge => 'Moderate';

  @override
  String get postReadMore => 'Read more';

  @override
  String get postShowLess => 'Show less';

  @override
  String get postLike => 'Like';

  @override
  String get postComment => 'Comment';

  @override
  String get postShare => 'Share';

  @override
  String get postMenuEdit => 'Edit';

  @override
  String get postMenuDelete => 'Delete';

  @override
  String get postMenuPin => 'Pin';

  @override
  String get postMenuUnpin => 'Unpin';

  @override
  String get postMenuCopyText => 'Copy text';

  @override
  String get postMenuReport => 'Report';

  @override
  String get postMenuHide => 'Hide';

  @override
  String get postMenuModerate => 'Moderate';

  @override
  String get postDeleteConfirmTitle => 'Delete post?';

  @override
  String get postDeleteConfirmBody => 'This action cannot be undone.';

  @override
  String get postDeleteConfirmAction => 'Delete';

  @override
  String get postImageSemantic => 'Post image';

  @override
  String get postActionComingSoon => 'This feature is coming soon.';

  @override
  String get homeNoMorePosts => 'You\'ve seen all posts';

  @override
  String get notificationsBadgeSemantic => 'Notifications';

  @override
  String get teacherAvatarSemantic => 'Teacher profile';
}
