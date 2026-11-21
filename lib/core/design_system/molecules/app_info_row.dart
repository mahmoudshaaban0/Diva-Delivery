import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Label at the start, value at the end (Figma `Courier/Info Row`, "Text"
/// and "Copy"). Pass [onCopy] to show the copy icon next to the value and
/// make the value tappable.
///
/// Latin values inside Arabic (codes, phones, emails) should be wrapped
/// with `LtrFormatter` before they get here.
class AppInfoRow extends StatelessWidget {
  const AppInfoRow({
    required this.label,
    required this.value,
    this.onCopy,
    super.key,
  });

  final String label;
  final String value;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    final valueText = AppText(
      value,
      style: context.typography.bodyS,
      color: context.colors.textSubTitle,
      maxLines: 1,
    );

    return Row(
      spacing: 12.w,
      children: [
        Expanded(
          child: AppText(
            label,
            style: context.typography.bodyS,
            color: context.colors.textBody,
          ),
        ),
        if (onCopy == null)
          Flexible(flex: 2, child: valueText)
        else
          Flexible(
            flex: 2,
            child: Semantics(
              button: true,
              child: GestureDetector(
                onTap: onCopy,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 2.w,
                  children: [
                    Flexible(child: valueText),
                    AppSvgIcon(
                      Assets.vectorsIcCopy14,
                      size: 14,
                      color: context.colors.textSubTitle,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
