import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_tone_icon.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_card.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_row.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';

/// "الدفع": method and status. Yellow while cash is still to collect
/// ("غير مدفوع"), green once paid ("مدفوع" / "تم التحصيل نقدًا").
class OrderDetailsPaymentCard extends StatelessWidget {
  const OrderDetailsPaymentCard({required this.order, super.key});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final toCollect = order.needsCollection;

    return AppInfoCard(
      title: context.localizations.orderPayment,
      icon: AppToneIcon(
        iconAsset: Assets.vectorsIcWallet16,
        tone: toCollect ? AppTone.yellow : AppTone.green,
      ),
      rows: [
        AppInfoRow(
          label: context.localizations.paymentMethod,
          value: switch (order.paymentMethod) {
            PaymentMethod.cashOnDelivery =>
              context.localizations.paymentCashOnDelivery,
            PaymentMethod.prepaid => context.localizations.paymentOnline,
          },
        ),
        AppInfoRow(
          label: context.localizations.paymentStatus,
          value: toCollect
              ? context.localizations.paymentUnpaid
              : order.paymentMethod == PaymentMethod.prepaid
              ? context.localizations.paymentPaid
              : context.localizations.paymentCollectedCash,
          valueColor: toCollect
              ? context.colors.systemYellowText
              : context.colors.systemGreenText,
        ),
      ],
    );
  }
}
