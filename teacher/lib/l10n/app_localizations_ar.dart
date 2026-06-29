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
}
