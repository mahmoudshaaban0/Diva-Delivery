import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// One placeholder block inside an `AppSkeleton`. Sizes are design units:
/// width scales with `.w`, height with `.h`. Null width fills the space.
class AppSkeletonBox extends StatelessWidget {
  const AppSkeletonBox({
    required this.height,
    this.width,
    this.borderRadius,
    this.isCircle = false,
    super.key,
  });

  /// A circle of [size] (avatars, icons).
  const AppSkeletonBox.circle({required double size, super.key})
    : height = size,
      width = size,
      borderRadius = null,
      isCircle = true;

  final double height;
  final double? width;

  /// Defaults to `AppRadius.r8`.
  final BorderRadius? borderRadius;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    final w = width;
    return Container(
      width: isCircle ? height.r : w?.w,
      height: isCircle ? height.r : height.h,
      decoration: BoxDecoration(
        // Any opaque color: the shimmer paints its gradient through it.
        color: context.colors.brandPrimaryTint,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : borderRadius ?? AppRadius.r8,
      ),
    );
  }
}
