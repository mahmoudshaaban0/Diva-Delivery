import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_price.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Label at the start, value at the end (Figma `Courier/Info Row`: "Text",
/// "Copy" and "Link").
///
/// Give exactly one of:
/// - [value]: text, optionally in [valueColor] (e.g. "غير مدفوع" in yellow);
/// - [amount]: money with the riyal symbol (`AppPrice`, with cents);
/// - [trailing]: any widget, e.g. an `AppStatusChip`.
///
/// [onCopy] adds the copy icon next to the value; [onTap] makes it a link
/// with a chevron (e.g. "فتح الخريطة ›").
///
/// Latin values inside Arabic (codes, phones, emails) should be wrapped
/// with `LtrFormatter` before they get here.
class AppInfoRow extends StatelessWidget {
  const AppInfoRow({
    required this.label,
    this.value,
    this.amount,
    this.trailing,
    this.valueColor,
    this.onCopy,
    this.onTap,
    super.key,
  }) : assert(
         (value != null ? 1 : 0) +
                 (amount != null ? 1 : 0) +
                 (trailing != null ? 1 : 0) ==
             1,
         'Give exactly one of value, amount or trailing.',
       );

  final String label;
  final String? value;
  final num? amount;
  final Widget? trailing;
  final Color? valueColor;
  final VoidCallback? onCopy;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final text = value;
    final price = amount;
    final valueWidget = text != null
        ? AppText(
            text,
            style: context.typography.bodyS,
            color: valueColor ?? context.colors.textSubTitle,
            maxLines: 1,
          )
        : price != null
        ? AppPrice(
            amount: price,
            showCents: true,
            style: context.typography.bodyS,
            color: valueColor ?? context.colors.textSubTitle,
          )
        : trailing!;

    final icon = onCopy != null
        ? Assets.vectorsIcCopy14
        : onTap != null
        ? Assets.vectorsIcArrowLeft14
        : null;
    final action = onCopy ?? onTap;

    final valueSlot = icon == null
        ? valueWidget
        : Semantics(
            button: true,
            child: GestureDetector(
              onTap: action,
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: (onCopy != null ? 2 : 4).w,
                children: [
                  Flexible(child: valueWidget),
                  AppSvgIcon(
                    icon,
                    size: 14,
                    flipInLtr: onTap != null && onCopy == null,
                    color: onCopy != null
                        ? context.colors.textSubTitle
                        : context.colors.textCaption,
                  ),
                ],
              ),
            ),
          );

    // The value keeps its natural width (up to ~62% of the row) and the
    // label takes the rest, so short labels never wrap.
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        spacing: 12.w,
        children: [
          Expanded(
            child: AppText(
              label,
              style: context.typography.bodyS,
              color: context.colors.textBody,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.62),
            child: valueSlot,
          ),
        ],
      ),
    );
  }
}
