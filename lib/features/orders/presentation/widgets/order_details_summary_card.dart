import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_price.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_card.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_row.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_details_model.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';

/// Order summary (no title): subtotal, delivery fee and the total, labelled
/// "الإجمالي المطلوب تحصيله" while cash is due, "المبلغ المحصّل" once
/// collected, or "الإجمالي" when prepaid.
class OrderDetailsSummaryCard extends StatelessWidget {
  const OrderDetailsSummaryCard({required this.details, super.key});

  final OrderDetailsModel details;

  @override
  Widget build(BuildContext context) {
    final order = details.order;

    return AppInfoCard(
      rows: [
        AppInfoRow(
          label: context.localizations.orderSubtotal(
            context.localizations.orderItems(details.products.length),
          ),
          amount: details.subtotal,
        ),
        AppInfoRow(
          label: context.localizations.deliveryFee,
          amount: details.deliveryFee,
        ),
        Divider(height: 1, thickness: 1, color: context.colors.surfaceLine),
        Row(
          children: [
            Expanded(
              child: AppText(
                order.needsCollection
                    ? context.localizations.totalToCollect
                    : order.paymentMethod == PaymentMethod.cashOnDelivery
                    ? context.localizations.totalCollected
                    : context.localizations.orderTotal,
                style: context.typography.subtitleS,
                color: context.colors.textTitle,
              ),
            ),
            AppPrice(
              amount: order.total,
              showCents: true,
              style: context.typography.title3XS,
              color: context.colors.brandPrimary,
            ),
          ],
        ),
      ],
    );
  }
}
