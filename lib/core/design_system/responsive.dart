import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Holds the current screen metrics used by the `num` extensions below.
///
/// You never call this directly: [ResponsiveScope] keeps it up to date.
/// Values default to the design size, so nothing crashes if they are read
/// before the first frame.
abstract final class SizeConfig {
  /// Size of the design frame (Figma), in portrait.
  static const Size designSize = Size(375, 812);

  /// Limits so layouts don't shrink too much on tiny phones or blow up on
  /// tablets / desktop.
  static const double minScale = 0.8;
  static const double maxScale = 1.5;
  static const double minTextScale = 0.9;
  static const double maxTextScale = 1.25;

  static Size _screenSize = designSize;
  static double _scaleWidth = 1;
  static double _scaleHeight = 1;

  static Size get screenSize => _screenSize;
  static double get screenWidth => _screenSize.width;
  static double get screenHeight => _screenSize.height;
  static double get scaleWidth => _scaleWidth;
  static double get scaleHeight => _scaleHeight;

  /// Updates the metrics. Returns `true` if the size changed.
  static bool update(Size size) {
    if (size == _screenSize || size.isEmpty) return false;
    _screenSize = size;
    // Scale by the short/long side so rotating the device doesn't change sizes.
    _scaleWidth = size.shortestSide / designSize.width;
    _scaleHeight = size.longestSide / designSize.height;
    return true;
  }

  static double _clamp(double v) => v.clamp(minScale, maxScale);

  static double width(num v) => v * _clamp(_scaleWidth);
  static double height(num v) => v * _clamp(_scaleHeight);
  static double radius(num v) =>
      v * _clamp(math.min(_scaleWidth, _scaleHeight));

  /// Text already applies the user's accessibility text scale on its own,
  /// so it's deliberately not applied here.
  static double font(num v) =>
      v * math.min(_scaleWidth, _scaleHeight).clamp(minTextScale, maxTextScale);
}

/// Put this once at the app root, e.g. in `MaterialApp.builder`:
///
/// ```dart
/// MaterialApp.router(
///   builder: (context, child) => ResponsiveScope(child: child!),
/// )
/// ```
///
/// It reads the screen size, updates [SizeConfig], and rebuilds the whole
/// subtree when the size changes (rotation, split-screen, window resize),
/// including `const` widgets.
class ResponsiveScope extends StatelessWidget {
  const ResponsiveScope({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final changed = SizeConfig.update(MediaQuery.sizeOf(context));
    if (changed) {
      void rebuild(Element element) {
        element
          ..markNeedsBuild()
          ..visitChildren(rebuild);
      }

      (context as Element).visitChildren(rebuild);
    }
    return child;
  }
}

extension ResponsiveNum on num {
  /// Scaled width: horizontal padding, widths.
  double get w => SizeConfig.width(this);

  /// Scaled height: vertical gaps, heights.
  double get h => SizeConfig.height(this);

  /// Scaled square size: icons, radii, avatars. Stays square.
  double get r => SizeConfig.radius(this);

  /// Scaled font size.
  double get sp => SizeConfig.font(this);

  /// Percent of the screen width, e.g. `50.sw` = half the screen width.
  double get sw => SizeConfig.screenWidth * this / 100;

  /// Percent of the screen height, e.g. `30.sh`.
  double get sh => SizeConfig.screenHeight * this / 100;

  /// `16.verticalSpace` = `SizedBox(height: 16.h)`.
  Widget get vs => SizedBox(height: h);

  /// `16.horizontalSpace` = `SizedBox(width: 16.w)`.
  Widget get hs => SizedBox(width: w);
}
