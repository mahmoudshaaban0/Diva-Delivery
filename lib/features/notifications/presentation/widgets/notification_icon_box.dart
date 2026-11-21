import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/notifications/data/models/notification_model.dart';

/// The 40-px tinted icon square of a notification: blue for orders, yellow
/// for schedule changes, green for collection, red for alerts.
///
/// Fixed component size, not scaled.
class NotificationIconBox extends StatelessWidget {
  const NotificationIconBox({required this.type, super.key});

  final NotificationType type;

  @override
  Widget build(BuildContext context) {
    final (icon, background, foreground) = switch (type) {
      NotificationType.newOrder => (
        Assets.vectorsIcPackage20,
        context.colors.systemBlueBg,
        context.colors.textTitle,
      ),
      NotificationType.addressChanged => (
        Assets.vectorsIcLocation20,
        context.colors.systemBlueBg,
        context.colors.textTitle,
      ),
      NotificationType.rescheduled => (
        Assets.vectorsIcCalendar20,
        context.colors.systemYellowBg,
        context.colors.systemYellowText,
      ),
      NotificationType.orderClosed => (
        Assets.vectorsIcWallet20,
        context.colors.systemGreenBg,
        context.colors.systemGreenText,
      ),
      NotificationType.dayEnded => (
        Assets.vectorsIcTick20,
        context.colors.systemGreenBg,
        context.colors.systemGreenText,
      ),
      NotificationType.cashReminder => (
        Assets.vectorsIcInformationCircle20,
        context.colors.systemRedBg,
        context.colors.systemRedText,
      ),
    };

    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, borderRadius: AppRadius.r12),
      child: AppSvgIcon(icon, size: 20, color: foreground),
    );
  }
}
