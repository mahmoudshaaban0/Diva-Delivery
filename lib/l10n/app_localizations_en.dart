// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Limitless Code';

  @override
  String get hello => 'Hello';

  @override
  String welcomeUser(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get arabic => 'arabic';

  @override
  String get splashTagline => 'Every delivery in its right place';

  @override
  String splashFooter(String version) {
    return 'Expert Partners · Version $version';
  }

  @override
  String get contactSupport => 'Contact support';

  @override
  String get loginWelcome => 'Welcome, Captain';

  @override
  String get loginSubtitle => 'Sign in to start your delivery day';

  @override
  String get mobileNumber => 'Mobile number';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get phoneHint => '5X XXX XXXX';

  @override
  String get emailHint => 'name@company.com';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get phoneInvalid => 'Enter a valid mobile number starting with 5';

  @override
  String get emailInvalid => 'Enter a valid email address';

  @override
  String get passwordRequired => 'Enter your password';

  @override
  String get secureConnection =>
      'Secure, encrypted connection · Your data is protected';

  @override
  String get sendOtp => 'Send verification code';

  @override
  String get signIn => 'Sign in';

  @override
  String get termsNotice =>
      'By continuing you agree to the Terms and Privacy Policy';

  @override
  String get otpTitle => 'Verify mobile';

  @override
  String get otpHeading => 'Enter verification code';

  @override
  String get otpHeadingError => 'Incorrect code';

  @override
  String otpSentTo(int length) {
    return 'We sent a $length-digit code to';
  }

  @override
  String get resendIn => 'Resend in';

  @override
  String get otpNotReceived => 'Didn\'t get the code?';

  @override
  String get otpResend => 'Resend code';

  @override
  String get otpVerify => 'Verify and continue';

  @override
  String get otpVerifyAgain => 'Verify again';

  @override
  String otpInvalidAttempts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attempts left',
      one: '1 attempt left',
      zero: 'no attempts left',
    );
    return 'The code expired or was entered incorrectly — $_temp0';
  }

  @override
  String get otpInvalid => 'The code expired or was entered incorrectly';

  @override
  String get forgotPasswordTitle => 'Reset password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your registered email and we\'ll send you a link to set a new password.';

  @override
  String get sendLink => 'Send link';

  @override
  String get checkYourEmail => 'Check your email';

  @override
  String resetLinkSentTo(String email, int minutes) {
    return 'We sent a reset link to $email. The link is valid for $minutes minutes.';
  }

  @override
  String get backToSignIn => 'Back to sign in';

  @override
  String get linkNotReceived => 'Didn\'t get the link?';

  @override
  String get resendLink => 'Resend link';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get retry => 'Retry';

  @override
  String stepOf(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get locationPermissionTitle => 'Turn on location access';

  @override
  String get locationPermissionSubtitle =>
      'We need your location to start the day and guide you to customers accurately';

  @override
  String get locationBenefitWarehouseTitle => 'Start the day at the warehouse';

  @override
  String get locationBenefitWarehouseSubtitle =>
      'We check you\'re inside the warehouse zone when you start';

  @override
  String get locationBenefitRouteTitle => 'Best delivery route';

  @override
  String get locationBenefitRouteSubtitle =>
      'Orders sorted by the nearest customer';

  @override
  String get locationBenefitTrackingTitle => 'Live trip tracking';

  @override
  String get locationBenefitTrackingSubtitle =>
      'Order status updates automatically for the operations team';

  @override
  String get locationAlwaysNote =>
      'Next we\'ll ask for “Allow all the time” to track the trip while the screen is locked';

  @override
  String get allowLocationAccess => 'Allow location access';

  @override
  String get locationDeniedTitle => 'Location is required to start work';

  @override
  String get locationDeniedSubtitle =>
      'Without location access you can\'t start your day or get directions to customers';

  @override
  String get locationDeniedStepSettingsTitle => 'Open device settings';

  @override
  String get locationDeniedStepSettingsSubtitle =>
      'Using the “Open settings” button below';

  @override
  String get locationDeniedStepAppTitle => 'Location → Diva Courier';

  @override
  String get locationDeniedStepAppSubtitle =>
      'Choose the app from the apps list';

  @override
  String get locationDeniedStepAlwaysTitle => 'Choose “Always”';

  @override
  String get locationDeniedStepAlwaysSubtitle =>
      'To track the trip while the screen is locked';

  @override
  String get locationPrivacyNote =>
      'We only use your location during working hours and never share it with customers';

  @override
  String get openSettings => 'Open settings';

  @override
  String get tryAgain => 'Try again';

  @override
  String get cameraPermissionTitle => 'Camera & photos';

  @override
  String get cameraPermissionSubtitle =>
      'To document deliveries quickly without leaving the app';

  @override
  String get cameraBenefitProofTitle => 'Proof-of-delivery photo';

  @override
  String get cameraBenefitProofSubtitle =>
      'Take a photo of the order at the customer\'s door';

  @override
  String get cameraBenefitCallLogTitle => 'Call log screenshot';

  @override
  String get cameraBenefitCallLogSubtitle =>
      'Upload a screenshot when you can\'t reach the customer';

  @override
  String get allowAccess => 'Allow access';

  @override
  String get later => 'Later';

  @override
  String get homeDayNotStarted => 'You haven\'t started your day yet';

  @override
  String get homeDayStarted => 'Your day has started, good luck';

  @override
  String homeDayStartedAt(String time) {
    return 'Day started · $time';
  }

  @override
  String get homeTotalCollected => 'Total collected';

  @override
  String get homeTotalOrders => 'Total orders';

  @override
  String get orderStatusCancelled => 'Cancelled';

  @override
  String get orderStatusCompleted => 'Completed';

  @override
  String get orderStatusNew => 'New';

  @override
  String get orderStatusWithCaptain => 'With captain';

  @override
  String get homeAnnouncements => 'Management announcements';

  @override
  String countOf(int current, int total) {
    return '$current of $total';
  }

  @override
  String get inRange => 'In range';

  @override
  String get outOfRange => 'Out of range';

  @override
  String get swipeToStartDay => 'Swipe to start the day';

  @override
  String get checkingLocation => 'Checking your location…';

  @override
  String get noOrdersToStartDay => 'No orders to start the day';

  @override
  String get noOrdersHint =>
      'We\'ll notify you as soon as new orders are assigned to you';

  @override
  String get deliveredToday => 'Delivered today';

  @override
  String get viewOrders => 'View orders';

  @override
  String get outOfRangeTitle => 'You\'re outside the warehouse zone';

  @override
  String outOfRangeSubtitle(String warehouse) {
    return 'Get closer to “$warehouse” and try again to start your day';
  }

  @override
  String distanceFromWarehouse(String distance) {
    return '$distance km from the warehouse';
  }

  @override
  String get youAreHere => 'You are here';

  @override
  String get openDirections => 'Open directions';

  @override
  String get dayStartedTitle => 'Your day has started';

  @override
  String dayStartedSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'You received $count orders and they\'re all “with the captain”. Good luck!',
      one: 'You received 1 order and it\'s now “with the captain”. Good luck!',
    );
    return '$_temp0';
  }

  @override
  String get summaryWarehouse => 'Warehouse';

  @override
  String get summaryStartTime => 'Start time';

  @override
  String get summaryOrders => 'Orders';

  @override
  String ordersWithCaptain(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count orders · with captain',
      one: '1 order · with captain',
    );
    return '$_temp0';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navOrders => 'Orders';

  @override
  String get navProfile => 'Profile';

  @override
  String get notifications => 'Notifications';

  @override
  String get locationUnavailable =>
      'Couldn\'t get your location. Make sure location is on and try again.';

  @override
  String get homeLoadError => 'Couldn\'t load your day';

  @override
  String get comingSoon => 'Coming soon';
}
