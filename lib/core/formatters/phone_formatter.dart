/// Display formatting for Saudi mobile numbers.
abstract final class PhoneFormatter {
  static const countryCode = '+966';

  /// `501234567` → `+966 50 123 4567`. Other lengths are returned as
  /// `+966 <number>`.
  static String saudiDisplay(String nationalNumber) {
    final p = nationalNumber;
    if (p.length != 9) return '$countryCode $p';
    return '$countryCode ${p.substring(0, 2)} ${p.substring(2, 5)} '
        '${p.substring(5)}';
  }
}
