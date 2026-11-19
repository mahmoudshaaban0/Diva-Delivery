import 'package:flutter/widgets.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';

abstract final class AppInsets {
  static const EdgeInsets zero = EdgeInsets.zero;
  static EdgeInsets get screen => horizontal(AppPadding.s16);

  static EdgeInsets get all4 => all(AppPadding.s4);
  static EdgeInsets get all8 => all(AppPadding.s8);
  static EdgeInsets get all12 => all(AppPadding.s12);
  static EdgeInsets get all16 => all(AppPadding.s16);
  static EdgeInsets get all20 => all(AppPadding.s20);
  static EdgeInsets get all24 => all(AppPadding.s24);

  static EdgeInsets get h4 => horizontal(AppPadding.s4);
  static EdgeInsets get h8 => horizontal(AppPadding.s8);
  static EdgeInsets get h12 => horizontal(AppPadding.s12);
  static EdgeInsets get h16 => horizontal(AppPadding.s16);
  static EdgeInsets get h20 => horizontal(AppPadding.s20);
  static EdgeInsets get h24 => horizontal(AppPadding.s24);

  static EdgeInsets get v4 => vertical(AppPadding.s4);
  static EdgeInsets get v8 => vertical(AppPadding.s8);
  static EdgeInsets get v12 => vertical(AppPadding.s12);
  static EdgeInsets get v16 => vertical(AppPadding.s16);
  static EdgeInsets get v20 => vertical(AppPadding.s20);
  static EdgeInsets get v24 => vertical(AppPadding.s24);

  static EdgeInsets all(double value) => EdgeInsets.all(value.r);

  static EdgeInsets horizontal(double value) =>
      EdgeInsets.symmetric(horizontal: value.w);

  static EdgeInsets vertical(double value) =>
      EdgeInsets.symmetric(vertical: value.h);

  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.h);

  static EdgeInsetsDirectional only({
    double start = 0,
    double end = 0,
    double top = 0,
    double bottom = 0,
  }) => EdgeInsetsDirectional.only(
    start: start.w,
    end: end.w,
    top: top.h,
    bottom: bottom.h,
  );
}
