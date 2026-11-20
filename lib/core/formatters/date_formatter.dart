import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  /// en: Sep 12, 2025 | ar: ١٢ سبتمبر ٢٠٢٥
  static String formatDate(DateTime date) => DateFormat.yMMMd().format(date);

  /// en: Sep 12, 2025 12:00 PM | ar: ١٢ سبتمبر ٢٠٢٥ ١٢:٠٠ م
  static String formatDateWithTime(DateTime date) =>
      DateFormat.yMMMd().add_jm().format(date);

  /// en: Sep 12, 2025 12:00:00 PM | ar: ١٢ سبتمبر ٢٠٢٥ ١٢:٠٠:٠٠ م
  static String formatDateWithTimeAndSeconds(DateTime date) =>
      DateFormat.yMMMd().add_jms().format(date);

  /// en: Sunday · 15 November | ar: الأحد · 15 نوفمبر
  ///
  /// Western digits in both languages, as in the design.
  static String formatDayAndDate(DateTime date) =>
      (DateFormat('EEEE · d MMMM')..useNativeDigits = false).format(date);

  /// en: 8:42 AM | ar: 8:42 ص (Western digits in both languages).
  static String formatTime(DateTime date) =>
      (DateFormat.jm()..useNativeDigits = false).format(date);
}
