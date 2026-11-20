import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_dot.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/formatters/amount_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_orders_status_card.dart'
    show HomeOrdersStatusCard;

/// One centered count with its status dot, in [HomeOrdersStatusCard].
class HomeOrderStat extends StatelessWidget {
  const HomeOrderStat({
    required this.label,
    required this.dotColor,
    required this.count,
    super.key,
  });

  final String label;
  final Color dotColor;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.w,
          children: [
            AppDot(color: dotColor),
            Flexible(
              child: AppText(
                label,
                style: context.typography.bodyXS,
                color: context.colors.textSubTitle,
                maxLines: 1,
              ),
            ),
          ],
        ),
        AppText(
          AmountFormatter.format(count),
          style: context.typography.titleS,
        ),
      ],
    );
  }
}
