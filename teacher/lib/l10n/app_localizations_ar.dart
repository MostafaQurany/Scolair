// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'سكولير';

  @override
  String get homeTitle => 'الرئيسية';

  @override
  String get homeSubtitle => 'مساحة المدرسة جاهزة.';

  @override
  String get homeSummaryTitle => 'نظرة على اليوم';

  @override
  String classCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حصص',
      one: 'حصة واحدة',
      zero: 'لا توجد حصص',
    );
    return '$_temp0';
  }

  @override
  String assignmentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count واجبات',
      one: 'واجب واحد',
      zero: 'لا توجد واجبات',
    );
    return '$_temp0';
  }

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get loading => 'جار التحميل';

  @override
  String get loginTitle => 'تسجيل دخول المعلم';

  @override
  String get loginSubtitle => 'سجّل دخولك ببريد مؤسستك للمتابعة.';

  @override
  String get phoneNumberLabel => 'رقم الهاتف';

  @override
  String get phoneNumberHint => 'أدخل رقم هاتفك';

  @override
  String get sendOtpButton => 'إرسال الرمز';

  @override
  String get orgLoginLink => 'تسجيل الدخول بالهاتف بدلاً من ذلك';

  @override
  String get forgotPasswordLink => 'نسيت كلمة المرور؟';

  @override
  String get phoneLoginSecurityNote =>
      'حسابك كمعلم مرتبط ببيانات اعتماد مدرستك.';

  @override
  String get orgLoginTitle => 'تسجيل الدخول بالهاتف';

  @override
  String get orgLoginSubtitle => 'أدخل رقم هاتفك لاستلام رمز التحقق.';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailHint => 'your@school.edu';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get orgLoginButton => 'تسجيل الدخول';

  @override
  String get otpTitle => 'التحقق من هويتك';

  @override
  String otpSubtitle(String identifier) {
    return 'أدخل الرمز المكون من 6 أرقام المُرسَل إلى $identifier';
  }

  @override
  String get otpResend => 'إعادة إرسال الرمز';

  @override
  String get otpVerifyButton => 'تحقق';

  @override
  String get authErrorOtpInvalid =>
      'الرمز غير صحيح أو منتهي الصلاحية. حاول مجدداً.';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordSubtitle => 'سنرسل لك رمز إعادة تعيين.';

  @override
  String get sendResetLinkButton => 'إرسال رمز الاسترداد';

  @override
  String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get newPasswordLabel => 'كلمة المرور الجديدة';

  @override
  String get newPasswordHint => 'أدخل كلمة المرور الجديدة';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get confirmPasswordHint => 'أعد إدخال كلمة المرور الجديدة';

  @override
  String get resetPasswordButton => 'إعادة تعيين';

  @override
  String get passwordMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get biometricTitle => 'فتح ببصمة الإصبع';

  @override
  String get biometricSubtitle =>
      'استخدم البيانات البيومترية للوصول إلى حسابك.';

  @override
  String get biometricPrompt => 'المصادقة';

  @override
  String get usePasswordFallback => 'استخدام كلمة المرور بدلاً من ذلك';

  @override
  String get biometricRequestTitle => 'تفعيل تسجيل الدخول ببصمة الإصبع';

  @override
  String get biometricRequestSubtitle =>
      'تسجيل الدخول بشكل أسرع عبر بصمة الإصبع أو التعرف على الوجه.';

  @override
  String get biometricEnableButton => 'تفعيل البصمة';

  @override
  String get biometricNotNowButton => 'ليس الآن';

  @override
  String get biometricDontShowAgainLabel => 'لا تُظهر هذا مجددًا';

  @override
  String get biometricUnavailable =>
      'المصادقة البيومترية غير متاحة على هذا الجهاز.';

  @override
  String get authErrorGeneric => 'حدث خطأ ما. حاول مجدداً.';

  @override
  String get onboardingPage1Title => 'قُد فصولك';

  @override
  String get onboardingPage1Body =>
      'شارك المنشورات وأدِر تحديثات الفصل وتحكّم في التعليقات وابقِ الطلاب على تواصل.';

  @override
  String get onboardingPage2Title => 'أنشئ وأدِر';

  @override
  String get onboardingPage2Body =>
      'ابنِ الدروس والواجبات والامتحانات والجلسات المباشرة والملفات والحضور والأنشطة الصفية.';

  @override
  String get onboardingPage3Title => 'ادعم كل طالب';

  @override
  String get onboardingPage3Body =>
      'راجع التسليمات وسجّل الحضور وتابع التقدم وصحّح الأعمال وتواصل مع أولياء الأمور عند الحاجة.';

  @override
  String get onboardingNextButton => 'التالي';

  @override
  String get onboardingDoneButton => 'ابدأ الآن';

  @override
  String get onboardingSkipButton => 'تخطَّ';

  @override
  String get registerTitle => 'إنشاء حساب';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get fullNameHint => 'أدخل اسمك الكامل';

  @override
  String get agreeTermsLabel => 'أوافق على الشروط والأحكام';

  @override
  String get createAccountButton => 'إنشاء حساب';

  @override
  String get registerSuccess => 'تم إنشاء الحساب بنجاح. يرجى تسجيل الدخول.';

  @override
  String get alreadyHaveAccountLink => 'لديك حساب بالفعل؟ تسجيل الدخول';

  @override
  String get continueWithGoogleButton => 'المتابعة مع Google';

  @override
  String get changePasswordTitle => 'تغيير كلمة المرور';

  @override
  String get currentPasswordLabel => 'كلمة المرور الحالية';

  @override
  String get updatePasswordButton => 'تحديث كلمة المرور';

  @override
  String get updatePasswordSuccess => 'تم تحديث كلمة المرور بنجاح';

  @override
  String get logoutButton => 'تسجيل الخروج';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navClasses => 'الفصول';

  @override
  String get navStudents => 'الطلاب';

  @override
  String get navMessages => 'الرسائل';

  @override
  String get navSchedule => 'الجدول';

  @override
  String get navClassesPlaceholder => 'ستظهر أدوات الفصول هنا.';

  @override
  String get navStudentsPlaceholder => 'ستظهر سجلات الطلاب هنا.';

  @override
  String get navMessagesPlaceholder => 'ستظهر الرسائل هنا.';

  @override
  String get navSchedulePlaceholder => 'ستظهر أدوات الجدول هنا.';

  @override
  String get coursesMyCoursesTab => 'دوراتي';

  @override
  String get coursesBrowseAllTab => 'تصفح الكل';

  @override
  String get coursesSearchHint => 'ابحث عن الدورات';

  @override
  String get coursesFilterAll => 'الكل';

  @override
  String get coursesFilterPublished => 'منشورة';

  @override
  String get coursesFilterUnpublished => 'غير منشورة';

  @override
  String get coursesNoCoursesTitle => 'لا توجد دورات';

  @override
  String get coursesNoMatchesMessage => 'جرب بحثا أو فلترا مختلفا.';

  @override
  String get coursesNoMyCoursesMessage =>
      'لست مسجلا أو معلما في أي دورات حاليا.';

  @override
  String get coursesNoBrowseCoursesMessage => 'تحقق لاحقا للدورات الجديدة.';

  @override
  String get coursesDefaultStatusActive => 'نشطة';

  @override
  String coursesLessonsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دروس',
      one: 'درس واحد',
      zero: '0 دروس',
    );
    return '$_temp0';
  }

  @override
  String coursesEnrollmentsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مسجلين',
      one: 'مسجل واحد',
      zero: '0 مسجلين',
    );
    return '$_temp0';
  }

  @override
  String get courseDetails => 'تفاصيل الدورة';

  @override
  String get courseOutline => 'مخطط الدورة';

  @override
  String get instructors => 'المعلمون';

  @override
  String get createCourse => 'إنشاء دورة';

  @override
  String get editCourse => 'تعديل الدورة';

  @override
  String get deleteCourse => 'حذف الدورة';

  @override
  String get deleteCourseConfirmTitle => 'حذف الدورة';

  @override
  String get deleteCourseConfirmBody =>
      'هل أنت متأكد من رغبتك في حذف هذه الدورة؟';

  @override
  String get courseCreatedSuccess => 'تم إنشاء الدورة بنجاح';

  @override
  String get courseUpdatedSuccess => 'تم تحديث الدورة بنجاح';

  @override
  String get courseDeletedSuccess => 'تم حذف الدورة بنجاح';

  @override
  String get courseTitleLabel => 'عنوان الدورة';

  @override
  String get courseDescriptionLabel => 'الوصف';

  @override
  String get courseShortIntroLabel => 'مقدمة قصيرة';

  @override
  String get courseTagsLabel => 'الوسوم';

  @override
  String get courseVideoLinkLabel => 'رابط الفيديو التعريفي';

  @override
  String get coursePublishedLabel => 'منشورة';

  @override
  String get courseEnableCertificationLabel => 'تفعيل الشهادات';

  @override
  String get courseTitleRequired => 'العنوان مطلوب';

  @override
  String get courseShortIntroRequired => 'المقدمة القصيرة مطلوبة';

  @override
  String get courseDescriptionRequired => 'الوصف مطلوب';

  @override
  String get courseImageLabel => 'صورة الدورة';

  @override
  String get courseImageHint => 'ألصق رابط صورة أو ارفع ملفا';

  @override
  String get selectCourseImage => 'اختر صورة الدورة';

  @override
  String get courseBasicInfoSection => 'المعلومات الأساسية';

  @override
  String get courseMediaSection => 'الوسائط';

  @override
  String get courseTagsSection => 'الوسوم';

  @override
  String get courseSettingsSection => 'الإعدادات';

  @override
  String get courseTagsHint => 'مفصولة بفواصل، مثل: python، مبتدئ';

  @override
  String get noChaptersOrLessons =>
      'لا توجد فصول أو دروس مدرجة في هذه الدورة بعد.';

  @override
  String get createChapter => 'إنشاء فصل';

  @override
  String get editChapter => 'تعديل الفصل';

  @override
  String get deleteChapter => 'حذف الفصل';

  @override
  String get deleteChapterConfirmTitle => 'حذف الفصل';

  @override
  String get deleteChapterConfirmBody =>
      'هل أنت متأكد من رغبتك في حذف هذا الفصل؟';

  @override
  String get chapterCreatedSuccess => 'تم إنشاء الفصل بنجاح';

  @override
  String get chapterUpdatedSuccess => 'تم تحديث الفصل بنجاح';

  @override
  String get chapterDeletedSuccess => 'تم حذف الفصل بنجاح';

  @override
  String get chapterTitleLabel => 'عنوان الفصل';

  @override
  String get chapterTitleRequired => 'العنوان مطلوب';

  @override
  String get isScormPackageLabel => 'ملف SCORM تفاعلي';

  @override
  String get lessonMaterial => 'محتوى الدرس';

  @override
  String get createLesson => 'إنشاء درس';

  @override
  String get editLesson => 'تعديل الدرس';

  @override
  String get deleteLesson => 'حذف الدرس';

  @override
  String get deleteLessonConfirmTitle => 'حذف الدرس';

  @override
  String get deleteLessonConfirmBody =>
      'هل أنت متأكد من رغبتك في حذف هذا الدرس؟';

  @override
  String get lessonCreatedSuccess => 'تم إنشاء الدرس بنجاح';

  @override
  String get lessonUpdatedSuccess => 'تم تحديث الدرس بنجاح';

  @override
  String get lessonDeletedSuccess => 'تم حذف الدرس بنجاح';

  @override
  String get lessonTitleLabel => 'عنوان الدرس';

  @override
  String get lessonTitleRequired => 'العنوان مطلوب';

  @override
  String get includeInPreviewLabel => 'تضمين في المعاينة';

  @override
  String get contentTypeLabel => 'نوع المحتوى';

  @override
  String get instructorNotes => 'ملاحظات المعلم';

  @override
  String get contentTypeText => 'نص';

  @override
  String get contentTypeYouTube => 'فيديو يوتيوب';

  @override
  String get contentTypeVideo => 'تحميل فيديو';

  @override
  String get contentTypePdf => 'تحميل PDF';

  @override
  String get contentTypeQuiz => 'اختبار قصير';

  @override
  String get contentTypeCode => 'صندوق الكود';

  @override
  String get lessonMarkdownLabel => 'نص الدرس';

  @override
  String get lessonMarkdownHint => 'اكتب نص الدرس. يتم دعم Markdown.';

  @override
  String get lessonPartContentRequired => 'كل جزء من الدرس يحتاج إلى محتوى.';

  @override
  String get youtubeUrlLabel => 'رابط فيديو يوتيوب';

  @override
  String get youtubeUrlHint => 'أدخل رابط يوتيوب';

  @override
  String get youtubeUrlInvalid => 'رابط يوتيوب غير صالح';

  @override
  String get quizNameLabel => 'اسم الاختبار';

  @override
  String get codeContentLabel => 'قصاصة الكود';

  @override
  String get codeLanguageLabel => 'لغة البرمجة';

  @override
  String get selectFile => 'اختر ملفاً';

  @override
  String get uploadingFile => 'جاري رفع الملف...';

  @override
  String get uploadSuccess => 'تم رفع الملف بنجاح';

  @override
  String get uploadError => 'فشل رفع الملف';

  @override
  String get youtubeVideoLink => 'رابط فيديو يوتيوب';

  @override
  String get copyVideoLink => 'نسخ رابط الفيديو';

  @override
  String get linkCopied => 'تم نسخ الرابط إلى الحافظة';

  @override
  String get codeCopiedToClipboard => 'تم نسخ الكود إلى الحافظة';

  @override
  String get interactiveAssessment => 'تقييم تفاعلي';

  @override
  String get startQuizNow => 'ابدأ الاختبار الآن';

  @override
  String get openVideo => 'فتح الفيديو';

  @override
  String get downloadFile => 'تحميل الملف';

  @override
  String get unableToStreamPrivateFile =>
      'هذا ملف مدرسي خاص. اضغط أدناه لتحميله أو عرضه في تطبيق خارجي.';

  @override
  String get viewPdf => 'عرض PDF';

  @override
  String get openPdf => 'فتح PDF';

  @override
  String get unsupportedBlockType => 'نوع كتلة غير مدعوم';

  @override
  String get malformedContent => 'محتوى تالف';

  @override
  String get openLink => 'فتح الرابط';

  @override
  String get quizPlaceholder => 'الاختبارات للقراءة فقط حالياً';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get duplicate => 'نسخ';

  @override
  String get homeQuizzesAction => 'الاختبارات';

  @override
  String get homeHomeworkAction => 'الواجبات';

  @override
  String get quizzesTitle => 'الاختبارات';

  @override
  String get quizzesMockClassLabel => 'الفصل رياضيات-10أ';

  @override
  String get quizCreateButton => 'إنشاء اختبار قصير';

  @override
  String get quizFilterAll => 'كل التقييمات';

  @override
  String get quizTypeQuiz => 'اختبار قصير';

  @override
  String get quizTypeMidterm => 'اختبار منتصف الفصل';

  @override
  String get quizTypeFinal => 'اختبار نهائي';

  @override
  String get quizTimelineUpcoming => 'قادم';

  @override
  String get quizTimelinePast => 'سابق';

  @override
  String get quizTimelineStatusLabel => 'حالة الجدول الزمني';

  @override
  String get quizResultStatusLabel => 'حالة النتيجة';

  @override
  String get quizResultPending => 'قيد الانتظار';

  @override
  String quizResultGraded(int graded, int submitted) {
    return 'تم تصحيح $graded/$submitted';
  }

  @override
  String quizResultNeedsGrading(int graded, int submitted) {
    return 'بحاجة إلى تصحيح $graded/$submitted';
  }

  @override
  String quizSubmittedProgress(int submitted, int total) {
    return 'تم التسليم $submitted/$total';
  }

  @override
  String quizGradedProgress(int graded, int submitted) {
    return 'تم تصحيح $graded/$submitted';
  }

  @override
  String get quizzesEmptyMessage => 'لا توجد تقييمات.';

  @override
  String get quizCreateTitle => 'إنشاء تقييم';

  @override
  String get quizSaveDraft => 'حفظ كمسودة';

  @override
  String get quizSavedSuccess => 'تم حفظ التقييم بنجاح';

  @override
  String get quizAssessmentTypeSection => 'نوع التقييم';

  @override
  String get quizBasicInfoSection => 'معلومات أساسية';

  @override
  String get quizTitleLabel => 'العنوان';

  @override
  String get quizTitleHint => 'مثال: الفصل 4 الدوال';

  @override
  String get quizTitleRequired => 'العنوان مطلوب';

  @override
  String get quizDescriptionLabel => 'الوصف (اختياري)';

  @override
  String get quizDescriptionHint => 'أضف تعليمات أو سياقاً...';

  @override
  String get quizFormatOnline => 'عبر الإنترنت';

  @override
  String get quizFormatOffline => 'دون اتصال';

  @override
  String get quizTimingSection => 'التوقيت';

  @override
  String get quizStartDateTimeLabel => 'تاريخ ووقت البدء';

  @override
  String get quizStartDateTimeHint => 'يوم/شهر/سنة، --:--';

  @override
  String get quizDurationLabel => 'المدة (دقائق)';

  @override
  String get quizMinutesSuffix => 'دقيقة';

  @override
  String get quizGradingSection => 'الدرجات';

  @override
  String get quizMaxGradeFieldLabel => 'الدرجة القصوى';

  @override
  String get quizMinPassingFieldLabel => 'درجة النجاح';

  @override
  String get quizSecurityResultsSection => 'الأمان والنتائج';

  @override
  String get quizRandomizeQuestions => 'ترتيب عشوائي للأسئلة';

  @override
  String get quizRandomizeAnswers => 'ترتيب عشوائي للإجابات';

  @override
  String get quizShowResultImmediately => 'إظهار النتيجة فوراً';

  @override
  String get quizShowCorrectAnswers => 'إظهار الإجابات الصحيحة';

  @override
  String get quizAllowRetake => 'السماح بإعادة المحاولة';

  @override
  String get quizPreventLateSubmission => 'منع التسليم المتأخر';

  @override
  String get quizMaxAttemptsLabel => 'الحد الأقصى للمحاولات';

  @override
  String get quizScheduleButton => 'جدولة';

  @override
  String get quizPublishButton => 'نشر التقييم';

  @override
  String get quizDetailsTitle => 'تفاصيل الاختبار';

  @override
  String get quizPreviewAction => 'معاينة';

  @override
  String get quizTabDetails => 'التفاصيل';

  @override
  String get quizTabQuestions => 'الأسئلة';

  @override
  String get quizTabSettings => 'الإعدادات';

  @override
  String get quizTabResults => 'النتائج';

  @override
  String quizDurationMinutes(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String quizMaxGradeLabel(int grade) {
    return 'الدرجة القصوى: $grade';
  }

  @override
  String quizPassingGradeLabel(int grade) {
    return 'درجة النجاح: $grade';
  }

  @override
  String quizQuestionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سؤال',
      one: 'سؤال واحد',
      zero: '0 سؤال',
    );
    return '$_temp0';
  }

  @override
  String quizTotalPoints(int points) {
    return 'مجموع الدرجات: $points';
  }

  @override
  String get quizPointsSuffix => 'نقطة إجمالية';

  @override
  String get quizImportFromBank => 'استيراد من البنك';

  @override
  String get quizAddQuestion => 'إضافة سؤال';

  @override
  String get quizNoQuestionsTitle => 'لا توجد أسئلة بعد';

  @override
  String get quizNoQuestionsMessage =>
      'أضف أسئلة لجعل هذا الاختبار جاهزاً للطلاب.';

  @override
  String questionNumberLabel(int number) {
    return 'س$number';
  }

  @override
  String questionPointsLabel(int points) {
    return '$points نقاط';
  }

  @override
  String get questionRequiredLabel => 'مطلوب';

  @override
  String get questionDifficultyEasy => 'سهل';

  @override
  String get questionDifficultyMedium => 'متوسط';

  @override
  String get questionDifficultyHard => 'صعب';

  @override
  String get questionTypeMultipleChoice => 'اختيار من متعدد';

  @override
  String get questionTypeTrueFalse => 'صح / خطأ';

  @override
  String get questionTypeShortAnswer => 'إجابة قصيرة';

  @override
  String get questionTypeEssay => 'مقالي';

  @override
  String get questionTypeFillBlank => 'أكمل الفراغ';

  @override
  String get questionTypeMatching => 'مطابقة';

  @override
  String get questionTrue => 'صح';

  @override
  String get questionFalse => 'خطأ';

  @override
  String get questionAcceptedAnswerLabel => 'الإجابة المقبولة';

  @override
  String get questionAddTitle => 'إضافة سؤال';

  @override
  String get questionEditTitle => 'تعديل سؤال';

  @override
  String get questionSavedSuccess => 'تم حفظ السؤال بنجاح';

  @override
  String get questionTypeLabel => 'نوع السؤال';

  @override
  String get questionTextLabel => 'نص السؤال';

  @override
  String get questionTextHint => 'اكتب سؤالك هنا...';

  @override
  String get questionTextRequired => 'نص السؤال مطلوب';

  @override
  String get questionPointsFieldLabel => 'النقاط';

  @override
  String get questionDifficultyFieldLabel => 'الصعوبة';

  @override
  String questionOptionLabel(String letter) {
    return 'الخيار $letter';
  }

  @override
  String get questionAddOption => 'إضافة خيار';

  @override
  String get questionCorrectAnswerLabel => 'الإجابة الصحيحة';

  @override
  String get questionAcceptedAnswerHint => 'مثال: 6x + 2';

  @override
  String get questionEssayInfo => 'الأسئلة المقالية تتطلب تصحيحاً يدوياً.';

  @override
  String get questionExplanationLabel => 'الشرح (اختياري)';

  @override
  String get questionExplanationHint => 'اشرح الإجابة الصحيحة...';

  @override
  String get questionSaveButton => 'حفظ السؤال';

  @override
  String get homeworkManagementTitle => 'إدارة الواجبات';

  @override
  String get homeworkMockBreadcrumb => 'رياضيات-10أ > الواجبات';

  @override
  String get homeworkCreateButton => 'إنشاء واجب';

  @override
  String homeworkTabPublished(int count) {
    return 'منشور ($count)';
  }

  @override
  String homeworkTabDrafts(int count) {
    return 'مسودات ($count)';
  }

  @override
  String homeworkTabScheduled(int count) {
    return 'مجدول ($count)';
  }

  @override
  String get homeworkEmptyMessage => 'لا توجد واجبات.';

  @override
  String homeworkDueToday(String time) {
    return 'يستحق اليوم، $time';
  }

  @override
  String homeworkDueOn(String dateTime) {
    return 'يستحق في $dateTime';
  }

  @override
  String homeworkSubmissionProgress(int submitted, int total) {
    return 'تقدم التسليم: $submitted/$total';
  }

  @override
  String get homeworkDuplicatedSuccess => 'تم نسخ الواجب بنجاح';

  @override
  String get homeworkDeleteConfirmTitle => 'حذف الواجب؟';

  @override
  String homeworkDeleteConfirmMessage(String title) {
    return 'سيتم حذف $title نهائياً.';
  }

  @override
  String get homeworkDeletedSuccess => 'تم حذف الواجب بنجاح';

  @override
  String get homeworkAddFileTitle => 'إضافة ملف تقييم';

  @override
  String get homeworkEditFileTitle => 'تعديل ملف تقييم';

  @override
  String get homeworkSavedSuccess => 'تم حفظ الواجب بنجاح';

  @override
  String get homeworkFileDetailsSection => 'تفاصيل الملف';

  @override
  String get homeworkTitleLabel => 'العنوان';

  @override
  String get homeworkTitleHint => 'مثال: ورقة عمل مراجعة منتصف الفصل';

  @override
  String get homeworkTitleRequired => 'العنوان مطلوب';

  @override
  String get homeworkCategoryLabel => 'الفئة';

  @override
  String get homeworkUploadSection => 'رفع الملف';

  @override
  String get homeworkUploadHint => 'اضغط للرفع أو اسحب وأفلت';

  @override
  String get homeworkUploadSupportedTypes => 'يدعم PDF وDOCX وXLSX';

  @override
  String get homeworkTargetSection => 'الوجهة';

  @override
  String get homeworkTargetExamQuiz => 'إرفاق إلى اختبار';

  @override
  String get homeworkTargetLesson => 'إرفاق إلى درس';

  @override
  String get homeworkSearchExamLabel => 'ابحث عن اختبار أو اختره';

  @override
  String get homeworkSearchLessonLabel => 'ابحث عن درس أو اختره';

  @override
  String get homeworkSearchTargetHint => 'مثال: اختبار منتصف الفصل رياضيات 101';

  @override
  String get homeworkTargetRequired => 'يرجى اختيار وجهة';

  @override
  String get homeworkUploadAndAttach => 'رفع وإرفاق';

  @override
  String get classesTitle => 'فصولي';

  @override
  String get classesSubtitle => 'إدارة الدورات والواجبات النشطة.';

  @override
  String get classesSearchHint => 'ابحث عن فصول...';

  @override
  String get classFilterAll => 'جميع الفصول';

  @override
  String get classFilterMathematics => 'الرياضيات';

  @override
  String get classFilterScience => 'العلوم';

  @override
  String get classFilterNetworking => 'الشبكات';

  @override
  String get classFilterLiterature => 'الأدب';

  @override
  String classStudentsCount(int count) {
    return '$count طالب';
  }

  @override
  String get classNextLesson => 'الدرس التالي';

  @override
  String get classSubmissions => 'التسليمات';

  @override
  String classPendingReview(int count) {
    return '$count بانتظار المراجعة';
  }

  @override
  String get classAllCaughtUp => 'تم الانتهاء من الكل';

  @override
  String get classUrgentAlert => 'تنبيه عاجل';

  @override
  String get classDetailViewStudents => 'عرض الطلاب';

  @override
  String get classDetailExamsQuizzes => 'الاختبارات والمسابقات';

  @override
  String get classCurriculum => 'المنهج';

  @override
  String classCurriculumWeek(int current, int total) {
    return 'الأسبوع $current من $total';
  }

  @override
  String get classActivity => 'نشاط الفصل';

  @override
  String get classAttendance => 'الحضور';

  @override
  String get classPresentToday => 'حاضر اليوم';

  @override
  String get classAbsentToday => 'غائب اليوم';

  @override
  String get classTakeAttendance => 'تسجيل الحضور';

  @override
  String get classPerformance => 'أداء الفصل';

  @override
  String get classAverage => 'متوسط الفصل';

  @override
  String get classAssignmentCompletion => 'إتمام الواجبات';

  @override
  String get classGradeNow => 'تصحيح الآن';

  @override
  String get classSubmitted => 'تم التسليم';

  @override
  String get myCoursesTitle => 'دوراتي';

  @override
  String get myCoursesEmpty => 'لا توجد دورات بعد.';

  @override
  String get myCoursesButton => 'دوراتي';

  @override
  String get classStudents => 'طالب';

  @override
  String get coursesLessonsLabel => 'الدروس';

  @override
  String get coursesStudentsLabel => 'الطلاب';

  @override
  String get coursesRatingLabel => 'التقييم';

  @override
  String myCoursesCoTaughtBy(String names) {
    return 'بالاشتراك مع $names';
  }

  @override
  String get questionTypeChoices => 'خيارات';

  @override
  String get questionTypeUserInput => 'إدخال مستخدم';

  @override
  String get questionTypeOpenEnded => 'سؤال مفتوح';

  @override
  String get questionTypeFileUpload => 'رفع ملف';

  @override
  String get quizPassingPercentage => 'نسبة النجاح';

  @override
  String get quizMaxAttempts => 'أقصى عدد محاولات';

  @override
  String get quizMaxAttemptsUnlimited => 'غير محدود';

  @override
  String get quizShuffleQuestions => 'خلط الأسئلة';

  @override
  String get quizShowAnswers => 'إظهار الإجابات';

  @override
  String get quizEnableNegativeMarking => 'تفعيل الخصم';

  @override
  String get quizMarksToCut => 'الدرجات المخصومة';

  @override
  String get quizLimitQuestions => 'تحديد عدد الأسئلة';

  @override
  String get questionMultipleCorrect => 'إجابات صحيحة متعددة';

  @override
  String get questionPossibilitiesLabel => 'الاحتمالات المقبولة';

  @override
  String get questionPossibility => 'احتمال';

  @override
  String get questionOpenEndedHint =>
      'الأسئلة المقالية تتطلب تصحيحاً يدوياً من قبل المعلم.';

  @override
  String get questionFileUploadHint =>
      'يجيب الطلاب على هذا السؤال برفع ملف، ويحتاج إلى تصحيح يدوي.';

  @override
  String get quizMaxAttemptsHelper => 'أدخل 0 لمحاولات غير محدودة';

  @override
  String get quizDurationHint => 'اتركه فارغاً لوقت غير محدود';

  @override
  String get quizLimitQuestionsHelper => 'اختيار N سؤال عشوائياً (0 للكل)';

  @override
  String get questionBankTitle => 'بنك الأسئلة';

  @override
  String get questionCenterTitle => 'مركز الأسئلة';

  @override
  String get search => 'بحث...';

  @override
  String get addToQuiz => 'أضف إلى الاختبار';

  @override
  String get quizTabOverview => 'نظرة عامة';

  @override
  String get quizTabReview => 'المراجعة';

  @override
  String get quizTimeLimitLabel => 'المدة الزمنية';

  @override
  String get quizPassingScoreLabel => 'درجة النجاح';

  @override
  String get quizNoQuestionsSubtitle =>
      'ابدأ ببناء تقييمك بإضافة أسئلة يدوياً أو الاستيراد من بنك الأسئلة.';

  @override
  String get quizErrorTitle => 'حدث خطأ ما';

  @override
  String get quizRetryButton => 'إعادة المحاولة';

  @override
  String get questionBankFilterType => 'النوع';

  @override
  String get questionBankFilterAll => 'الكل';

  @override
  String get questionBankFilterDifficulty => 'الصعوبة';

  @override
  String get questionBankFilterPoints => 'النقاط';

  @override
  String get questionBankFilterTopic => 'الموضوع';

  @override
  String get questionBankClearFilters => 'مسح الفلاتر';

  @override
  String get questionBankEmptyTitle => 'لا توجد أسئلة';

  @override
  String get questionBankEmptyMessage => 'أنشئ أسئلة أو تحقق لاحقاً.';

  @override
  String get questionBankNoMatches => 'جرّب بحثاً أو فلترًا مختلفاً.';

  @override
  String get questionBankManualTypeBlocked =>
      'يحتوي هذا الاختبار بالفعل على أسئلة تُصحح تلقائياً، لذلك لا يمكن إضافة أسئلة التصحيح اليدوي.';

  @override
  String get questionBankAutoTypeBlocked =>
      'يحتوي هذا الاختبار بالفعل على أسئلة تصحيح يدوي، لذلك لا يمكن إضافة أسئلة تُصحح تلقائياً.';

  @override
  String get questionDeletedSuccess => 'تم حذف السؤال بنجاح';

  @override
  String questionBankSelectedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سؤال محدد',
      one: 'سؤال واحد محدد',
    );
    return '$_temp0';
  }

  @override
  String get questionBankClear => 'مسح';

  @override
  String get quizSetupTitle => 'إعداد الاختبار';

  @override
  String get quizGeneralDetails => 'التفاصيل العامة';

  @override
  String get quizGradingLimits => 'الدرجات والحدود';

  @override
  String get quizBehavior => 'سلوك الاختبار';

  @override
  String get questionSavedDraft => 'مسودة محفوظة';

  @override
  String get questionAttachMedia => 'إرفاق وسائط';

  @override
  String get quizReorderButton => 'إعادة ترتيب';

  @override
  String questionOfTotal(int current, int total) {
    return 'السؤال $current من $total';
  }

  @override
  String quizChoicesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count خيارات',
      one: 'خيار واحد',
    );
    return '$_temp0';
  }

  @override
  String get quizSaveSettings => 'حفظ الإعدادات';

  @override
  String get quizReviewPlaceholderTitle => 'النتائج غير متاحة';

  @override
  String get quizReviewPlaceholderMessage =>
      'تتبع النتائج غير مُدمج بالكامل بعد.';

  @override
  String get quizCourseLabel => 'الدورة';

  @override
  String get quizLessonLabel => 'الدرس';

  @override
  String get quizTimeLimitToggle => 'المدة الزمنية';

  @override
  String get quizMinutesLabel => 'الدقائق';

  @override
  String get quizShowCorrectAnswersToggle => 'إظهار الإجابات الصحيحة';

  @override
  String get quizNegativeMarkingToggle => 'الخصم السلبي';

  @override
  String get next => 'التالي';

  @override
  String get back => 'رجوع';

  @override
  String get done => 'تم';

  @override
  String get saveLocally => 'حفظ محلياً';

  @override
  String get addNew => 'إضافة جديد';

  @override
  String get questionRemoved => 'تمت إزالة السؤال';

  @override
  String questionsAddedFromBank(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تمت إضافة $count سؤال من البنك',
      one: 'تمت إضافة سؤال واحد من البنك',
    );
    return '$_temp0';
  }

  @override
  String get homeworkFilterLabel => 'الحالة';

  @override
  String get homeworkFilterAll => 'كل';

  @override
  String get homeworkFilterPublished => 'منشور';

  @override
  String get homeworkFilterDrafts => 'مسودات';

  @override
  String get homeworkViewDetails => 'عرض التفاصيل';

  @override
  String get homeworkNoCourse => 'لا توجد دورة';

  @override
  String get homeworkNoDueDate => 'لا يوجد موعد تسليم';

  @override
  String get homeworkUntitled => 'واجب بلا عنوان';

  @override
  String get homeworkLateAllowed => 'يسمح بالتسليم المتأخر';

  @override
  String get homeworkAttachmentAvailable => 'يوجد مرفق';

  @override
  String get homeworkEndOfResults => 'وصلت إلى نهاية النتائج.';

  @override
  String get homeworkLoadMoreFailed => 'تعذر تحميل المزيد من الواجبات.';

  @override
  String get homeworkInstructionsUnavailable => 'لم تتم إضافة تعليمات.';

  @override
  String get homeGreetingMorning => 'صباح الخير';

  @override
  String get homeGreetingAfternoon => 'طاب مساؤك';

  @override
  String get homeGreetingEvening => 'مساء الخير';

  @override
  String homeGreetingTemplate(String greeting, String teacherName) {
    return '$greeting، $teacherName';
  }

  @override
  String get homeGreetingSecondaryFallback => 'هل أنت مستعد لدرس اليوم؟';

  @override
  String homeGreetingSecondaryWithActivity(String activity) {
    return 'هل أنت مستعد لدرس اليوم في $activity؟';
  }

  @override
  String organizationNoticeCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count إشعارات مؤسسية جديدة',
      one: 'إشعار مؤسسي جديد واحد',
      zero: 'لا توجد إشعارات مؤسسية جديدة',
    );
    return '$_temp0';
  }

  @override
  String get homeNoPostsTitle => 'لا توجد منشورات بعد';

  @override
  String get homeNoPostsSubtitle =>
      'لا توجد منشورات متاحة لهذا الفصل الدراسي بعد.';

  @override
  String get homeFeedFilterAll => 'كل الفصول';

  @override
  String get postTypeBadgePinned => 'مثبت';

  @override
  String get postTypeBadgeAnnouncement => 'إعلان';

  @override
  String get postTypeBadgeQuestion => 'سؤال';

  @override
  String get postTypeBadgeDiscussion => 'نقاش';

  @override
  String get postTypeBadgeResource => 'مصدر';

  @override
  String get postTypeBadgeAssignment => 'واجب';

  @override
  String get postTypeBadgeQuiz => 'اختبار';

  @override
  String get postTypeBadgeAchievement => 'إنجاز';

  @override
  String get postTypeBadgePoll => 'استطلاع';

  @override
  String get postTypeBadgeSystem => 'تحديث النظام';

  @override
  String get postYouLabel => '(أنت)';

  @override
  String get postModerateBadge => 'إشراف';

  @override
  String get postReadMore => 'اقرأ المزيد';

  @override
  String get postShowLess => 'عرض أقل';

  @override
  String get postLike => 'إعجاب';

  @override
  String get postComment => 'تعليق';

  @override
  String get postShare => 'مشاركة';

  @override
  String get postMenuEdit => 'تعديل';

  @override
  String get postMenuDelete => 'حذف';

  @override
  String get postMenuPin => 'تثبيت';

  @override
  String get postMenuUnpin => 'إلغاء التثبيت';

  @override
  String get postMenuCopyText => 'نسخ النص';

  @override
  String get postMenuReport => 'إبلاغ';

  @override
  String get postMenuHide => 'إخفاء';

  @override
  String get postMenuModerate => 'إشراف';

  @override
  String get postDeleteConfirmTitle => 'حذف المنشور؟';

  @override
  String get postDeleteConfirmBody => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get postDeleteConfirmAction => 'حذف';

  @override
  String get postImageSemantic => 'صورة المنشور';

  @override
  String get postActionComingSoon => 'هذه الميزة ستتوفر قريباً.';

  @override
  String get homeNoMorePosts => 'لقد شاهدت كل المنشورات';

  @override
  String get notificationsBadgeSemantic => 'الإشعارات';

  @override
  String get teacherAvatarSemantic => 'الملف الشخصي للمعلم';

  @override
  String get discard => 'تجاهل';

  @override
  String get confirm => 'تأكيد';

  @override
  String get unsavedChangesDiscard =>
      'لديك تغييرات غير محفوظة. هل تريد تجاهلها؟';

  @override
  String get savingQuiz => 'جاري حفظ الاختبار...';

  @override
  String quizUpdatedWithErrors(int count) {
    return 'تم تحديث الاختبار مع بعض الأخطاء. فشل في حذف $count أسئلة.';
  }

  @override
  String pleaseCompleteQuestion(int index) {
    return 'يرجى إكمال السؤال $index';
  }

  @override
  String questionsToDeleteAndAdd(int deleteCount, int addCount) {
    return 'لديك $deleteCount أسئلة لحذفها و $addCount أسئلة لإضافتها/تحديثها. هل تريد المتابعة؟';
  }
}
