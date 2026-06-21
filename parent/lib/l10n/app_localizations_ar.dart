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
  String get loginTitle => 'دخول ولي الأمر';

  @override
  String get loginSubtitle => 'سجّل دخولك ببريد مؤسستك للمتابعة.';

  @override
  String get phoneNumberLabel => 'رقم الهاتف';

  @override
  String get phoneNumberHint => 'أدخل رقم هاتفك';

  @override
  String get sendOtpButton => 'إرسال رمز التحقق';

  @override
  String get orgLoginLink => 'تسجيل الدخول بالهاتف بدلاً من ذلك';

  @override
  String get phoneLoginSecurityNote =>
      'حساب ولي الأمر يحمي بيانات طفلك الحساسة.';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get emailHint => 'أدخل بريدك الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get forgotPasswordLink => 'نسيت كلمة المرور؟';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get orgLoginTitle => 'تسجيل الدخول بالهاتف';

  @override
  String get orgLoginSubtitle => 'أدخل رقم هاتفك لاستلام رمز التحقق.';

  @override
  String get orgLoginButton => 'متابعة';

  @override
  String get otpTitle => 'تحقق من هويتك';

  @override
  String otpSubtitle(Object identifier) {
    return 'أرسلنا رمزاً مكوناً من 6 أرقام إلى $identifier';
  }

  @override
  String get otpResend => 'إعادة إرسال الرمز';

  @override
  String get otpVerifyButton => 'تحقق';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordSubtitle =>
      'أدخل بريدك الإلكتروني وسنرسل لك رمز إعادة التعيين';

  @override
  String get sendResetLinkButton => 'إرسال رمز الاستعادة';

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
  String get resetPasswordButton => 'إعادة التعيين';

  @override
  String get passwordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get biometricTitle => 'مرحباً بعودتك';

  @override
  String get biometricSubtitle => 'استخدم المقاييس الحيوية لفتح القفل';

  @override
  String get biometricPrompt => 'المصادقة للوصول إلى سكولير';

  @override
  String get usePasswordFallback => 'استخدم كلمة المرور بدلاً من ذلك';

  @override
  String get authErrorInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get authErrorOtpInvalid => 'الرمز غير صالح أو منتهي الصلاحية';

  @override
  String get authErrorGeneric => 'حدث خطأ ما. يرجى المحاولة مرة أخرى';

  @override
  String get onboardingPage1Title => 'تابع كل طفل';

  @override
  String get onboardingPage1Body =>
      'اطّلع بسرعة على واجبات أطفالك والامتحانات والدرجات والحضور والتقارير وتحديثات المدرسة.';

  @override
  String get onboardingPage2Title => 'راقب التقدم';

  @override
  String get onboardingPage2Body =>
      'راجع الدرجات والواجبات والامتحانات والحضور والتقارير بتفاصيل واضحة تركّز على طفلك.';

  @override
  String get onboardingPage3Title => 'ابقَ على تواصل';

  @override
  String get onboardingPage3Body =>
      'تواصل مع المعلمين وتلقَّ الإعلانات وأقرّ الفعاليات وادعم طفلك بثقة.';

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
}
