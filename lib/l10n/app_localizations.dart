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

  /// No description provided for @homeDayNotStarted.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t started your day yet'**
  String get homeDayNotStarted;

  /// No description provided for @homeDayStarted.
  ///
  /// In en, this message translates to:
  /// **'Your day has started, good luck'**
  String get homeDayStarted;

  /// No description provided for @homeDayStartedAt.
  ///
  /// In en, this message translates to:
  /// **'Day started · {time}'**
  String homeDayStartedAt(String time);

  /// No description provided for @homeTotalCollected.
  ///
  /// In en, this message translates to:
  /// **'Total collected'**
  String get homeTotalCollected;

  /// No description provided for @homeTotalOrders.
  ///
  /// In en, this message translates to:
  /// **'Total orders'**
  String get homeTotalOrders;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get orderStatusCancelled;

  /// No description provided for @orderStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get orderStatusCompleted;

  /// No description provided for @orderStatusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get orderStatusNew;

  /// No description provided for @orderStatusWithCaptain.
  ///
  /// In en, this message translates to:
  /// **'With captain'**
  String get orderStatusWithCaptain;

  /// No description provided for @homeAnnouncements.
  ///
  /// In en, this message translates to:
  /// **'Management announcements'**
  String get homeAnnouncements;

  /// No description provided for @countOf.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String countOf(int current, int total);

  /// No description provided for @inRange.
  ///
  /// In en, this message translates to:
  /// **'In range'**
  String get inRange;

  /// No description provided for @outOfRange.
  ///
  /// In en, this message translates to:
  /// **'Out of range'**
  String get outOfRange;

  /// No description provided for @swipeToStartDay.
  ///
  /// In en, this message translates to:
  /// **'Swipe to start the day'**
  String get swipeToStartDay;

  /// No description provided for @checkingLocation.
  ///
  /// In en, this message translates to:
  /// **'Checking your location…'**
  String get checkingLocation;

  /// No description provided for @noOrdersToStartDay.
  ///
  /// In en, this message translates to:
  /// **'No orders to start the day'**
  String get noOrdersToStartDay;

  /// No description provided for @noOrdersHint.
  ///
  /// In en, this message translates to:
  /// **'We\'ll notify you as soon as new orders are assigned to you'**
  String get noOrdersHint;

  /// No description provided for @deliveredToday.
  ///
  /// In en, this message translates to:
  /// **'Delivered today'**
  String get deliveredToday;

  /// No description provided for @viewOrders.
  ///
  /// In en, this message translates to:
  /// **'View orders'**
  String get viewOrders;

  /// No description provided for @outOfRangeTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re outside the warehouse zone'**
  String get outOfRangeTitle;

  /// No description provided for @outOfRangeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get closer to “{warehouse}” and try again to start your day'**
  String outOfRangeSubtitle(String warehouse);

  /// No description provided for @distanceFromWarehouse.
  ///
  /// In en, this message translates to:
  /// **'{distance} km from the warehouse'**
  String distanceFromWarehouse(String distance);

  /// No description provided for @youAreHere.
  ///
  /// In en, this message translates to:
  /// **'You are here'**
  String get youAreHere;

  /// No description provided for @openDirections.
  ///
  /// In en, this message translates to:
  /// **'Open directions'**
  String get openDirections;

  /// No description provided for @dayStartedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your day has started'**
  String get dayStartedTitle;

  /// No description provided for @dayStartedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{You received 1 order and it\'s now “with the captain”. Good luck!} other{You received {count} orders and they\'re all “with the captain”. Good luck!}}'**
  String dayStartedSubtitle(int count);

  /// No description provided for @summaryWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Warehouse'**
  String get summaryWarehouse;

  /// No description provided for @summaryStartTime.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get summaryStartTime;

  /// No description provided for @summaryOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get summaryOrders;

  /// No description provided for @ordersWithCaptain.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 order · with captain} other{{count} orders · with captain}}'**
  String ordersWithCaptain(int count);

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get navOrders;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t get your location. Make sure location is on and try again.'**
  String get locationUnavailable;

  /// No description provided for @homeLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your day'**
  String get homeLoadError;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your account and app settings'**
  String get profileSubtitle;

  /// No description provided for @profileCaption.
  ///
  /// In en, this message translates to:
  /// **'Delivery captain · {code}'**
  String profileCaption(String code);

  /// No description provided for @profileOnDuty.
  ///
  /// In en, this message translates to:
  /// **'On duty'**
  String get profileOnDuty;

  /// No description provided for @profileOffDuty.
  ///
  /// In en, this message translates to:
  /// **'Off duty'**
  String get profileOffDuty;

  /// No description provided for @profilePersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal information'**
  String get profilePersonalInfo;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileLocationPermission.
  ///
  /// In en, this message translates to:
  /// **'Location permission'**
  String get profileLocationPermission;

  /// No description provided for @locationAccessAlways.
  ///
  /// In en, this message translates to:
  /// **'Always'**
  String get locationAccessAlways;

  /// No description provided for @locationAccessWhileInUse.
  ///
  /// In en, this message translates to:
  /// **'While using'**
  String get locationAccessWhileInUse;

  /// No description provided for @locationAccessOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get locationAccessOff;

  /// No description provided for @profileSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get profileSupport;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersion(String version);

  /// No description provided for @profileLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your profile'**
  String get profileLoadError;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get changePhoto;

  /// No description provided for @personalInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your details on record with the company'**
  String get personalInfoSubtitle;

  /// No description provided for @personalInfoReadOnly.
  ///
  /// In en, this message translates to:
  /// **'View only · contact your supervisor to change it'**
  String get personalInfoReadOnly;

  /// No description provided for @personalInfoBasic.
  ///
  /// In en, this message translates to:
  /// **'Basic details'**
  String get personalInfoBasic;

  /// No description provided for @personalInfoName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get personalInfoName;

  /// No description provided for @personalInfoCode.
  ///
  /// In en, this message translates to:
  /// **'Captain number'**
  String get personalInfoCode;

  /// No description provided for @personalInfoPhone.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get personalInfoPhone;

  /// No description provided for @personalInfoEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get personalInfoEmail;

  /// No description provided for @personalInfoWork.
  ///
  /// In en, this message translates to:
  /// **'Work details'**
  String get personalInfoWork;

  /// No description provided for @personalInfoWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Warehouse'**
  String get personalInfoWarehouse;

  /// No description provided for @personalInfoSupervisor.
  ///
  /// In en, this message translates to:
  /// **'Supervisor'**
  String get personalInfoSupervisor;

  /// No description provided for @personalInfoVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get personalInfoVehicle;

  /// No description provided for @personalInfoJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get personalInfoJoined;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @photoSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get photoSheetTitle;

  /// No description provided for @photoSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shown to your supervisor and to customers on delivery'**
  String get photoSheetSubtitle;

  /// No description provided for @photoTake.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get photoTake;

  /// No description provided for @photoChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get photoChoose;

  /// No description provided for @photoDelete.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get photoDelete;

  /// No description provided for @photoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile photo updated'**
  String get photoUpdated;

  /// No description provided for @photoRemoved.
  ///
  /// In en, this message translates to:
  /// **'Profile photo removed'**
  String get photoRemoved;

  /// No description provided for @photoUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update the photo'**
  String get photoUpdateError;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'App interface language'**
  String get languageSubtitle;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @profileTheme.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get profileTheme;

  /// No description provided for @themeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How the app looks'**
  String get themeSubtitle;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logoutTitle;

  /// No description provided for @logoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Location tracking will stop and you won\'t get new orders until you sign in again.'**
  String get logoutSubtitle;

  /// No description provided for @logoutOpenOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'You have open orders'**
  String get logoutOpenOrdersTitle;

  /// No description provided for @logoutOpenOrdersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You have {count, plural, =1{1 order} other{{count} orders}} out for delivery and cash not yet handed in to the warehouse. If you log out, location tracking will stop and you won\'t get new orders.'**
  String logoutOpenOrdersSubtitle(int count);

  /// No description provided for @logoutError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t log out'**
  String get logoutError;

  /// No description provided for @ordersTitle.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get ordersTitle;

  /// No description provided for @ordersCurrentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 order} other{{count} orders}} · {date}'**
  String ordersCurrentSubtitle(int count, String date);

  /// No description provided for @ordersPreviousSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 past order} other{{count} past orders}}'**
  String ordersPreviousSubtitle(int count);

  /// No description provided for @ordersNoCurrentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'No current orders'**
  String get ordersNoCurrentSubtitle;

  /// No description provided for @ordersSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by order number or customer name'**
  String get ordersSearchHint;

  /// No description provided for @ordersClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get ordersClearSearch;

  /// No description provided for @ordersTabCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current ({count})'**
  String ordersTabCurrent(int count);

  /// No description provided for @ordersTabPrevious.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get ordersTabPrevious;

  /// No description provided for @ordersSortTitle.
  ///
  /// In en, this message translates to:
  /// **'Sort orders'**
  String get ordersSortTitle;

  /// No description provided for @ordersSortNearest.
  ///
  /// In en, this message translates to:
  /// **'Nearest to you'**
  String get ordersSortNearest;

  /// No description provided for @ordersSortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest assigned'**
  String get ordersSortNewest;

  /// No description provided for @ordersSortOldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest assigned'**
  String get ordersSortOldest;

  /// No description provided for @ordersSortStatus.
  ///
  /// In en, this message translates to:
  /// **'By status'**
  String get ordersSortStatus;

  /// No description provided for @ordersApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get ordersApply;

  /// No description provided for @ordersOthersSorted.
  ///
  /// In en, this message translates to:
  /// **'Other orders · sorted by {sort, select, nearest{nearest to you} newest{newest assigned} oldest{oldest assigned} other{status}}'**
  String ordersOthersSorted(String sort);

  /// No description provided for @ordersAllSorted.
  ///
  /// In en, this message translates to:
  /// **'Orders · sorted by {sort, select, nearest{nearest to you} newest{newest assigned} oldest{oldest assigned} other{status}}'**
  String ordersAllSorted(String sort);

  /// No description provided for @ordersSearchResults.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 result} other{{count} results}} in {tab, select, current{current orders} other{past orders}}'**
  String ordersSearchResults(int count, String tab);

  /// No description provided for @ordersNoResultsTitle.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get ordersNoResultsTitle;

  /// No description provided for @ordersNoResultsMessage.
  ///
  /// In en, this message translates to:
  /// **'No order matches “{query}”. Check the order number or try the customer name'**
  String ordersNoResultsMessage(String query);

  /// No description provided for @ordersEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'ve finished today\'s orders'**
  String get ordersEmptyTitle;

  /// No description provided for @ordersEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'New orders assigned to you will show up here, and you\'ll get a notification'**
  String get ordersEmptyMessage;

  /// No description provided for @ordersShowPrevious.
  ///
  /// In en, this message translates to:
  /// **'View past orders'**
  String get ordersShowPrevious;

  /// No description provided for @ordersPreviousEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No past orders yet'**
  String get ordersPreviousEmptyTitle;

  /// No description provided for @ordersPreviousEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Orders you finish will show up here'**
  String get ordersPreviousEmptyMessage;

  /// No description provided for @ordersLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your orders'**
  String get ordersLoadError;

  /// No description provided for @ordersToday.
  ///
  /// In en, this message translates to:
  /// **'Today · {date}'**
  String ordersToday(String date);

  /// No description provided for @ordersYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday · {date}'**
  String ordersYesterday(String date);

  /// No description provided for @orderStatusWithCourier.
  ///
  /// In en, this message translates to:
  /// **'With courier'**
  String get orderStatusWithCourier;

  /// No description provided for @orderStatusOnTheWay.
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get orderStatusOnTheWay;

  /// No description provided for @orderStatusArrived.
  ///
  /// In en, this message translates to:
  /// **'Arrived'**
  String get orderStatusArrived;

  /// No description provided for @orderStatusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orderStatusDelivered;

  /// No description provided for @orderStatusNoAnswer.
  ///
  /// In en, this message translates to:
  /// **'No answer'**
  String get orderStatusNoAnswer;

  /// No description provided for @orderStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get orderStatusRejected;

  /// No description provided for @customerIndividual.
  ///
  /// In en, this message translates to:
  /// **'Individual'**
  String get customerIndividual;

  /// No description provided for @customerBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get customerBusiness;

  /// No description provided for @customerIndividualFull.
  ///
  /// In en, this message translates to:
  /// **'Individual (B2C)'**
  String get customerIndividualFull;

  /// No description provided for @customerBusinessFull.
  ///
  /// In en, this message translates to:
  /// **'Business (B2B)'**
  String get customerBusinessFull;

  /// No description provided for @orderItems.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String orderItems(int count);

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String distanceKm(String distance);

  /// No description provided for @orderAddress.
  ///
  /// In en, this message translates to:
  /// **'{district}, {city}'**
  String orderAddress(String district, String city);

  /// No description provided for @paymentCashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get paymentCashOnDelivery;

  /// No description provided for @paymentOnline.
  ///
  /// In en, this message translates to:
  /// **'Online payment'**
  String get paymentOnline;

  /// No description provided for @paymentPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paymentPaid;

  /// No description provided for @paymentCollectedCash.
  ///
  /// In en, this message translates to:
  /// **'Collected in cash'**
  String get paymentCollectedCash;

  /// No description provided for @paymentUnpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get paymentUnpaid;

  /// No description provided for @orderDeliveredAt.
  ///
  /// In en, this message translates to:
  /// **'Delivered {time}'**
  String orderDeliveredAt(String time);

  /// No description provided for @orderLastAttemptAt.
  ///
  /// In en, this message translates to:
  /// **'Last attempt {time}'**
  String orderLastAttemptAt(String time);

  /// No description provided for @orderRejectedAt.
  ///
  /// In en, this message translates to:
  /// **'Refused {time}'**
  String orderRejectedAt(String time);

  /// No description provided for @orderTimeAndDate.
  ///
  /// In en, this message translates to:
  /// **'{time} · {date}'**
  String orderTimeAndDate(String time, String date);

  /// No description provided for @ordersActiveKicker.
  ///
  /// In en, this message translates to:
  /// **'Your current order · out for delivery'**
  String get ordersActiveKicker;

  /// No description provided for @ordersActiveMeta.
  ///
  /// In en, this message translates to:
  /// **'{code} · {district} · {distance}'**
  String ordersActiveMeta(String code, String district, String distance);

  /// No description provided for @ordersCollect.
  ///
  /// In en, this message translates to:
  /// **'Collect'**
  String get ordersCollect;

  /// No description provided for @ordersContinueNavigation.
  ///
  /// In en, this message translates to:
  /// **'Continue navigation'**
  String get ordersContinueNavigation;

  /// No description provided for @callCustomer.
  ///
  /// In en, this message translates to:
  /// **'Call customer'**
  String get callCustomer;

  /// No description provided for @callFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t start the call'**
  String get callFailed;

  /// No description provided for @mapsFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open maps'**
  String get mapsFailed;

  /// No description provided for @orderDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Order details'**
  String get orderDetailsTitle;

  /// No description provided for @orderDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{code} · {name}'**
  String orderDetailsSubtitle(String code, String name);

  /// No description provided for @orderDetailsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load the order'**
  String get orderDetailsLoadError;

  /// No description provided for @orderInfo.
  ///
  /// In en, this message translates to:
  /// **'Order info'**
  String get orderInfo;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order number'**
  String get orderNumber;

  /// No description provided for @orderDateTime.
  ///
  /// In en, this message translates to:
  /// **'Order date & time'**
  String get orderDateTime;

  /// No description provided for @orderDeliveryDateTime.
  ///
  /// In en, this message translates to:
  /// **'Delivery date & time'**
  String get orderDeliveryDateTime;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order status'**
  String get orderStatus;

  /// No description provided for @orderCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer details'**
  String get orderCustomer;

  /// No description provided for @customerName.
  ///
  /// In en, this message translates to:
  /// **'Customer name'**
  String get customerName;

  /// No description provided for @customerType.
  ///
  /// In en, this message translates to:
  /// **'Customer type'**
  String get customerType;

  /// No description provided for @customerPhone.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get customerPhone;

  /// No description provided for @customerLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get customerLocation;

  /// No description provided for @customerMap.
  ///
  /// In en, this message translates to:
  /// **'Location map'**
  String get customerMap;

  /// No description provided for @openMap.
  ///
  /// In en, this message translates to:
  /// **'Open map'**
  String get openMap;

  /// No description provided for @nationalAddress.
  ///
  /// In en, this message translates to:
  /// **'National address'**
  String get nationalAddress;

  /// No description provided for @orderProducts.
  ///
  /// In en, this message translates to:
  /// **'Products ({count})'**
  String orderProducts(int count);

  /// No description provided for @productMeta.
  ///
  /// In en, this message translates to:
  /// **'{category} · Qty {quantity}'**
  String productMeta(String category, int quantity);

  /// No description provided for @productUnitPrice.
  ///
  /// In en, this message translates to:
  /// **'each'**
  String get productUnitPrice;

  /// No description provided for @showAllProducts.
  ///
  /// In en, this message translates to:
  /// **'Show all products ({count})'**
  String showAllProducts(int count);

  /// No description provided for @showFewerProducts.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showFewerProducts;

  /// No description provided for @orderPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get orderPayment;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @paymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment status'**
  String get paymentStatus;

  /// No description provided for @orderSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal ({items})'**
  String orderSubtotal(String items);

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery fee'**
  String get deliveryFee;

  /// No description provided for @totalToCollect.
  ///
  /// In en, this message translates to:
  /// **'Total to collect'**
  String get totalToCollect;

  /// No description provided for @totalCollected.
  ///
  /// In en, this message translates to:
  /// **'Amount collected'**
  String get totalCollected;

  /// No description provided for @orderTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get orderTotal;

  /// No description provided for @proofOfDelivery.
  ///
  /// In en, this message translates to:
  /// **'Proof of delivery'**
  String get proofOfDelivery;

  /// No description provided for @proofHomePhoto.
  ///
  /// In en, this message translates to:
  /// **'Home photo'**
  String get proofHomePhoto;

  /// No description provided for @proofOrderPhoto.
  ///
  /// In en, this message translates to:
  /// **'Order photo'**
  String get proofOrderPhoto;

  /// No description provided for @goToCustomer.
  ///
  /// In en, this message translates to:
  /// **'Go to customer'**
  String get goToCustomer;
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
