import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_totals_card.dart'
    show HomeTotalsCard;

/// One labeled value in [HomeTotalsCard].
class HomeTotal extends StatelessWidget {
  const HomeTotal({
    required this.iconAsset,
    required this.label,
    required this.value,
    super.key,
  });

  /// A 16-px SVG icon.
  final String iconAsset;
  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Row(
          spacing: 4.w,
          children: [
            AppSvgIcon(iconAsset, size: 16, color: context.colors.textTitle),
            Flexible(
              child: AppText(
                label,
                style: context.typography.bodyXS,
                maxLines: 1,
              ),
            ),
          ],
        ),
        value,
      ],
    );
  }
}
