import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Blue informational banner with an 18-px icon at the start (Figma
/// "Banner", e.g. "البيانات للعرض فقط · لتعديلها تواصل مع المشرف").
class AppInfoBanner extends StatelessWidget {
  const AppInfoBanner({
    required this.message,
    required this.iconAsset,
    super.key,
  });

  final String message;

  /// An 18-px SVG icon.
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.systemBlueBg,
        borderRadius: AppRadius.r12,
      ),
      child: Row(
        spacing: 8.w,
        children: [
          AppSvgIcon(iconAsset, size: 18, color: context.colors.systemBlueText),
          Expanded(
            child: AppText(
              message,
              style: context.typography.bodyS,
              color: context.colors.systemBlueText,
            ),
          ),
        ],
      ),
    );
  }
}
