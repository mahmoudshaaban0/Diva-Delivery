import 'package:intl/intl.dart';

/// Money and counts with Western digits and a thousands separator in both
/// languages, as in the design.
abstract final class AmountFormatter {
  static final _decimal = NumberFormat.decimalPattern('en');

  /// 8450 → 8,450 · 12.5 → 12.5
  static String format(num value) => _decimal.format(value);

  /// 1280 → 1,280.00 (money with cents, as in the order cards).
  static String money(num value) =>
      NumberFormat('#,##0.00', 'en').format(value);

  /// 2.37 → 2.4 (one decimal, for distances in km).
  static String oneDecimal(num value) =>
      NumberFormat('0.0', 'en').format(value);
}
