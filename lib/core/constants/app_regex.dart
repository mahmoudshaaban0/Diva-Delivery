/// Shared regular expressions. Keep every app regex here instead of inside
/// widgets or formatters.
abstract final class AppRegex {
  /// Saudi mobile national number: 9 digits starting with 5 (5XXXXXXXX).
  static final saudiMobile = RegExp(r'^5\d{8}$');

  /// Basic email shape: `name@domain.tld`.
  static final email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// A 4-digit verification code inside an SMS (used for SMS autofill).
  static final otpCode = RegExp(r'\d{4}');

  /// Arabic-Indic (٠-٩) and Extended Arabic-Indic (۰-۹) digits.
  static final easternDigits = RegExp('[٠-٩۰-۹]');
}
