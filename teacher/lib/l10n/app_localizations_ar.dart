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
}
