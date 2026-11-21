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

  @override
  String stepOf(int current, int total) {
    return 'الخطوة $current من $total';
  }

  @override
  String get locationPermissionTitle => 'فعّل الوصول إلى موقعك';

  @override
  String get locationPermissionSubtitle =>
      'نحتاج موقعك لبدء اليوم وتوجيهك للعملاء بدقة';

  @override
  String get locationBenefitWarehouseTitle => 'بدء اليوم من المستودع';

  @override
  String get locationBenefitWarehouseSubtitle =>
      'نتحقق أنك داخل نطاق المستودع عند البدء';

  @override
  String get locationBenefitRouteTitle => 'أفضل مسار للتوصيل';

  @override
  String get locationBenefitRouteSubtitle => 'ترتيب الطلبات حسب أقرب عميل';

  @override
  String get locationBenefitTrackingTitle => 'متابعة لحظية للرحلة';

  @override
  String get locationBenefitTrackingSubtitle =>
      'تُحدَّث حالة الطلب تلقائيًا لفريق العمليات';

  @override
  String get locationAlwaysNote =>
      'سنطلب بعدها «السماح دائمًا» لمتابعة الرحلة أثناء قفل الشاشة';

  @override
  String get allowLocationAccess => 'السماح بالوصول للموقع';

  @override
  String get locationDeniedTitle => 'الموقع مطلوب لبدء العمل';

  @override
  String get locationDeniedSubtitle =>
      'بدون إذن الموقع لا يمكن تسجيل بدء يومك أو توجيهك للعملاء';

  @override
  String get locationDeniedStepSettingsTitle => 'افتح إعدادات الجهاز';

  @override
  String get locationDeniedStepSettingsSubtitle =>
      'من زر «فتح الإعدادات» بالأسفل';

  @override
  String get locationDeniedStepAppTitle => 'الموقع ← Diva Courier';

  @override
  String get locationDeniedStepAppSubtitle => 'اختر التطبيق من قائمة التطبيقات';

  @override
  String get locationDeniedStepAlwaysTitle => 'اختر «دائمًا»';

  @override
  String get locationDeniedStepAlwaysSubtitle =>
      'لمتابعة الرحلة أثناء قفل الشاشة';

  @override
  String get locationPrivacyNote =>
      'نستخدم موقعك أثناء ساعات العمل فقط، ولا نشاركه مع العملاء';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get cameraPermissionTitle => 'الكاميرا والصور';

  @override
  String get cameraPermissionSubtitle =>
      'لتوثيق التسليم بسرعة دون مغادرة التطبيق';

  @override
  String get cameraBenefitProofTitle => 'صورة إثبات التسليم';

  @override
  String get cameraBenefitProofSubtitle => 'التقط صورة الطلب عند باب العميل';

  @override
  String get cameraBenefitCallLogTitle => 'لقطة سجل المكالمات';

  @override
  String get cameraBenefitCallLogSubtitle =>
      'ارفع لقطة شاشة عند تعذّر الوصول للعميل';

  @override
  String get allowAccess => 'السماح بالوصول';

  @override
  String get later => 'لاحقًا';

  @override
  String get homeDayNotStarted => 'لم تبدأ يومك بعد';

  @override
  String get homeDayStarted => 'يومك بدأ، بالتوفيق';

  @override
  String homeDayStartedAt(String time) {
    return 'بدأ يومك · $time';
  }

  @override
  String get homeTotalCollected => 'إجمالي المحصّل';

  @override
  String get homeTotalOrders => 'إجمالي الطلبات';

  @override
  String get orderStatusCancelled => 'ملغاة';

  @override
  String get orderStatusCompleted => 'مكتملة';

  @override
  String get orderStatusNew => 'جديدة';

  @override
  String get orderStatusWithCaptain => 'مع الكابتن';

  @override
  String get homeAnnouncements => 'إعلانات الإدارة';

  @override
  String countOf(int current, int total) {
    return '$current من $total';
  }

  @override
  String get inRange => 'داخل النطاق';

  @override
  String get outOfRange => 'خارج النطاق';

  @override
  String get swipeToStartDay => 'اسحب لبدء اليوم';

  @override
  String get checkingLocation => 'جارٍ التحقق من موقعك…';

  @override
  String get noOrdersToStartDay => 'لا توجد طلبات لبدء اليوم';

  @override
  String get noOrdersHint => 'سنرسل لك إشعارًا فور إسناد طلبات جديدة لك';

  @override
  String get deliveredToday => 'تم التسليم اليوم';

  @override
  String get viewOrders => 'عرض الطلبات';

  @override
  String get outOfRangeTitle => 'أنت خارج نطاق المستودع';

  @override
  String outOfRangeSubtitle(String warehouse) {
    return 'اقترب من «$warehouse» ثم حاول مرة أخرى لبدء يومك';
  }

  @override
  String distanceFromWarehouse(String distance) {
    return 'تبعد $distance كم عن المستودع';
  }

  @override
  String get youAreHere => 'أنت هنا';

  @override
  String get openDirections => 'فتح الاتجاهات';

  @override
  String get dayStartedTitle => 'بدأ يومك بنجاح';

  @override
  String dayStartedSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'استلمت $count طلبًا وأصبحت جميعها «مع الكابتن». بالتوفيق!',
      few: 'استلمت $count طلبات وأصبحت جميعها «مع الكابتن». بالتوفيق!',
      two: 'استلمت طلبين وأصبحا «مع الكابتن». بالتوفيق!',
      one: 'استلمت طلبًا واحدًا وأصبح «مع الكابتن». بالتوفيق!',
    );
    return '$_temp0';
  }

  @override
  String get summaryWarehouse => 'المستودع';

  @override
  String get summaryStartTime => 'وقت البدء';

  @override
  String get summaryOrders => 'الطلبات';

  @override
  String ordersWithCaptain(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طلبًا · مع الكابتن',
      few: '$count طلبات · مع الكابتن',
      two: 'طلبان · مع الكابتن',
      one: 'طلب واحد · مع الكابتن',
    );
    return '$_temp0';
  }

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navOrders => 'الطلبات';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get locationUnavailable =>
      'تعذّر تحديد موقعك. تأكد من تشغيل الموقع وحاول مرة أخرى.';

  @override
  String get homeLoadError => 'تعذّر تحميل بيانات يومك';

  @override
  String get comingSoon => 'قريبًا';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileSubtitle => 'حسابك وإعدادات التطبيق';

  @override
  String profileCaption(String code) {
    return 'كابتن توصيل · $code';
  }

  @override
  String get profileOnDuty => 'في الخدمة';

  @override
  String get profileOffDuty => 'خارج الخدمة';

  @override
  String get profilePersonalInfo => 'المعلومات الشخصية';

  @override
  String get profileLanguage => 'اللغة';

  @override
  String get profileLocationPermission => 'إذن الموقع';

  @override
  String get locationAccessAlways => 'دائمًا';

  @override
  String get locationAccessWhileInUse => 'أثناء الاستخدام';

  @override
  String get locationAccessOff => 'غير مفعّل';

  @override
  String get profileSupport => 'الدعم والمساعدة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String appVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String get profileLoadError => 'تعذّر تحميل الملف الشخصي';

  @override
  String get changePhoto => 'تغيير الصورة';

  @override
  String get personalInfoSubtitle => 'بياناتك المسجّلة لدى الشركة';

  @override
  String get personalInfoReadOnly =>
      'البيانات للعرض فقط · لتعديلها تواصل مع المشرف';

  @override
  String get personalInfoBasic => 'البيانات الأساسية';

  @override
  String get personalInfoName => 'الاسم';

  @override
  String get personalInfoCode => 'رقم الكابتن';

  @override
  String get personalInfoPhone => 'رقم الجوال';

  @override
  String get personalInfoEmail => 'البريد الإلكتروني';

  @override
  String get personalInfoWork => 'بيانات العمل';

  @override
  String get personalInfoWarehouse => 'المستودع';

  @override
  String get personalInfoSupervisor => 'المشرف';

  @override
  String get personalInfoVehicle => 'المركبة';

  @override
  String get personalInfoJoined => 'تاريخ الانضمام';

  @override
  String get copied => 'تم النسخ';

  @override
  String get photoSheetTitle => 'صورة الملف الشخصي';

  @override
  String get photoSheetSubtitle => 'تظهر للمشرف وللعميل عند التوصيل';

  @override
  String get photoTake => 'التقاط صورة';

  @override
  String get photoChoose => 'اختيار من المعرض';

  @override
  String get photoDelete => 'حذف الصورة';

  @override
  String get photoUpdated => 'تم تحديث الصورة';

  @override
  String get photoRemoved => 'تم حذف الصورة';

  @override
  String get photoUpdateError => 'تعذّر تحديث الصورة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get languageSubtitle => 'لغة واجهة التطبيق';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get profileTheme => 'المظهر';

  @override
  String get themeSubtitle => 'مظهر واجهة التطبيق';

  @override
  String get themeSystem => 'حسب النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get logoutTitle => 'تسجيل الخروج؟';

  @override
  String get logoutSubtitle =>
      'سيتوقف تتبع موقعك ولن تصلك طلبات جديدة حتى تسجّل الدخول مرة أخرى.';

  @override
  String get logoutOpenOrdersTitle => 'لديك طلبات مفتوحة';

  @override
  String logoutOpenOrdersSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طلب قيد التوصيل',
      few: '$count طلبات قيد التوصيل',
      two: 'طلبان قيد التوصيل',
      one: 'طلب واحد قيد التوصيل',
    );
    return 'عندك $_temp0 ومبالغ لم تُسلَّم للمستودع. لو خرجت هيتوقف تتبع موقعك ولن تصلك طلبات جديدة.';
  }

  @override
  String get logoutError => 'تعذّر تسجيل الخروج';
}
