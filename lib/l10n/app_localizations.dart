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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'Limitless Code'**
  String get appTitle;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcomeUser(String name);

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'arabic'**
  String get arabic;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Every delivery in its right place'**
  String get splashTagline;

  /// No description provided for @splashFooter.
  ///
  /// In en, this message translates to:
  /// **'Expert Partners · Version {version}'**
  String splashFooter(String version);

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get contactSupport;

  /// No description provided for @loginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, Captain'**
  String get loginWelcome;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to start your delivery day'**
  String get loginSubtitle;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get mobileNumber;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'5X XXX XXXX'**
  String get phoneHint;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'name@company.com'**
  String get emailHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @phoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid mobile number starting with 5'**
  String get phoneInvalid;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordRequired;

  /// No description provided for @secureConnection.
  ///
  /// In en, this message translates to:
  /// **'Secure, encrypted connection · Your data is protected'**
  String get secureConnection;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get sendOtp;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @termsNotice.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to the Terms and Privacy Policy'**
  String get termsNotice;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify mobile'**
  String get otpTitle;

  /// No description provided for @otpHeading.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get otpHeading;

  /// No description provided for @otpHeadingError.
  ///
  /// In en, this message translates to:
  /// **'Incorrect code'**
  String get otpHeadingError;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a {length}-digit code to'**
  String otpSentTo(int length);

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in'**
  String get resendIn;

  /// No description provided for @otpNotReceived.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get the code?'**
  String get otpNotReceived;

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get otpResend;

  /// No description provided for @otpVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify and continue'**
  String get otpVerify;

  /// No description provided for @otpVerifyAgain.
  ///
  /// In en, this message translates to:
  /// **'Verify again'**
  String get otpVerifyAgain;

  /// No description provided for @otpInvalidAttempts.
  ///
  /// In en, this message translates to:
  /// **'The code expired or was entered incorrectly — {count, plural, =0{no attempts left} =1{1 attempt left} other{{count} attempts left}}'**
  String otpInvalidAttempts(int count);

  /// No description provided for @otpInvalid.
  ///
  /// In en, this message translates to:
  /// **'The code expired or was entered incorrectly'**
  String get otpInvalid;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email and we\'ll send you a link to set a new password.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendLink.
  ///
  /// In en, this message translates to:
  /// **'Send link'**
  String get sendLink;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get checkYourEmail;

  /// No description provided for @resetLinkSentTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a reset link to {email}. The link is valid for {minutes} minutes.'**
  String resetLinkSentTo(String email, int minutes);

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get backToSignIn;

  /// No description provided for @linkNotReceived.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get the link?'**
  String get linkNotReceived;

  /// No description provided for @resendLink.
  ///
  /// In en, this message translates to:
  /// **'Resend link'**
  String get resendLink;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepOf(int current, int total);

  /// No description provided for @locationPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Turn on location access'**
  String get locationPermissionTitle;

  /// No description provided for @locationPermissionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We need your location to start the day and guide you to customers accurately'**
  String get locationPermissionSubtitle;

  /// No description provided for @locationBenefitWarehouseTitle.
  ///
  /// In en, this message translates to:
  /// **'Start the day at the warehouse'**
  String get locationBenefitWarehouseTitle;

  /// No description provided for @locationBenefitWarehouseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We check you\'re inside the warehouse zone when you start'**
  String get locationBenefitWarehouseSubtitle;

  /// No description provided for @locationBenefitRouteTitle.
  ///
  /// In en, this message translates to:
  /// **'Best delivery route'**
  String get locationBenefitRouteTitle;

  /// No description provided for @locationBenefitRouteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Orders sorted by the nearest customer'**
  String get locationBenefitRouteSubtitle;

  /// No description provided for @locationBenefitTrackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Live trip tracking'**
  String get locationBenefitTrackingTitle;

  /// No description provided for @locationBenefitTrackingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Order status updates automatically for the operations team'**
  String get locationBenefitTrackingSubtitle;

  /// No description provided for @locationAlwaysNote.
  ///
  /// In en, this message translates to:
  /// **'Next we\'ll ask for “Allow all the time” to track the trip while the screen is locked'**
  String get locationAlwaysNote;

  /// No description provided for @allowLocationAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow location access'**
  String get allowLocationAccess;

  /// No description provided for @locationDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Location is required to start work'**
  String get locationDeniedTitle;

  /// No description provided for @locationDeniedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Without location access you can\'t start your day or get directions to customers'**
  String get locationDeniedSubtitle;

  /// No description provided for @locationDeniedStepSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Open device settings'**
  String get locationDeniedStepSettingsTitle;

  /// No description provided for @locationDeniedStepSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Using the “Open settings” button below'**
  String get locationDeniedStepSettingsSubtitle;

  /// No description provided for @locationDeniedStepAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Location → Diva Courier'**
  String get locationDeniedStepAppTitle;

  /// No description provided for @locationDeniedStepAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the app from the apps list'**
  String get locationDeniedStepAppSubtitle;

  /// No description provided for @locationDeniedStepAlwaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose “Always”'**
  String get locationDeniedStepAlwaysTitle;

  /// No description provided for @locationDeniedStepAlwaysSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To track the trip while the screen is locked'**
  String get locationDeniedStepAlwaysSubtitle;

  /// No description provided for @locationPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'We only use your location during working hours and never share it with customers'**
  String get locationPrivacyNote;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @cameraPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera & photos'**
  String get cameraPermissionTitle;

  /// No description provided for @cameraPermissionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'To document deliveries quickly without leaving the app'**
  String get cameraPermissionSubtitle;

  /// No description provided for @cameraBenefitProofTitle.
  ///
  /// In en, this message translates to:
  /// **'Proof-of-delivery photo'**
  String get cameraBenefitProofTitle;

  /// No description provided for @cameraBenefitProofSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Take a photo of the order at the customer\'s door'**
  String get cameraBenefitProofSubtitle;

  /// No description provided for @cameraBenefitCallLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Call log screenshot'**
  String get cameraBenefitCallLogTitle;

  /// No description provided for @cameraBenefitCallLogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload a screenshot when you can\'t reach the customer'**
  String get cameraBenefitCallLogSubtitle;

  /// No description provided for @allowAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow access'**
  String get allowAccess;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;
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
