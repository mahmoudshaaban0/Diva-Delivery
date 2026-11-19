import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

enum AppIconBadgeTone { brand, error }

/// Large round badge: an 88 soft ring around a 60 solid core with a 28 icon
/// (Figma "Icon Box" on the OTP screens).
class AppIconBadge extends StatelessWidget {
  const AppIconBadge({
    required this.assetPath,
    this.tone = AppIconBadgeTone.brand,
    super.key,
  });

  /// A 28-px SVG icon.
  final String assetPath;
  final AppIconBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final (ring, core, onCore) = switch (tone) {
      AppIconBadgeTone.brand => (
        context.colors.brandPrimaryTint,
        context.colors.brandPrimary,
        context.colors.buttonPrimary.label,
      ),
      AppIconBadgeTone.error => (
        context.colors.systemRedBg,
        context.colors.systemRed,
        context.colors.textAlwaysWhite,
      ),
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 88.r,
      height: 88.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: ring, shape: BoxShape.circle),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 60.r,
        height: 60.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: core, shape: BoxShape.circle),
        child: AppSvgIcon(assetPath, size: 28, color: onCore),
      ),
    );
  }
}
