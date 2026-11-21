import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/formatters/date_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// "اليوم", "أمس" or the date above a day of notifications.
class NotificationsDayLabel extends StatelessWidget {
  const NotificationsDayLabel({required this.day, super.key});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return AppText(
      DateUtils.isSameDay(day, now)
          ? context.localizations.notificationsToday
          : DateUtils.isSameDay(day, now.subtract(const Duration(days: 1)))
          ? context.localizations.notificationsYesterday
          : DateFormatter.formatDayMonth(day),
      style: context.typography.subtitleS,
      color: context.colors.textCaption,
    );
  }
}
