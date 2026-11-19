import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_colors.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_typography.dart';
import 'package:limitless_code_template/l10n/app_localizations.dart';

// shortcut: context.localizations
extension LocalizationsExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this);
}

// extension to check if string is null or empty
extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

// extension to check if list is null or empty
extension ListExtension on List<dynamic>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension ThemeExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => theme.brightness == Brightness.light;
  AppColors get colors => theme.extension<AppColors>()!;
  AppTypography get typography => theme.extension<AppTypography>()!;
}
