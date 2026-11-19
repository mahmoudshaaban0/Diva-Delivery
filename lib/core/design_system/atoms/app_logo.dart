import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';

/// The "Diva COURIER" wordmark (Figma `Brand/Logo`, temporary brand).
///
/// Everything is derived from [size], the font size of "Diva", using the
/// Figma proportions so the logo can be drawn at any scale.
class AppLogo extends StatelessWidget {
  const AppLogo({required this.size, required this.color, super.key});

  /// Splash hero size (Figma: 98.964).
  const AppLogo.hero({required this.color, super.key}) : size = 98.964;

  /// Header size used on the login screen (Figma: 33.12).
  const AppLogo.small({required this.color, super.key}) : size = 33.12;

  final double size;
  final Color color;

  static const _fontFamily = 'PlayfairDisplay';

  @override
  Widget build(BuildContext context) {
    final diva = size.r;
    final courier = diva * 0.1522;

    // The wordmark is Latin brand art: keep its layout LTR in Arabic too.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Diva',
            textScaler: TextScaler.noScaling,
            style: TextStyle(
              fontFamily: _fontFamily,
              fontVariations: const [FontVariation.weight(400)],
              fontSize: diva,
              height: 1,
              letterSpacing: -0.02 * diva,
              color: color,
            ),
          ),
          SizedBox(height: diva * 0.0652),
          Text(
            'COURIER',
            textScaler: TextScaler.noScaling,
            style: TextStyle(
              fontFamily: _fontFamily,
              fontVariations: const [FontVariation.weight(500)],
              fontSize: courier,
              height: 1,
              letterSpacing: 0.48 * courier,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
