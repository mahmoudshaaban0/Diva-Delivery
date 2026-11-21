import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_tone_icon.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_card.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_info_row.dart';
import 'package:limitless_code_template/core/formatters/ltr_formatter.dart';
import 'package:limitless_code_template/core/formatters/phone_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';

/// "بيانات العميل": name, type, mobile, area, and the "فتح الخريطة" /
/// national-address links.
class OrderDetailsCustomerCard extends StatelessWidget {
  const OrderDetailsCustomerCard({
    required this.order,
    required this.onOpenMap,
    required this.onCopyNationalAddress,
    this.nationalAddress,
    super.key,
  });

  final OrderModel order;
  final String? nationalAddress;
  final VoidCallback onOpenMap;
  final VoidCallback onCopyNationalAddress;

  @override
  Widget build(BuildContext context) {
    final address = nationalAddress;

    return AppInfoCard(
      title: context.localizations.orderCustomer,
      icon: const AppToneIcon(
        iconAsset: Assets.vectorsIcLocation16,
        tone: AppTone.blue,
      ),
      rows: [
        AppInfoRow(
          label: context.localizations.customerName,
          value: order.customerName,
        ),
        AppInfoRow(
          label: context.localizations.customerType,
          value: switch (order.customerType) {
            CustomerType.individual =>
              context.localizations.customerIndividualFull,
            CustomerType.business => context.localizations.customerBusinessFull,
          },
        ),
        AppInfoRow(
          label: context.localizations.customerPhone,
          value: LtrFormatter.isolate(PhoneFormatter.saudiDisplay(order.phone)),
        ),
        AppInfoRow(
          label: context.localizations.customerLocation,
          value: context.localizations.orderAddress(order.district, order.city),
        ),
        AppInfoRow(
          label: context.localizations.customerMap,
          value: context.localizations.openMap,
          onTap: onOpenMap,
        ),
        if (address != null)
          AppInfoRow(
            label: context.localizations.nationalAddress,
            value: LtrFormatter.isolate(address),
            onTap: onCopyNationalAddress,
          ),
      ],
    );
  }
}
