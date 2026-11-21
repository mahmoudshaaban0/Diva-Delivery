import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_circle_icon_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_price.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/formatters/amount_formatter.dart';
import 'package:limitless_code_template/core/formatters/ltr_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_status_chip.dart';

/// The order being delivered now, pinned above the list (Figma
/// `Courier/Next Order Card`): who, where, the cash to collect, and direct
/// actions ("متابعة الملاحة" · call).
class OrdersActiveCard extends StatelessWidget {
  const OrdersActiveCard({
    required this.order,
    required this.onTap,
    required this.onNavigate,
    required this.onCall,
    super.key,
  });

  final OrderModel order;

  /// Opens the order details.
  final VoidCallback onTap;
  final VoidCallback onNavigate;
  final VoidCallback onCall;

  @override
  Widget build(BuildContext context) {
    final distance = order.distanceKm;

    return Material(
      // `brandPrimary` turns light in dark mode, which would wash out the
      // always-white text, so dark mode uses the card surface instead.
      color: context.isDarkMode
          ? context.colors.surfaceCard
          : context.colors.brandPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.r24,
        side: context.isDarkMode
            ? BorderSide(color: context.colors.surfaceStroke)
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: AppInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12.h,
            children: [
              Row(
                spacing: 8.w,
                children: [
                  Expanded(
                    child: Row(
                      spacing: 4.w,
                      children: [
                        AppSvgIcon(
                          Assets.vectorsIcNavigation16,
                          size: 16,
                          color: context.colors.textAlwaysWhite,
                        ),
                        Expanded(
                          child: AppText(
                            context.localizations.ordersActiveKicker,
                            style: context.typography.subtitleXS,
                            color: context.colors.textAlwaysWhite,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OrderStatusChip(status: order.status, pulse: true),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.h,
                children: [
                  AppText(
                    order.customerName,
                    style: context.typography.title3XS,
                    color: context.colors.textAlwaysWhite,
                    maxLines: 1,
                  ),
                  AppText(
                    context.localizations.ordersActiveMeta(
                      LtrFormatter.code(order.code),
                      order.district,
                      distance == null
                          ? ''
                          : context.localizations.distanceKm(
                              AmountFormatter.oneDecimal(distance),
                            ),
                    ),
                    style: context.typography.bodyS,
                    color: context.colors.textAlwaysWhiteMeta,
                    maxLines: 1,
                  ),
                ],
              ),
              if (order.needsCollection)
                Container(
                  padding: AppInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: context.colors.systemYellowBg,
                    borderRadius: AppRadius.rfull,
                  ),
                  child: Row(
                    spacing: 4.w,
                    children: [
                      Expanded(
                        child: AppText(
                          context.localizations.ordersCollect,
                          style: context.typography.subtitleS,
                          color: context.colors.textTitle,
                        ),
                      ),
                      AppPrice(
                        amount: order.total,
                        showCents: true,
                        style: context.typography.subtitleS,
                      ),
                    ],
                  ),
                ),
              Row(
                spacing: 8.w,
                children: [
                  Expanded(
                    child: AppFilledButton(
                      variant: AppFilledVariant.neutral,
                      onPressed: onNavigate,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4.w,
                        children: [
                          AppSvgIcon(
                            Assets.vectorsIcNavigation22,
                            size: 22,
                            color: context.colors.buttonNeutral.label,
                          ),
                          Flexible(
                            child: AppText(
                              context.localizations.ordersContinueNavigation,
                              style: context.typography.subtitleM.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                              color: context.colors.buttonNeutral.label,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppCircleIconButton(
                    tooltip: context.localizations.callCustomer,
                    onPressed: onCall,
                    icon: AppSvgIcon(
                      Assets.vectorsIcCall22,
                      size: 22,
                      color: context.colors.textTitle,
                    ),
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
