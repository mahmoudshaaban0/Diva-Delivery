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

    final coreCircle = AnimatedContainer(
      duration: _duration,
      width: (size == AppIconBadgeSize.large ? 80 : 60).r,
      height: (size == AppIconBadgeSize.large ? 80 : 60).r,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: core, shape: BoxShape.circle),
      child: AppSvgIcon(
        assetPath,
        size: size == AppIconBadgeSize.large ? 36 : 28,
        color: onCore,
      ),
    );

    return AnimatedContainer(
      duration: _duration,
      width: (size == AppIconBadgeSize.large ? 152 : 88).r,
      height: (size == AppIconBadgeSize.large ? 152 : 88).r,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: outer, shape: BoxShape.circle),
      child: size == AppIconBadgeSize.large
          ? AnimatedContainer(
              duration: _duration,
              width: 116.r,
              height: 116.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: middle, shape: BoxShape.circle),
              child: coreCircle,
            )
          : coreCircle,
    );
  }
}
