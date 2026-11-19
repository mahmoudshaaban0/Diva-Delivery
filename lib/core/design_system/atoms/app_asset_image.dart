import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

class AppAssetImage extends StatelessWidget {
  const AppAssetImage(
    this.path, {
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.fill,
  });

  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width?.w,
      height: height?.h,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          _Placeholder(width: width, height: height, failed: true),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({this.width, this.height, this.failed = false});

  final double? width;
  final double? height;
  final bool failed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w,
      height: height?.h,
      color: context.colors.brandPrimaryTint,
      alignment: Alignment.center,
      child: failed
          ? const AppIcon(Icons.broken_image_outlined, tone: AppIconTone.subtle)
          : null,
    );
  }
}
