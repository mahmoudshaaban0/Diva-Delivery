import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_segmented_control.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/data/models/orders_response_model.dart';

/// "الحالية (18)" · "السابقة" switch under the header.
class OrdersTabs extends StatelessWidget {
  const OrdersTabs({
    required this.selected,
    required this.currentCount,
    required this.onChanged,
    super.key,
  });

  final OrdersScope selected;

  /// Shown in the "الحالية" label; 0 while loading.
  final int currentCount;
  final ValueChanged<OrdersScope> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppSegmentedControl<OrdersScope>(
      selected: selected,
      onChanged: onChanged,
      segments: [
        AppSegment(
          value: OrdersScope.current,
          label: context.localizations.ordersTabCurrent(currentCount),
          iconAsset: Assets.vectorsIcPackage18,
        ),
        AppSegment(
          value: OrdersScope.previous,
          label: context.localizations.ordersTabPrevious,
          iconAsset: Assets.vectorsIcClock18,
        ),
      ],
    );
  }
}
