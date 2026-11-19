import 'package:flutter/material.dart';

/// The app's semantic color tokens (Figma "Foundation / Colors" board,
/// Diva COURIER node 34286:465).
///
/// Values in [AppColors.light] mirror the Figma variables 1:1. Figma has no
/// dark mode yet, so [AppColors.dark] is derived from the light palette.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    // Brand
    this.brandPrimary = const Color(0xFF171717),
    this.brandPrimaryPressed = const Color(0xFF000000),
    this.brandPrimarySoft = const Color(0xFFEDEDED),
    this.brandPrimaryTint = const Color(0xFFF2F2F2),
    this.brandPrimary200 = const Color(0xFFD4D4D4),
    this.brandDeep = const Color(0xFF171717),
    this.brandAccent = const Color(0xFF171717),
    this.brandAccentSoft = const Color(0x0F171717),
    // Text
    this.textTitle = const Color(0xFF171717),
    this.textSubTitle = const Color(0xFF2E2E2E),
    this.textBody = const Color(0xFF5C5C5C),
    this.textCaption = const Color(0xFF6E6E6E),
    this.textAlwaysWhite = const Color(0xFFFFFFFF),
    this.textAlwaysWhiteMeta = const Color(0xB2FFFFFF),
    // Surface
    this.surfaceBg = const Color(0xFFFFFFFF),
    this.surfaceCard = const Color(0xFFFCFCFC),
    this.surfaceStroke = const Color(0xFFE8E8E8),
    this.surfaceLine = const Color(0xFFEAEAEA),
    this.surfaceScrim = const Color(0xFF171717),
    this.surfaceIconInactive = const Color(0xFF6B6B6B),
    this.surfaceGlass = const Color(0x1AFFFFFF),
    this.surfaceDivider = const Color(0x26FFFFFF),
    // System
    this.systemRed = const Color(0xFFEF4444),
    this.systemRedText = const Color(0xFFB91C1C),
    this.systemRedBg = const Color(0xFFFEF2F2),
    this.systemRedStroke = const Color(0xFFFECACA),
    this.systemYellow = const Color(0xFFF59E0B),
    this.systemYellowText = const Color(0xFF92400E),
    this.systemYellowBg = const Color(0xFFFFFBEB),
    this.systemYellowStroke = const Color(0xFFFDE68A),
    this.systemGreen = const Color(0xFF22C55E),
    this.systemGreenText = const Color(0xFF15803D),
    this.systemGreenBg = const Color(0xFFF0FDF4),
    this.systemGreenStroke = const Color(0xFFBBF7D0),
    this.systemBlue = const Color(0xFF3B82F6),
    this.systemBlueText = const Color(0xFF1D4ED8),
    this.systemBlueBg = const Color(0xFFEFF6FF),
    this.systemBlueStroke = const Color(0xFFBFDBFE),
    // Buttons
    this.buttonPrimary = const AppButtonColors(
      fill: Color(0xFF171717),
      fillPressed: Color(0xFF000000),
      label: Color(0xFFFFFFFF),
      soft: Color(0xFFF2F2F2),
      softPressed: Color(0xFFE0E0E0),
      onSoft: Color(0xFF171717),
      outline: Color(0xFF171717),
    ),
    this.buttonRed = const AppButtonColors(
      fill: Color(0xFFDC2626),
      fillPressed: Color(0xFFB91C1C),
      label: Color(0xFFFFFFFF),
      soft: Color(0xFFFEF2F2),
      softPressed: Color(0xFFFEE2E2),
      onSoft: Color(0xFFB91C1C),
      outline: Color(0xFFDC2626),
    ),
    this.buttonYellow = const AppButtonColors(
      fill: Color(0xFFF59E0B),
      fillPressed: Color(0xFFD97706),
      label: Color(0xFF171717),
      soft: Color(0xFFFFFBEB),
      softPressed: Color(0xFFFDE68A),
      onSoft: Color(0xFF92400E),
      outline: Color(0xFFB45309),
    ),
    this.buttonGreen = const AppButtonColors(
      fill: Color(0xFF15803D),
      fillPressed: Color(0xFF166534),
      label: Color(0xFFFFFFFF),
      soft: Color(0xFFF0FDF4),
      softPressed: Color(0xFFBBF7D0),
      onSoft: Color(0xFF166534),
      outline: Color(0xFF15803D),
    ),
    this.buttonBlue = const AppButtonColors(
      fill: Color(0xFF2563EB),
      fillPressed: Color(0xFF1D4ED8),
      label: Color(0xFFFFFFFF),
      soft: Color(0xFFEFF6FF),
      softPressed: Color(0xFFBFDBFE),
      onSoft: Color(0xFF1D4ED8),
      outline: Color(0xFF2563EB),
    ),
    this.buttonAccent = const AppButtonColors(
      fill: Color(0xFF171717),
      fillPressed: Color(0xFF000000),
      label: Color(0xFFFFFFFF),
      soft: Color(0xFFF2F2F2),
      softPressed: Color(0xFFE0E0E0),
      onSoft: Color(0xFF171717),
      outline: Color(0xFF171717),
    ),
    this.buttonNeutral = const AppButtonColors(
      fill: Color(0xFFFCFCFC),
      fillPressed: Color(0xFFEAEAEA),
      label: Color(0xFF171717),
      soft: Color(0xFFF2F2F2),
      softPressed: Color(0xFFEAEAEA),
      onSoft: Color(0xFF171717),
      outline: Color(0xFF171717),
      stroke: Color(0xFFE8E8E8),
    ),
    this.buttonDisabledFill = const Color(0xFFEFEFEF),
    this.buttonDisabledLabel = const Color(0xFFA3A3A3),
    this.buttonDisabledStroke = const Color(0xFFDEDEDE),
  });

  factory AppColors.light() => const AppColors();

  /// Derived from the light palette (not in Figma yet): neutrals are
  /// inverted (near-black brand → near-white), system hues shift one step
  /// lighter for contrast on dark, and soft/bg/stroke tints become deep tones.
  factory AppColors.dark() => const AppColors(
    // Brand
    brandPrimary: Color(0xFFF5F5F5),
    brandPrimaryPressed: Color(0xFFFFFFFF),
    brandPrimarySoft: Color(0xFF262626),
    brandPrimaryTint: Color(0xFF1F1F1F),
    brandPrimary200: Color(0xFF404040),
    brandDeep: Color(0xFFF5F5F5),
    brandAccent: Color(0xFFF5F5F5),
    brandAccentSoft: Color(0x0FF5F5F5),
    // Text
    textTitle: Color(0xFFF5F5F5),
    textSubTitle: Color(0xFFD4D4D4),
    textBody: Color(0xFFA3A3A3),
    textCaption: Color(0xFF919191),
    // Surface
    surfaceBg: Color(0xFF0A0A0A),
    surfaceCard: Color(0xFF141414),
    surfaceStroke: Color(0xFF2B2B2B),
    surfaceLine: Color(0xFF262626),
    surfaceScrim: Color(0xFF000000),
    surfaceIconInactive: Color(0xFF949494),
    // System
    systemRed: Color(0xFFF87171),
    systemRedText: Color(0xFFFCA5A5),
    systemRedBg: Color(0xFF450A0A),
    systemRedStroke: Color(0xFF7F1D1D),
    systemYellow: Color(0xFFFBBF24),
    systemYellowText: Color(0xFFFCD34D),
    systemYellowBg: Color(0xFF451A03),
    systemYellowStroke: Color(0xFF78350F),
    systemGreen: Color(0xFF4ADE80),
    systemGreenText: Color(0xFF86EFAC),
    systemGreenBg: Color(0xFF052E16),
    systemGreenStroke: Color(0xFF14532D),
    systemBlue: Color(0xFF60A5FA),
    systemBlueText: Color(0xFF93C5FD),
    systemBlueBg: Color(0xFF172554),
    systemBlueStroke: Color(0xFF1E3A8A),
    // Buttons
    buttonPrimary: AppButtonColors(
      fill: Color(0xFFF5F5F5),
      fillPressed: Color(0xFFFFFFFF),
      label: Color(0xFF171717),
      soft: Color(0xFF262626),
      softPressed: Color(0xFF333333),
      onSoft: Color(0xFFF5F5F5),
      outline: Color(0xFFF5F5F5),
    ),
    buttonRed: AppButtonColors(
      fill: Color(0xFFEF4444),
      fillPressed: Color(0xFFDC2626),
      label: Color(0xFFFFFFFF),
      soft: Color(0xFF450A0A),
      softPressed: Color(0xFF7F1D1D),
      onSoft: Color(0xFFFCA5A5),
      outline: Color(0xFFF87171),
    ),
    buttonYellow: AppButtonColors(
      fill: Color(0xFFF59E0B),
      fillPressed: Color(0xFFD97706),
      label: Color(0xFF171717),
      soft: Color(0xFF451A03),
      softPressed: Color(0xFF78350F),
      onSoft: Color(0xFFFCD34D),
      outline: Color(0xFFFBBF24),
    ),
    buttonGreen: AppButtonColors(
      fill: Color(0xFF16A34A),
      fillPressed: Color(0xFF15803D),
      label: Color(0xFFFFFFFF),
      soft: Color(0xFF052E16),
      softPressed: Color(0xFF14532D),
      onSoft: Color(0xFF86EFAC),
      outline: Color(0xFF4ADE80),
    ),
    buttonBlue: AppButtonColors(
      fill: Color(0xFF3B82F6),
      fillPressed: Color(0xFF2563EB),
      label: Color(0xFFFFFFFF),
      soft: Color(0xFF172554),
      softPressed: Color(0xFF1E3A8A),
      onSoft: Color(0xFF93C5FD),
      outline: Color(0xFF60A5FA),
    ),
    buttonAccent: AppButtonColors(
      fill: Color(0xFFF5F5F5),
      fillPressed: Color(0xFFFFFFFF),
      label: Color(0xFF171717),
      soft: Color(0xFF262626),
      softPressed: Color(0xFF333333),
      onSoft: Color(0xFFF5F5F5),
      outline: Color(0xFFF5F5F5),
    ),
    buttonNeutral: AppButtonColors(
      fill: Color(0xFF141414),
      fillPressed: Color(0xFF262626),
      label: Color(0xFFF5F5F5),
      soft: Color(0xFF1F1F1F),
      softPressed: Color(0xFF262626),
      onSoft: Color(0xFFF5F5F5),
      outline: Color(0xFFF5F5F5),
      stroke: Color(0xFF2B2B2B),
    ),
    buttonDisabledFill: Color(0xFF262626),
    buttonDisabledLabel: Color(0xFF5C5C5C),
    buttonDisabledStroke: Color(0xFF333333),
  );

  // Brand
  final Color brandPrimary;
  final Color brandPrimaryPressed;
  final Color brandPrimarySoft;
  final Color brandPrimaryTint;
  final Color brandPrimary200;
  final Color brandDeep;
  final Color brandAccent;
  final Color brandAccentSoft;

  // Text
  final Color textTitle;
  final Color textSubTitle;
  final Color textBody;
  final Color textCaption;
  final Color textAlwaysWhite;
  final Color textAlwaysWhiteMeta;

  // Surface
  final Color surfaceBg;
  final Color surfaceCard;
  final Color surfaceStroke;
  final Color surfaceLine;
  final Color surfaceScrim;
  final Color surfaceIconInactive;
  final Color surfaceGlass;
  final Color surfaceDivider;

  // System
  final Color systemRed;
  final Color systemRedText;
  final Color systemRedBg;
  final Color systemRedStroke;
  final Color systemYellow;
  final Color systemYellowText;
  final Color systemYellowBg;
  final Color systemYellowStroke;
  final Color systemGreen;
  final Color systemGreenText;
  final Color systemGreenBg;
  final Color systemGreenStroke;
  final Color systemBlue;
  final Color systemBlueText;
  final Color systemBlueBg;
  final Color systemBlueStroke;

  // Buttons
  final AppButtonColors buttonPrimary;
  final AppButtonColors buttonRed;
  final AppButtonColors buttonYellow;
  final AppButtonColors buttonGreen;
  final AppButtonColors buttonBlue;
  final AppButtonColors buttonAccent;
  final AppButtonColors buttonNeutral;
  final Color buttonDisabledFill;
  final Color buttonDisabledLabel;
  final Color buttonDisabledStroke;

  @override
  AppColors copyWith({
    Color? brandPrimary,
    Color? brandPrimaryPressed,
    Color? brandPrimarySoft,
    Color? brandPrimaryTint,
    Color? brandPrimary200,
    Color? brandDeep,
    Color? brandAccent,
    Color? brandAccentSoft,
    Color? textTitle,
    Color? textSubTitle,
    Color? textBody,
    Color? textCaption,
    Color? textAlwaysWhite,
    Color? textAlwaysWhiteMeta,
    Color? surfaceBg,
    Color? surfaceCard,
    Color? surfaceStroke,
    Color? surfaceLine,
    Color? surfaceScrim,
    Color? surfaceIconInactive,
    Color? surfaceGlass,
    Color? surfaceDivider,
    Color? systemRed,
    Color? systemRedText,
    Color? systemRedBg,
    Color? systemRedStroke,
    Color? systemYellow,
    Color? systemYellowText,
    Color? systemYellowBg,
    Color? systemYellowStroke,
    Color? systemGreen,
    Color? systemGreenText,
    Color? systemGreenBg,
    Color? systemGreenStroke,
    Color? systemBlue,
    Color? systemBlueText,
    Color? systemBlueBg,
    Color? systemBlueStroke,
    AppButtonColors? buttonPrimary,
    AppButtonColors? buttonRed,
    AppButtonColors? buttonYellow,
    AppButtonColors? buttonGreen,
    AppButtonColors? buttonBlue,
    AppButtonColors? buttonAccent,
    AppButtonColors? buttonNeutral,
    Color? buttonDisabledFill,
    Color? buttonDisabledLabel,
    Color? buttonDisabledStroke,
  }) {
    return AppColors(
      brandPrimary: brandPrimary ?? this.brandPrimary,
      brandPrimaryPressed: brandPrimaryPressed ?? this.brandPrimaryPressed,
      brandPrimarySoft: brandPrimarySoft ?? this.brandPrimarySoft,
      brandPrimaryTint: brandPrimaryTint ?? this.brandPrimaryTint,
      brandPrimary200: brandPrimary200 ?? this.brandPrimary200,
      brandDeep: brandDeep ?? this.brandDeep,
      brandAccent: brandAccent ?? this.brandAccent,
      brandAccentSoft: brandAccentSoft ?? this.brandAccentSoft,
      textTitle: textTitle ?? this.textTitle,
      textSubTitle: textSubTitle ?? this.textSubTitle,
      textBody: textBody ?? this.textBody,
      textCaption: textCaption ?? this.textCaption,
      textAlwaysWhite: textAlwaysWhite ?? this.textAlwaysWhite,
      textAlwaysWhiteMeta: textAlwaysWhiteMeta ?? this.textAlwaysWhiteMeta,
      surfaceBg: surfaceBg ?? this.surfaceBg,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      surfaceStroke: surfaceStroke ?? this.surfaceStroke,
      surfaceLine: surfaceLine ?? this.surfaceLine,
      surfaceScrim: surfaceScrim ?? this.surfaceScrim,
      surfaceIconInactive: surfaceIconInactive ?? this.surfaceIconInactive,
      surfaceGlass: surfaceGlass ?? this.surfaceGlass,
      surfaceDivider: surfaceDivider ?? this.surfaceDivider,
      systemRed: systemRed ?? this.systemRed,
      systemRedText: systemRedText ?? this.systemRedText,
      systemRedBg: systemRedBg ?? this.systemRedBg,
      systemRedStroke: systemRedStroke ?? this.systemRedStroke,
      systemYellow: systemYellow ?? this.systemYellow,
      systemYellowText: systemYellowText ?? this.systemYellowText,
      systemYellowBg: systemYellowBg ?? this.systemYellowBg,
      systemYellowStroke: systemYellowStroke ?? this.systemYellowStroke,
      systemGreen: systemGreen ?? this.systemGreen,
      systemGreenText: systemGreenText ?? this.systemGreenText,
      systemGreenBg: systemGreenBg ?? this.systemGreenBg,
      systemGreenStroke: systemGreenStroke ?? this.systemGreenStroke,
      systemBlue: systemBlue ?? this.systemBlue,
      systemBlueText: systemBlueText ?? this.systemBlueText,
      systemBlueBg: systemBlueBg ?? this.systemBlueBg,
      systemBlueStroke: systemBlueStroke ?? this.systemBlueStroke,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      buttonRed: buttonRed ?? this.buttonRed,
      buttonYellow: buttonYellow ?? this.buttonYellow,
      buttonGreen: buttonGreen ?? this.buttonGreen,
      buttonBlue: buttonBlue ?? this.buttonBlue,
      buttonAccent: buttonAccent ?? this.buttonAccent,
      buttonNeutral: buttonNeutral ?? this.buttonNeutral,
      buttonDisabledFill: buttonDisabledFill ?? this.buttonDisabledFill,
      buttonDisabledLabel: buttonDisabledLabel ?? this.buttonDisabledLabel,
      buttonDisabledStroke: buttonDisabledStroke ?? this.buttonDisabledStroke,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    Color c(Color a, Color b) => Color.lerp(a, b, t)!;

    return AppColors(
      brandPrimary: c(brandPrimary, other.brandPrimary),
      brandPrimaryPressed: c(brandPrimaryPressed, other.brandPrimaryPressed),
      brandPrimarySoft: c(brandPrimarySoft, other.brandPrimarySoft),
      brandPrimaryTint: c(brandPrimaryTint, other.brandPrimaryTint),
      brandPrimary200: c(brandPrimary200, other.brandPrimary200),
      brandDeep: c(brandDeep, other.brandDeep),
      brandAccent: c(brandAccent, other.brandAccent),
      brandAccentSoft: c(brandAccentSoft, other.brandAccentSoft),
      textTitle: c(textTitle, other.textTitle),
      textSubTitle: c(textSubTitle, other.textSubTitle),
      textBody: c(textBody, other.textBody),
      textCaption: c(textCaption, other.textCaption),
      textAlwaysWhite: c(textAlwaysWhite, other.textAlwaysWhite),
      textAlwaysWhiteMeta: c(textAlwaysWhiteMeta, other.textAlwaysWhiteMeta),
      surfaceBg: c(surfaceBg, other.surfaceBg),
      surfaceCard: c(surfaceCard, other.surfaceCard),
      surfaceStroke: c(surfaceStroke, other.surfaceStroke),
      surfaceLine: c(surfaceLine, other.surfaceLine),
      surfaceScrim: c(surfaceScrim, other.surfaceScrim),
      surfaceIconInactive: c(surfaceIconInactive, other.surfaceIconInactive),
      surfaceGlass: c(surfaceGlass, other.surfaceGlass),
      surfaceDivider: c(surfaceDivider, other.surfaceDivider),
      systemRed: c(systemRed, other.systemRed),
      systemRedText: c(systemRedText, other.systemRedText),
      systemRedBg: c(systemRedBg, other.systemRedBg),
      systemRedStroke: c(systemRedStroke, other.systemRedStroke),
      systemYellow: c(systemYellow, other.systemYellow),
      systemYellowText: c(systemYellowText, other.systemYellowText),
      systemYellowBg: c(systemYellowBg, other.systemYellowBg),
      systemYellowStroke: c(systemYellowStroke, other.systemYellowStroke),
      systemGreen: c(systemGreen, other.systemGreen),
      systemGreenText: c(systemGreenText, other.systemGreenText),
      systemGreenBg: c(systemGreenBg, other.systemGreenBg),
      systemGreenStroke: c(systemGreenStroke, other.systemGreenStroke),
      systemBlue: c(systemBlue, other.systemBlue),
      systemBlueText: c(systemBlueText, other.systemBlueText),
      systemBlueBg: c(systemBlueBg, other.systemBlueBg),
      systemBlueStroke: c(systemBlueStroke, other.systemBlueStroke),
      buttonPrimary: buttonPrimary.lerp(other.buttonPrimary, t),
      buttonRed: buttonRed.lerp(other.buttonRed, t),
      buttonYellow: buttonYellow.lerp(other.buttonYellow, t),
      buttonGreen: buttonGreen.lerp(other.buttonGreen, t),
      buttonBlue: buttonBlue.lerp(other.buttonBlue, t),
      buttonAccent: buttonAccent.lerp(other.buttonAccent, t),
      buttonNeutral: buttonNeutral.lerp(other.buttonNeutral, t),
      buttonDisabledFill: c(buttonDisabledFill, other.buttonDisabledFill),
      buttonDisabledLabel: c(buttonDisabledLabel, other.buttonDisabledLabel),
      buttonDisabledStroke: c(buttonDisabledStroke, other.buttonDisabledStroke),
    );
  }
}

/// Color set for one button variant (Figma `Button/<Variant>/*`).
@immutable
class AppButtonColors {
  const AppButtonColors({
    required this.fill,
    required this.fillPressed,
    required this.label,
    required this.soft,
    required this.softPressed,
    required this.onSoft,
    required this.outline,
    this.stroke,
  });

  final Color fill;
  final Color fillPressed;
  final Color label;
  final Color soft;
  final Color softPressed;
  final Color onSoft;
  final Color outline;

  /// Only defined for the Neutral variant.
  final Color? stroke;

  AppButtonColors lerp(AppButtonColors other, double t) {
    return AppButtonColors(
      fill: Color.lerp(fill, other.fill, t)!,
      fillPressed: Color.lerp(fillPressed, other.fillPressed, t)!,
      label: Color.lerp(label, other.label, t)!,
      soft: Color.lerp(soft, other.soft, t)!,
      softPressed: Color.lerp(softPressed, other.softPressed, t)!,
      onSoft: Color.lerp(onSoft, other.onSoft, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      stroke: Color.lerp(stroke, other.stroke, t),
    );
  }
}
