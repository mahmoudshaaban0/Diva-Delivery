import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_price.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_vertical_divider.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/formatters/amount_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_total.dart';

/// Total orders and total collected (Figma "Totals").
class HomeTotalsCard extends StatelessWidget {
  const HomeTotalsCard({
    required this.totalOrders,
    required this.totalCollected,
    super.key,
  });

  final int totalOrders;
  final num totalCollected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.buttonNeutral.soft,
        borderRadius: AppRadius.r16,
      ),
      child: Row(
        spacing: 16.w,
        children: [
          Expanded(
            child: HomeTotal(
              iconAsset: Assets.vectorsIcPackage16,
              label: context.localizations.homeTotalOrders,
              value: AppText(
                AmountFormatter.format(totalOrders),
                style: context.typography.titleS,
              ),
            ),
          ),
          const AppVerticalDivider(height: 40),
          Expanded(
            child: HomeTotal(
              iconAsset: Assets.vectorsIcWallet16,
              label: context.localizations.homeTotalCollected,
              value: AppPrice(amount: totalCollected),
            ),
          ),
        ],
      ),
    );
  }
}
