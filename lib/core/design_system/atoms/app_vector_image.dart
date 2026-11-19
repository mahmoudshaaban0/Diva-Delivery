import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:vector_graphics/vector_graphics.dart';

class AppVectorImage extends StatelessWidget {
  const AppVectorImage(
    this.assetPath, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.matchTextDirection = false,
    this.color,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;

  /// Tint applied to the whole graphic. When null, the asset's original
  /// colors are kept.
  final Color? color;

  /// Flip horizontally in RTL (use for directional graphics like arrows).
  final bool matchTextDirection;

  @override
  Widget build(BuildContext context) {
    final tint = color;
    return VectorGraphic(
      loader: AssetBytesLoader(assetPath),
      width: width?.w,
      height: height?.h,
      fit: fit,
      colorFilter: tint == null
          ? null
          : ColorFilter.mode(tint, BlendMode.srcIn),
      matchTextDirection: matchTextDirection,
    );
  }
}
