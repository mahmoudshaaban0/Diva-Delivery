import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// The color carries the meaning (Figma `Courier/Tone Icon`): blue = on the
/// way / info, green = done, yellow = needs attention, red = failed /
/// rejected, neutral = no meaning.
enum AppTone { neutral, blue, green, yellow, red }

/// A 16-px icon in its tone color on a soft 32-px circle (Figma
/// `Courier/Tone Icon`), e.g. the order-details section titles.
///
/// Fixed component size, not scaled.
class AppToneIcon extends StatelessWidget {
  const AppToneIcon({
    required this.iconAsset,
    this.tone = AppTone.neutral,
    super.key,
  });

  /// A 16-px SVG icon.
  final String iconAsset;
  final AppTone tone;

  static const double dimension = 32;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (tone) {
      AppTone.neutral => (
        context.colors.buttonNeutral.soft,
        context.colors.textTitle,
      ),
      AppTone.blue => (
        context.colors.systemBlueBg,
        context.colors.systemBlueText,
      ),
      AppTone.green => (
        context.colors.systemGreenBg,
        context.colors.systemGreenText,
      ),
      AppTone.yellow => (
        context.colors.systemYellowBg,
        context.colors.systemYellowText,
      ),
      AppTone.red => (context.colors.systemRedBg, context.colors.systemRedText),
    };

    return Container(
      width: dimension,
      height: dimension,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: AppSvgIcon(iconAsset, size: 16, color: foreground),
    );
  }
}
