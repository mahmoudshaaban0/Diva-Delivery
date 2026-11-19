// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ليمتلس كود';

  @override
  String get hello => 'مرحباً';

  @override
  String welcomeUser(String name) {
    return 'أهلاً، $name!';
  }

  @override
  String get arabic => 'العربيه';

  @override
  String get splashTagline => 'كل توصيلة في مكانها الصحيح';

  @override
  String splashFooter(String version) {
    return 'الإصدار $version · Expert Partners';
  }

  @override
  String get contactSupport => 'التواصل مع الدعم';

  @override
  String get loginWelcome => 'أهلاً بك، كابتن';

  @override
  String get loginSubtitle => 'سجّل دخولك لبدء يوم التوصيل';

  @override
  String get mobileNumber => 'رقم الجوال';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get phoneHint => '5X XXX XXXX';

  @override
  String get emailHint => 'name@company.com';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get showPassword => 'إظهار كلمة المرور';

  @override
  String get hidePassword => 'إخفاء كلمة المرور';

  @override
  String get phoneInvalid => 'أدخل رقم جوال صحيحًا يبدأ بـ 5';

  @override
  String get emailInvalid => 'أدخل بريدًا إلكترونيًا صحيحًا';

  @override
  String get passwordRequired => 'أدخل كلمة المرور';

  @override
  String get secureConnection => 'اتصال آمن ومشفّر · بياناتك محمية';

  @override
  String get sendOtp => 'إرسال رمز التحقق';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get termsNotice => 'بالمتابعة أنت توافق على الشروط وسياسة الخصوصية';

  @override
  String get otpTitle => 'التحقق من الجوال';

  @override
  String get otpHeading => 'أدخل رمز التحقق';

  @override
  String get otpHeadingError => 'الرمز غير صحيح';

  @override
  String otpSentTo(int length) {
    return 'أرسلنا رمزًا من $length أرقام إلى';
  }

  @override
  String get resendIn => 'إعادة الإرسال خلال';

  @override
  String get otpNotReceived => 'لم يصلك الرمز؟';

  @override
  String get otpResend => 'إعادة إرسال الرمز';

  @override
  String get otpVerify => 'تحقّق ومتابعة';

  @override
  String get otpVerifyAgain => 'تحقّق مرة أخرى';

  @override
  String otpInvalidAttempts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تبقّت $count محاولة',
      few: 'تبقّت $count محاولات',
      two: 'تبقّت محاولتان',
      one: 'تبقّت محاولة واحدة',
      zero: 'لم تتبقَّ محاولات',
    );
    return 'انتهت صلاحية الرمز أو أُدخل خطأً — $_temp0';
  }

  @override
  String get otpInvalid => 'انتهت صلاحية الرمز أو أُدخل خطأً';

  @override
  String get forgotPasswordTitle => 'استعادة كلمة المرور';

  @override
  String get forgotPasswordSubtitle =>
      'أدخل بريدك الإلكتروني المسجّل، وهنرسل لك رابط لتعيين كلمة مرور جديدة.';

  @override
  String get sendLink => 'إرسال الرابط';

  @override
  String get checkYourEmail => 'تحقق من بريدك';

  @override
  String resetLinkSentTo(String email, int minutes) {
    return 'أرسلنا رابط إعادة التعيين إلى $email. الرابط صالح لمدة $minutes دقيقة.';
  }

  @override
  String get backToSignIn => 'العودة لتسجيل الدخول';

  @override
  String get linkNotReceived => 'لم يصلك الرابط؟';

  @override
  String get resendLink => 'إعادة إرسال الرابط';

  @override
  String get noInternetConnection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get retry => 'إعادة المحاولة';
}
