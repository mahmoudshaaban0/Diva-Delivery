import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';

/// {@template app_spacing}
///  Class contains all space (does not matter is it vertical
///  or horizontal used in app
/// {@endtemplate}
class AppPadding {
  AppPadding._();

  static const s0 = 0.0;
  static const s2 = 2.0;
  static const s4 = 4.0;
  static const s6 = 6.0;
  static const s8 = 8.0;
  static const s10 = 10.0;
  static const s12 = 12.0;
  static const s16 = 16.0;
  static const s20 = 20.0;
  static const s24 = 24.0;
}

/// Gap widths. Getters, so they follow screen-size changes.
SizedBox get gapW4 => SizedBox(width: AppPadding.s4.w);
SizedBox get gapW8 => SizedBox(width: AppPadding.s8.w);
SizedBox get gapW12 => SizedBox(width: AppPadding.s12.w);
SizedBox get gapW16 => SizedBox(width: AppPadding.s16.w);
SizedBox get gapW20 => SizedBox(width: AppPadding.s20.w);
SizedBox get gapW24 => SizedBox(width: AppPadding.s24.w);

/// Gap heights. Getters, so they follow screen-size changes.
SizedBox get gapH4 => SizedBox(height: AppPadding.s4.h);
SizedBox get gapH8 => SizedBox(height: AppPadding.s8.h);
SizedBox get gapH12 => SizedBox(height: AppPadding.s12.h);
SizedBox get gapH16 => SizedBox(height: AppPadding.s16.h);
SizedBox get gapH20 => SizedBox(height: AppPadding.s20.h);
SizedBox get gapH24 => SizedBox(height: AppPadding.s24.h);
