import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_colors.dart';

@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.titleHero,
    required this.titleXL,
    required this.titleL,
    required this.titleM,
    required this.titleS,
    required this.titleXS,
    required this.title2XS,
    required this.title3XS,
    required this.title4XS,
    required this.title5XS,
    required this.subtitleXL,
    required this.subtitleL,
    required this.subtitleM,
    required this.subtitleS,
    required this.subtitleXS,
    required this.subtitle2XS,
    required this.bodyXL,
    required this.bodyL,
    required this.bodyM,
    required this.bodyS,
    required this.bodyXS,
    required this.body2XS,
    required this.body3XS,
  });

  factory AppTypography.fromColors(AppColors colors) {
    TextStyle style(double size, FontWeight weight, double height) => TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: 0,
      color: colors.textTitle,
    );

    return AppTypography(
      titleHero: style(32, FontWeight.w700, 1.35),
      titleXL: style(28, FontWeight.w700, 1.35),
      titleL: style(26, FontWeight.w700, 1.35),
      titleM: style(24, FontWeight.w700, 1.35),
      titleS: style(22, FontWeight.w700, 1.35),
      titleXS: style(20, FontWeight.w700, 1.4),
      title2XS: style(18, FontWeight.w700, 1.4),
      title3XS: style(16, FontWeight.w700, 1.4),
      title4XS: style(14, FontWeight.w700, 1.4),
      title5XS: style(13, FontWeight.w700, 1.4),
      subtitleXL: style(18, FontWeight.w600, 1.4),
      subtitleL: style(16, FontWeight.w600, 1.4),
      subtitleM: style(15, FontWeight.w600, 1.4),
      subtitleS: style(14, FontWeight.w600, 1.4),
      subtitleXS: style(13, FontWeight.w600, 1.4),
      subtitle2XS: style(12, FontWeight.w600, 1.4),
      bodyXL: style(18, FontWeight.w400, 1.55),
      bodyL: style(16, FontWeight.w400, 1.55),
      bodyM: style(15, FontWeight.w400, 1.55),
      bodyS: style(14, FontWeight.w400, 1.55),
      bodyXS: style(13, FontWeight.w400, 1.5),
      body2XS: style(12, FontWeight.w400, 1.5),
      body3XS: style(11, FontWeight.w400, 1.5),
    );
  }

  static const fontFamily = 'IBMPlexSansArabic';

  final TextStyle titleHero;
  final TextStyle titleXL;
  final TextStyle titleL;
  final TextStyle titleM;
  final TextStyle titleS;
  final TextStyle titleXS;
  final TextStyle title2XS;
  final TextStyle title3XS;
  final TextStyle title4XS;
  final TextStyle title5XS;

  final TextStyle subtitleXL;
  final TextStyle subtitleL;
  final TextStyle subtitleM;
  final TextStyle subtitleS;
  final TextStyle subtitleXS;
  final TextStyle subtitle2XS;

  final TextStyle bodyXL;
  final TextStyle bodyL;
  final TextStyle bodyM;
  final TextStyle bodyS;
  final TextStyle bodyXS;
  final TextStyle body2XS;
  final TextStyle body3XS;

  /// The same styles with every font size multiplied by [factor], the
  /// `.sp` scale (`SizeConfig.font(1)`). `context.typography` calls this, so
  /// all text follows the screen size; don't apply `.sp` again on top.
  ///
  /// Cached per instance and factor: it runs on every `context.typography`
  /// read, and the theme only changes on theme/locale switches.
  AppTypography scaled(double factor) {
    if (factor == 1) return this;
    final cached = _scaledCache[this];
    if (cached != null && cached.$1 == factor) return cached.$2;

    TextStyle s(TextStyle style) =>
        style.copyWith(fontSize: (style.fontSize ?? 14) * factor);

    final result = AppTypography(
      titleHero: s(titleHero),
      titleXL: s(titleXL),
      titleL: s(titleL),
      titleM: s(titleM),
      titleS: s(titleS),
      titleXS: s(titleXS),
      title2XS: s(title2XS),
      title3XS: s(title3XS),
      title4XS: s(title4XS),
      title5XS: s(title5XS),
      subtitleXL: s(subtitleXL),
      subtitleL: s(subtitleL),
      subtitleM: s(subtitleM),
      subtitleS: s(subtitleS),
      subtitleXS: s(subtitleXS),
      subtitle2XS: s(subtitle2XS),
      bodyXL: s(bodyXL),
      bodyL: s(bodyL),
      bodyM: s(bodyM),
      bodyS: s(bodyS),
      bodyXS: s(bodyXS),
      body2XS: s(body2XS),
      body3XS: s(body3XS),
    );
    _scaledCache[this] = (factor, result);
    return result;
  }

  static final _scaledCache = Expando<(double, AppTypography)>();

  @override
  AppTypography copyWith({
    TextStyle? titleHero,
    TextStyle? titleXL,
    TextStyle? titleL,
    TextStyle? titleM,
    TextStyle? titleS,
    TextStyle? titleXS,
    TextStyle? title2XS,
    TextStyle? title3XS,
    TextStyle? title4XS,
    TextStyle? title5XS,
    TextStyle? subtitleXL,
    TextStyle? subtitleL,
    TextStyle? subtitleM,
    TextStyle? subtitleS,
    TextStyle? subtitleXS,
    TextStyle? subtitle2XS,
    TextStyle? bodyXL,
    TextStyle? bodyL,
    TextStyle? bodyM,
    TextStyle? bodyS,
    TextStyle? bodyXS,
    TextStyle? body2XS,
    TextStyle? body3XS,
  }) {
    return AppTypography(
      titleHero: titleHero ?? this.titleHero,
      titleXL: titleXL ?? this.titleXL,
      titleL: titleL ?? this.titleL,
      titleM: titleM ?? this.titleM,
      titleS: titleS ?? this.titleS,
      titleXS: titleXS ?? this.titleXS,
      title2XS: title2XS ?? this.title2XS,
      title3XS: title3XS ?? this.title3XS,
      title4XS: title4XS ?? this.title4XS,
      title5XS: title5XS ?? this.title5XS,
      subtitleXL: subtitleXL ?? this.subtitleXL,
      subtitleL: subtitleL ?? this.subtitleL,
      subtitleM: subtitleM ?? this.subtitleM,
      subtitleS: subtitleS ?? this.subtitleS,
      subtitleXS: subtitleXS ?? this.subtitleXS,
      subtitle2XS: subtitle2XS ?? this.subtitle2XS,
      bodyXL: bodyXL ?? this.bodyXL,
      bodyL: bodyL ?? this.bodyL,
      bodyM: bodyM ?? this.bodyM,
      bodyS: bodyS ?? this.bodyS,
      bodyXS: bodyXS ?? this.bodyXS,
      body2XS: body2XS ?? this.body2XS,
      body3XS: body3XS ?? this.body3XS,
    );
  }

  @override
  AppTypography lerp(covariant ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;

    TextStyle l(TextStyle a, TextStyle b) => TextStyle.lerp(a, b, t)!;

    return AppTypography(
      titleHero: l(titleHero, other.titleHero),
      titleXL: l(titleXL, other.titleXL),
      titleL: l(titleL, other.titleL),
      titleM: l(titleM, other.titleM),
      titleS: l(titleS, other.titleS),
      titleXS: l(titleXS, other.titleXS),
      title2XS: l(title2XS, other.title2XS),
      title3XS: l(title3XS, other.title3XS),
      title4XS: l(title4XS, other.title4XS),
      title5XS: l(title5XS, other.title5XS),
      subtitleXL: l(subtitleXL, other.subtitleXL),
      subtitleL: l(subtitleL, other.subtitleL),
      subtitleM: l(subtitleM, other.subtitleM),
      subtitleS: l(subtitleS, other.subtitleS),
      subtitleXS: l(subtitleXS, other.subtitleXS),
      subtitle2XS: l(subtitle2XS, other.subtitle2XS),
      bodyXL: l(bodyXL, other.bodyXL),
      bodyL: l(bodyL, other.bodyL),
      bodyM: l(bodyM, other.bodyM),
      bodyS: l(bodyS, other.bodyS),
      bodyXS: l(bodyXS, other.bodyXS),
      body2XS: l(body2XS, other.body2XS),
      body3XS: l(body3XS, other.body3XS),
    );
  }
}
