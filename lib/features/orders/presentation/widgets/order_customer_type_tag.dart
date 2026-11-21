import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/order_model.dart';

/// Outlined "أفراد" / "شركات" tag next to the order number (Figma
/// `Courier/Order Card` › "Customer Type").
class OrderCustomerTypeTag extends StatelessWidget {
  const OrderCustomerTypeTag({required this.type, super.key});

  final CustomerType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.only(start: 12, end: 12, top: 3, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: AppRadius.rfull,
        border: Border.all(color: context.colors.surfaceStroke),
      ),
      child: AppText(
        switch (type) {
          CustomerType.individual => context.localizations.customerIndividual,
          CustomerType.business => context.localizations.customerBusiness,
        },
        style: context.typography.bodyXS,
        color: context.colors.textSubTitle,
      ),
    );
  }
}
