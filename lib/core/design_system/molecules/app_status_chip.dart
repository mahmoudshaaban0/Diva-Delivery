import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_dot.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_tone_icon.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Order status pill with a 6-px dot (Figma `Courier/Status Chip`: مع
/// الكابتن · في الطريق · تم الوصول · تم التسليم · لم يتم الرد · مرفوض).
/// The [tone] picks the colors (see `AppTone`).
class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    required this.label,
    this.tone = AppTone.neutral,
    this.pulse = false,
    super.key,
  });

  final String label;
  final AppTone tone;

  /// Pulses the dot for a live state, e.g. the order on its way (see
  /// `AppDot.pulse`).
  final bool pulse;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, dot) = switch (tone) {
      AppTone.neutral => (
        context.colors.brandPrimaryTint,
        context.colors.brandPrimary,
        context.colors.brandPrimary,
      ),
      AppTone.blue => (
        context.colors.systemBlueBg,
        context.colors.systemBlueText,
        context.colors.systemBlue,
      ),
      AppTone.green => (
        context.colors.systemGreenBg,
        context.colors.systemGreenText,
        context.colors.systemGreen,
      ),
      AppTone.yellow => (
        context.colors.systemYellowBg,
        context.colors.systemYellowText,
        context.colors.systemYellow,
      ),
      AppTone.red => (
        context.colors.systemRedBg,
        context.colors.systemRedText,
        context.colors.systemRed,
      ),
    };

    return Container(
      padding: AppInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.rfull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6.w,
        children: [
          AppDot(color: dot, size: 6, pulse: pulse),
          AppText(
            label,
            style: context.typography.subtitleXS,
            color: foreground,
          ),
        ],
      ),
    );
  }
}
