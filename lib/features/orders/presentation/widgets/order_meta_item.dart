import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// A 16-px icon and a short text in the order card's meta line (distance,
/// address, time).
class OrderMetaItem extends StatelessWidget {
  const OrderMetaItem({
    required this.iconAsset,
    required this.text,
    this.highlighted = false,
    super.key,
  });

  final String iconAsset;
  final String text;

  /// Dark icon and text (the distance), instead of caption gray.
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4.w,
      children: [
        AppSvgIcon(
          iconAsset,
          size: 16,
          color: highlighted
              ? context.colors.brandPrimary
              : context.colors.textCaption,
        ),
        Flexible(
          child: AppText(
            text,
            style: context.typography.bodyS,
            color: highlighted
                ? context.colors.brandPrimary
                : context.colors.textSubTitle,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
