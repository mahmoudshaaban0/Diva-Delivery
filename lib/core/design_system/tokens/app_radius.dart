import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';

/// Corner radii, scaled with `.r`.
///
/// These are getters (not fields) so they're recalculated on every read and
/// follow screen-size changes (rotation, split-screen, window resize).
abstract final class AppRadius {
  /// Radius of 0.
  static const BorderRadius none = BorderRadius.zero;

  /// Pill / circle. Doesn't need scaling: any value larger than half the
  /// height already gives fully rounded ends.
  static const BorderRadius rfull = BorderRadius.all(Radius.circular(1000));

  static BorderRadius get r2 => BorderRadius.circular(2.r);
  static BorderRadius get r4 => BorderRadius.circular(4.r);
  static BorderRadius get r6 => BorderRadius.circular(6.r);
  static BorderRadius get r8 => BorderRadius.circular(8.r);
  static BorderRadius get r12 => BorderRadius.circular(12.r);
  static BorderRadius get r16 => BorderRadius.circular(16.r);
  static BorderRadius get r20 => BorderRadius.circular(20.r);
  static BorderRadius get r24 => BorderRadius.circular(24.r);
  static BorderRadius get r28 => BorderRadius.circular(28.r);
  static BorderRadius get r32 => BorderRadius.circular(32.r);
  static BorderRadius get r34 => BorderRadius.circular(34.r);
}
