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

  /// en: Sunday 15 November | ar: الأحد 15 نوفمبر (Western digits).
  static String formatWeekdayDayMonth(DateTime date) =>
      (DateFormat('EEEE d MMMM')..useNativeDigits = false).format(date);

  /// en: March 2025 | ar: مارس 2025 (Western digits in both languages).
  static String formatMonthYear(DateTime date) =>
      (DateFormat('MMMM y')..useNativeDigits = false).format(date);

  /// en: 8:42 AM | ar: 8:42 ص (Western digits in both languages).
  static String formatTime(DateTime date) =>
      (DateFormat.jm()..useNativeDigits = false).format(date);

  /// en: 14 November | ar: 14 نوفمبر (Western digits in both languages).
  static String formatDayMonth(DateTime date) =>
      (DateFormat('d MMMM')..useNativeDigits = false).format(date);

  /// en: 15 November 2026 · 8:30 AM | ar: 15 نوفمبر 2026 · 8:30 ص
  /// (Western digits in both languages).
  static String formatFullDateAndTime(DateTime date) =>
      '${(DateFormat('d MMMM y')..useNativeDigits = false).format(date)}'
      ' · ${formatTime(date)}';
}
