import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/formatters/date_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/orders_section_label.dart';

/// Title of a day of past orders: "اليوم · 15 نوفمبر", "أمس · 14 نوفمبر",
/// or just "13 نوفمبر".
class OrdersDayLabel extends StatelessWidget {
  const OrdersDayLabel({required this.day, super.key});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final date = DateFormatter.formatDayMonth(day);

    return OrdersSectionLabel(
      DateUtils.isSameDay(day, now)
          ? context.localizations.ordersToday(date)
          : DateUtils.isSameDay(day, now.subtract(const Duration(days: 1)))
          ? context.localizations.ordersYesterday(date)
          : date,
    );
  }
}
