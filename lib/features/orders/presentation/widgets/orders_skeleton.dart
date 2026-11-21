import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/features/orders/presentation/widgets/order_card_skeleton.dart';

/// Loading placeholder for the orders list (Figma Flow 08 "جارٍ التحميل –
/// الطلبات"): four order-card skeletons that fade out down the list.
class OrdersSkeleton extends StatelessWidget {
  const OrdersSkeleton({super.key});

  /// Figma opacities, top to bottom.
  static const _opacities = [1.0, 0.82, 0.64, 0.46];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: AppInsets.only(start: 20, end: 20, top: 16, bottom: 24),
      child: Column(
        spacing: 16.h,
        children: [
          for (final opacity in _opacities)
            Opacity(opacity: opacity, child: const OrderCardSkeleton()),
        ],
      ),
    );
  }
}
