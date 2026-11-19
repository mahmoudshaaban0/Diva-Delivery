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
}
