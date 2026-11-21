import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_dot.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

enum AppStatusPillTone { success, error }

enum AppStatusPillSize {
  /// 6-px dot, 12-px text (home range pill).
  small,

  /// 8-px dot, 13-px semibold text (profile "في الخدمة").
  medium,
}

/// Small colored pill with a dot (Figma "Status Pill", e.g. "داخل النطاق").
class AppStatusPill extends StatelessWidget {
  const AppStatusPill({
    required this.label,
    required this.tone,
    this.pulse = false,
    this.size = AppStatusPillSize.small,
    super.key,
  });

  final String label;
  final AppStatusPillTone tone;

  /// Pulses the dot to show a live state (see `AppDot.pulse`).
  final bool pulse;
  final AppStatusPillSize size;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, dot) = switch (tone) {
      AppStatusPillTone.success => (
        context.colors.systemGreenBg,
        context.colors.systemGreenText,
        context.colors.systemGreen,
      ),
      AppStatusPillTone.error => (
        context.colors.systemRedBg,
        context.colors.systemRedText,
        context.colors.systemRed,
      ),
    };

    final isMedium = size == AppStatusPillSize.medium;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: AppInsets.symmetric(horizontal: isMedium ? 12 : 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.rfull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: (isMedium ? 6 : 4).w,
        children: [
          AppDot(color: dot, size: isMedium ? 8 : 6, pulse: pulse),
          AppText(
            label,
            style: isMedium
                ? context.typography.subtitleXS
                : context.typography.body2XS,
            color: foreground,
          ),
        ],
      ),
    );
  }
}
