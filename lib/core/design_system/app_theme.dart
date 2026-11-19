import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_colors.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_typography.dart';

abstract final class AppTheme {
  static ThemeData get light => _build(
    brightness: Brightness.light,
    colors: AppColors.light(),
    typography: AppTypography.fromColors(AppColors.light()),
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    colors: AppColors.dark(),
    typography: AppTypography.fromColors(AppColors.dark()),
  );

  static ThemeData _build({
    required Brightness brightness,
    required AppColors colors,
    required AppTypography typography,
  }) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.brandPrimary,
      onPrimary: colors.buttonPrimary.label,
      primaryContainer: colors.brandPrimarySoft,
      onPrimaryContainer: colors.textTitle,
      secondary: colors.brandAccent,
      onSecondary: colors.buttonAccent.label,
      secondaryContainer: colors.brandPrimaryTint,
      onSecondaryContainer: colors.textTitle,
      error: colors.systemRed,
      onError: colors.buttonRed.label,
      errorContainer: colors.systemRedBg,
      onErrorContainer: colors.systemRedText,
      surface: colors.surfaceBg,
      onSurface: colors.textTitle,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      extensions: [colors, typography],
    );
  }
}
