import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

enum AppIconBadgeTone { brand, success, warning, error }

enum AppIconBadgeSize {
  /// 88 ring → 60 core, 28 icon (Figma "Icon Box" on OTP / forgot password).
  medium,

  /// 152 outer → 116 ring → 80 core, 36 icon (Figma "Illustration" on the
  /// permission screens).
  large,

  /// 104 outer → 78 ring → 56 core, 26 icon (Figma `Courier/Status Icon` in
  /// bottom sheets).
  sheet,
}

/// Round badge with a solid core and soft rings around it.
class AppIconBadge extends StatelessWidget {
  const AppIconBadge({
    required this.assetPath,
    this.tone = AppIconBadgeTone.brand,
    this.size = AppIconBadgeSize.medium,
    super.key,
  });

  /// An SVG icon drawn at the size's icon size (28 medium, 36 large).
  final String assetPath;
  final AppIconBadgeTone tone;
  final AppIconBadgeSize size;

  static const _duration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    // (outer, middle ring, core, icon). The middle ring is large-only.
    final (outer, middle, core, onCore) = switch (tone) {
      AppIconBadgeTone.brand => (
        context.colors.brandPrimaryTint,
        context.colors.brandPrimarySoft,
        context.colors.brandPrimary,
        context.colors.buttonPrimary.label,
      ),
      AppIconBadgeTone.success => (
        context.colors.systemGreenBg,
        context.colors.systemGreenStroke,
        context.colors.systemGreen,
        context.colors.textAlwaysWhite,
      ),
      AppIconBadgeTone.warning => (
        context.colors.systemYellowBg,
        context.colors.systemYellowStroke,
        context.colors.systemYellow,
        context.colors.buttonYellow.label,
      ),
      AppIconBadgeTone.error => (
        context.colors.systemRedBg,
        context.colors.systemRedStroke,
        context.colors.systemRed,
        context.colors.textAlwaysWhite,
      ),
    };

    // (outer, middle ring, core, icon) sizes. medium has no middle ring.
    final (outerSize, middleSize, coreSize, iconSize) = switch (size) {
      AppIconBadgeSize.medium => (88.0, 0.0, 60.0, 28.0),
      AppIconBadgeSize.large => (152.0, 116.0, 80.0, 36.0),
      AppIconBadgeSize.sheet => (104.0, 78.0, 56.0, 26.0),
    };
    // The sheet's green status uses the darker button green (Figma).
    final coreColor =
        size == AppIconBadgeSize.sheet && tone == AppIconBadgeTone.success
        ? context.colors.buttonGreen.fill
        : core;

    final coreCircle = AnimatedContainer(
      duration: _duration,
      width: coreSize.r,
      height: coreSize.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: coreColor, shape: BoxShape.circle),
      child: AppSvgIcon(assetPath, size: iconSize, color: onCore),
    );

    return AnimatedContainer(
      duration: _duration,
      width: outerSize.r,
      height: outerSize.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: outer, shape: BoxShape.circle),
      child: size != AppIconBadgeSize.medium
          ? AnimatedContainer(
              duration: _duration,
              width: middleSize.r,
              height: middleSize.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: middle, shape: BoxShape.circle),
              child: coreCircle,
            )
          : coreCircle,
    );
  }
}
