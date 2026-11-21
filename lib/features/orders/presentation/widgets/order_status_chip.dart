import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_tone_icon.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_status_chip.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';

/// `AppStatusChip` for an [OrderStatus]: neutral "مع الكابتن", blue "في
/// الطريق" / "تم الوصول", green "تم التسليم", yellow "لم يتم الرد", red
/// "مرفوض".
class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({required this.status, this.pulse = false, super.key});

  final OrderStatus status;

  /// For the pinned order being delivered now.
  final bool pulse;

  @override
  Widget build(BuildContext context) {
    return AppStatusChip(
      pulse: pulse,
      label: switch (status) {
        OrderStatus.withCourier => context.localizations.orderStatusWithCourier,
        OrderStatus.onTheWay => context.localizations.orderStatusOnTheWay,
        OrderStatus.arrived => context.localizations.orderStatusArrived,
        OrderStatus.delivered => context.localizations.orderStatusDelivered,
        OrderStatus.noAnswer => context.localizations.orderStatusNoAnswer,
        OrderStatus.rejected => context.localizations.orderStatusRejected,
      },
      tone: switch (status) {
        OrderStatus.withCourier => AppTone.neutral,
        OrderStatus.onTheWay || OrderStatus.arrived => AppTone.blue,
        OrderStatus.delivered => AppTone.green,
        OrderStatus.noAnswer => AppTone.yellow,
        OrderStatus.rejected => AppTone.red,
      },
    );
  }
}
