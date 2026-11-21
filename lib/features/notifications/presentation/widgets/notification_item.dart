import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_dot.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/formatters/date_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/notifications/data/models/notification_model.dart';
import 'package:limitless_code_template/features/notifications/presentation/widgets/notification_icon_box.dart';

/// A notification row (Figma `Courier/Notification Item`): icon box, title,
/// text, the time and, while unread, a dot in the item's tone.
///
/// The time reads "الآن" / "قبل 5 د" within the hour, the clock time later
/// today, "أمس", or the date.
class NotificationItem extends StatelessWidget {
  const NotificationItem({
    required this.notification,
    required this.onTap,
    super.key,
  });

  final NotificationModel notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final at = notification.createdAt;
    final minutes = now.difference(at).inMinutes;

    return Material(
      color: context.colors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.r16,
        side: BorderSide(color: context.colors.surfaceStroke),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: AppInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.w,
            children: [
              NotificationIconBox(type: notification.type),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    AppText(
                      notification.title,
                      style: context.typography.subtitleS,
                      color: context.colors.textTitle,
                    ),
                    AppText(
                      notification.body,
                      style: context.typography.bodyS,
                      color: context.colors.textSubTitle,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 8.h,
                children: [
                  AppText(
                    minutes < 1
                        ? context.localizations.timeNow
                        : minutes < 60
                        ? context.localizations.minutesAgo(minutes)
                        : DateUtils.isSameDay(at, now)
                        ? DateFormatter.formatTime(at)
                        : DateUtils.isSameDay(
                            at,
                            now.subtract(const Duration(days: 1)),
                          )
                        ? context.localizations.notificationsYesterday
                        : DateFormatter.formatDayMonth(at),
                    style: context.typography.bodyXS,
                    color: context.colors.textCaption,
                  ),
                  if (!notification.isRead)
                    AppDot(
                      color: switch (notification.type.category) {
                        NotificationCategory.orders =>
                          notification.type == NotificationType.rescheduled
                              ? context.colors.systemYellow
                              : context.colors.systemBlue,
                        NotificationCategory.collection =>
                          context.colors.systemGreen,
                        NotificationCategory.alerts => context.colors.systemRed,
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
