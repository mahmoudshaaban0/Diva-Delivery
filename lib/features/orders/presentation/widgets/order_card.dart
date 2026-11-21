import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_price.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/formatters/amount_formatter.dart';
import 'package:limitless_code_template/core/formatters/date_formatter.dart';
import 'package:limitless_code_template/core/formatters/ltr_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_customer_type_tag.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_meta_item.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_status_chip.dart';

/// An order in the list (Figma `Courier/Order Card`).
///
/// - Current orders show the distance, the address and the assignment time.
/// - Past orders show the address and when they were delivered, attempted
///   or refused (calendar icon).
class OrderCard extends StatelessWidget {
  const OrderCard({required this.order, required this.onTap, super.key});

  final OrderModel order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final assignedToday = DateUtils.isSameDay(order.assignedAt, now);
    final closedTime = DateFormatter.formatTime(
      order.closedAt ?? order.assignedAt,
    );
    final distance = order.distanceKm;

    return Material(
      color: context.colors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.r20,
        side: BorderSide(color: context.colors.surfaceStroke),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.h,
                children: [
                  Row(
                    spacing: 4.w,
                    children: [
                      Expanded(
                        child: Row(
                          spacing: 4.w,
                          children: [
                            AppText(
                              LtrFormatter.code(order.code),
                              style: context.typography.subtitleS,
                              color: context.colors.textTitle,
                            ),
                            OrderCustomerTypeTag(type: order.customerType),
                          ],
                        ),
                      ),
                      OrderStatusChip(status: order.status),
                    ],
                  ),
                  AppText(
                    order.customerName,
                    color: context.colors.textSubTitle,
                    maxLines: 1,
                  ),
                ],
              ),
              Wrap(
                spacing: 12.w,
                runSpacing: 4.h,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (order.status.isCurrent && distance != null)
                    OrderMetaItem(
                      iconAsset: Assets.vectorsIcNavigation16,
                      text: context.localizations.distanceKm(
                        AmountFormatter.oneDecimal(distance),
                      ),
                      highlighted: true,
                    ),
                  OrderMetaItem(
                    iconAsset: Assets.vectorsIcLocation16,
                    text: context.localizations.orderAddress(
                      order.district,
                      order.city,
                    ),
                  ),
                  if (order.status.isCurrent)
                    OrderMetaItem(
                      iconAsset: Assets.vectorsIcClock16,
                      text: assignedToday
                          ? DateFormatter.formatTime(order.assignedAt)
                          : context.localizations.orderTimeAndDate(
                              DateFormatter.formatTime(order.assignedAt),
                              DateFormatter.formatDayMonth(order.assignedAt),
                            ),
                    )
                  else
                    OrderMetaItem(
                      iconAsset: Assets.vectorsIcCalendar16,
                      text: switch (order.status) {
                        OrderStatus.noAnswer =>
                          context.localizations.orderLastAttemptAt(closedTime),
                        OrderStatus.rejected =>
                          context.localizations.orderRejectedAt(closedTime),
                        _ => context.localizations.orderDeliveredAt(closedTime),
                      },
                    ),
                ],
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: context.colors.surfaceLine,
              ),
              Row(
                spacing: 8.w,
                children: [
                  Expanded(
                    child: Row(
                      spacing: 8.w,
                      children: [
                        AppSvgIcon(
                          Assets.vectorsIcWallet16,
                          size: 16,
                          color: context.colors.textCaption,
                        ),
                        AppPrice(
                          amount: order.total,
                          showCents: true,
                          style: context.typography.subtitleM,
                        ),
                        Flexible(
                          child: AppText(
                            order.paymentMethod == PaymentMethod.prepaid
                                ? context.localizations.paymentPaid
                                : order.isPaid
                                ? context.localizations.paymentCollectedCash
                                : context.localizations.paymentCashOnDelivery,
                            style: context.typography.bodyXS,
                            color: context.colors.textCaption,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4.w,
                    children: [
                      AppText(
                        context.localizations.orderItems(order.itemsCount),
                        style: context.typography.bodyS,
                        color: context.colors.textSubTitle,
                      ),
                      AppSvgIcon(
                        Assets.vectorsIcArrowLeft14,
                        size: 14,
                        flipInLtr: true,
                        color: context.colors.textCaption,
                      ),
                    ],
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
