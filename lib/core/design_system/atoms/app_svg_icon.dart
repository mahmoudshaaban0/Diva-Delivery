import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:vector_graphics/vector_graphics.dart';

/// A single-color SVG icon from `assets/vectors/`, tinted at runtime so it
/// follows the theme.
///
/// When [color] is null it uses the ambient [IconTheme] color, so it picks up
/// `prefixIconColor` / `suffixIconColor` inside a text field like an [Icon].
class AppSvgIcon extends StatelessWidget {
  const AppSvgIcon(
    this.assetPath, {
    required this.size,
    this.color,
    this.flipInLtr = false,
    super.key,
  });

  final String assetPath;

  /// Design size in logical pixels (scaled with `.r`).
  final double size;
  final Color? color;

  /// Mirror the icon in LTR layouts. Use for directional glyphs drawn for the
  /// RTL design (e.g. the back arrow points right in Arabic, left in English).
  final bool flipInLtr;

  @override
  Widget build(BuildContext context) {
    final tint = color ?? IconTheme.of(context).color;
    final flip = flipInLtr && Directionality.of(context) == TextDirection.ltr;
    return Transform.flip(
      flipX: flip,
      child: VectorGraphic(
        loader: AssetBytesLoader(assetPath),
        width: size.r,
        height: size.r,
        colorFilter: tint == null
            ? null
            : ColorFilter.mode(tint, BlendMode.srcIn),
      ),
    );
  }
}
