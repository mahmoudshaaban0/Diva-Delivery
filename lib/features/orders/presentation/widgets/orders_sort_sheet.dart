import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_radio_row.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/orders/presentation/bloc/orders_state.dart';

/// "ترتيب الطلبات" sheet (Figma "الطلبات – ترتيب"). Pops with the picked
/// [OrdersSort] on "تطبيق"; dismissing it changes nothing.
///
/// Show it with `showAppBottomSheet(size: AppSheetSize.wrap, child: ...)`.
class OrdersSortSheet extends StatefulWidget {
  const OrdersSortSheet({required this.initial, super.key});

  final OrdersSort initial;

  @override
  State<OrdersSortSheet> createState() => _OrdersSortSheetState();
}

class _OrdersSortSheetState extends State<OrdersSortSheet> {
  late OrdersSort _selected = widget.initial;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Bottom: the home-indicator safe area (unscaled), like the design.
      padding: AppInsets.symmetric(horizontal: 20)
          .copyWith(bottom: MediaQuery.paddingOf(context).bottom + 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16.h,
        children: [
          AppText(
            context.localizations.ordersSortTitle,
            style: context.typography.titleM,
            textAlign: TextAlign.center,
          ),
          Column(
            spacing: 8.h,
            children: [
              for (final sort in OrdersSort.values)
                AppRadioRow(
                  label: switch (sort) {
                    OrdersSort.nearest =>
                      context.localizations.ordersSortNearest,
                    OrdersSort.newest => context.localizations.ordersSortNewest,
                    OrdersSort.oldest => context.localizations.ordersSortOldest,
                    OrdersSort.status => context.localizations.ordersSortStatus,
                  },
                  selected: _selected == sort,
                  onTap: () => setState(() => _selected = sort),
                ),
            ],
          ),
          AppFilledButton(
            onPressed: () => Navigator.of(context).pop(_selected),
            child: AppText(
              context.localizations.ordersApply,
              style: context.typography.subtitleM.copyWith(
                fontWeight: FontWeight.w700,
              ),
              color: context.colors.buttonPrimary.label,
            ),
          ),
        ],
      ),
    );
  }
}
