import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer for loading placeholders (`shimmer` package). Wrap a layout made
/// of `AppSkeletonBox`es that mirrors the real screen; the shine sweeps in
/// the reading direction and uses the theme colors.
///
/// ```dart
/// AppSkeleton(
///   child: Column(children: [AppSkeletonBox(height: 20), ...]),
/// )
/// ```
class AppSkeleton extends StatelessWidget {
  const AppSkeleton({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colors.brandPrimaryTint,
      highlightColor: context.colors.surfaceCard,
      direction: Directionality.of(context) == TextDirection.rtl
          ? ShimmerDirection.rtl
          : ShimmerDirection.ltr,
      child: child,
    );
  }
}
