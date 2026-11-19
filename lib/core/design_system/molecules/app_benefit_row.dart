import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Icon box + title + description (Figma `Courier/Benefit Row`). Usually
/// grouped in an `AppBenefitsCard`.
class AppBenefitRow extends StatelessWidget {
  const AppBenefitRow({
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    super.key,
  });

  /// A 20-px SVG icon.
  final String iconAsset;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colors.brandPrimaryTint,
            borderRadius: AppRadius.r12,
          ),
          child: AppSvgIcon(
            iconAsset,
            size: 20,
            color: context.colors.textTitle,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              AppText(title, style: context.typography.subtitleS),
              AppText(
                subtitle,
                style: context.typography.bodyXS,
                color: context.colors.textCaption,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
