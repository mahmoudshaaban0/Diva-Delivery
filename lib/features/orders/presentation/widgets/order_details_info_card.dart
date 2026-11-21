import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_tone_icon.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_card.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_row.dart';
import 'package:limitless_code_template/core/formatters/date_formatter.dart';
import 'package:limitless_code_template/core/formatters/ltr_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_status_chip.dart';

/// "معلومات الطلب": number (copyable), order time, delivery time (delivered
/// orders) and the status chip.
class OrderDetailsInfoCard extends StatelessWidget {
  const OrderDetailsInfoCard({
    required this.order,
    required this.onCopyCode,
    super.key,
  });

  final OrderModel order;
  final VoidCallback onCopyCode;

  @override
  Widget build(BuildContext context) {
    final closedAt = order.closedAt;

    return AppInfoCard(
      title: context.localizations.orderInfo,
      icon: const AppToneIcon(
        iconAsset: Assets.vectorsIcInformationCircle16,
        tone: AppTone.blue,
      ),
      rows: [
        AppInfoRow(
          label: context.localizations.orderNumber,
          value: LtrFormatter.code(order.code),
          onCopy: onCopyCode,
        ),
        AppInfoRow(
          label: context.localizations.orderDateTime,
          value: DateFormatter.formatFullDateAndTime(order.assignedAt),
        ),
        if (order.status == OrderStatus.delivered && closedAt != null)
          AppInfoRow(
            label: context.localizations.orderDeliveryDateTime,
            value: DateFormatter.formatFullDateAndTime(closedAt),
          ),
        AppInfoRow(
          label: context.localizations.orderStatus,
          trailing: OrderStatusChip(status: order.status),
        ),
      ],
    );
  }
}
