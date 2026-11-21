import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/formatters/amount_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Amount with the Saudi riyal symbol (Figma `Icon/Riyal`): the symbol sits
/// left of the number in both languages, takes the text color, and is about
/// 0.85 × the font size.
class AppPrice extends StatelessWidget {
  const AppPrice({
    required this.amount,
    this.style,
    this.color,
    this.showCents = false,
    super.key,
  });

  final num amount;

  /// Defaults to `typography.titleS`.
  final TextStyle? style;
  final Color? color;

  /// `1,280.00` instead of `1,280` (order cards and details).
  final bool showCents;

  @override
  Widget build(BuildContext context) {
    final textStyle = (style ?? context.typography.titleS).copyWith(
      color: color ?? context.colors.textTitle,
    );
    // The symbol box follows the (already `.sp`-scaled) font size; the icon
    // is fitted into it.
    final fontSize = textStyle.fontSize ?? 22;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 2.w,
        children: [
          SizedBox.square(
            dimension: fontSize * 0.85,
            child: FittedBox(
              child: AppSvgIcon(
                Assets.vectorsIcRiyal,
                size: 19,
                color: textStyle.color,
              ),
            ),
          ),
          Text(
            showCents
                ? AmountFormatter.money(amount)
                : AmountFormatter.format(amount),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
