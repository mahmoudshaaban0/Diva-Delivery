import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

enum AppIconSize { sm, md, lg, xl }

enum AppIconTone { primary, subtle, error, success }

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size = AppIconSize.md,
    this.tone = AppIconTone.primary,
  });

  final IconData icon;
  final AppIconSize size;
  final AppIconTone tone;

  @override
  Widget build(BuildContext context) {
    final dimension = switch (size) {
      AppIconSize.sm => 16.0,
      AppIconSize.md => 24.0,
      AppIconSize.lg => 32.0,
      AppIconSize.xl => 48.0,
    };
    final color = switch (tone) {
      AppIconTone.primary => context.colors.textTitle,
      AppIconTone.subtle => context.colors.surfaceIconInactive,
      AppIconTone.error => context.colors.systemRed,
      AppIconTone.success => context.colors.systemGreen,
    };
    return Icon(icon, size: dimension.r, color: color);
  }
}
