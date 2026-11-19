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
}
