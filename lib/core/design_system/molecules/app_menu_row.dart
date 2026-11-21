import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Settings row (Figma `Courier/Menu Row`): a 40-px icon box, the title, and
/// at the end an optional value with a chevron ("Link").
///
/// [destructive] draws the red variant (e.g. "تسجيل الخروج") without a
/// chevron. Group rows in an `AppMenuGroup`.
class AppMenuRow extends StatelessWidget {
  const AppMenuRow({
    required this.iconAsset,
    required this.title,
    this.value,
    this.onTap,
    this.showChevron = true,
    this.destructive = false,
    super.key,
  });

  /// A 20-px SVG icon.
  final String iconAsset;
  final String title;

  /// Current value shown before the chevron (e.g. "العربية").
  final String? value;
  final VoidCallback? onTap;
  final bool showChevron;
  final bool destructive;

  /// Fixed row height (a touch target, not scaled).
  static const double minHeight = 56;

  @override
  Widget build(BuildContext context) {
    final foreground = destructive
        ? context.colors.systemRedText
        : context.colors.textTitle;

    return Semantics(
      button: onTap != null,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: minHeight),
          child: Padding(
            padding: AppInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              spacing: 12.w,
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: destructive
                        ? context.colors.systemRedBg
                        : context.colors.brandPrimaryTint,
                    borderRadius: AppRadius.r12,
                  ),
                  child: AppSvgIcon(iconAsset, size: 20, color: foreground),
                ),
                Expanded(
                  child: AppText(
                    title,
                    style: context.typography.subtitleS,
                    color: foreground,
                  ),
                ),
                if (!destructive && (value != null || showChevron))
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6.w,
                    children: [
                      if (value != null)
                        AppText(
                          value!,
                          style: context.typography.bodyS,
                          color: context.colors.textCaption,
                        ),
                      if (showChevron)
                        AppSvgIcon(
                          Assets.vectorsIcArrowLeft14,
                          size: 14,
                          color: context.colors.textCaption,
                          flipInLtr: true,
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
