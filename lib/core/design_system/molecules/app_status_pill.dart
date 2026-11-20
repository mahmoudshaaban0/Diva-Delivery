import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_dot.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

enum AppStatusPillTone { success, error }

/// Small colored pill with a dot (Figma "Status Pill", e.g. "داخل النطاق").
class AppStatusPill extends StatelessWidget {
  const AppStatusPill({
    required this.label,
    required this.tone,
    this.pulse = false,
    super.key,
  });

  final String label;
  final AppStatusPillTone tone;

  /// Pulses the dot to show a live state (see `AppDot.pulse`).
  final bool pulse;

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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: AppInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.rfull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4.w,
        children: [
          AppDot(color: dot, size: 6, pulse: pulse),
          AppText(label, style: context.typography.body2XS, color: foreground),
        ],
      ),
    );
  }
}
