import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

enum AppNetworkImageShape { rectangle, rounded, circle }

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width?.w,
      height: height?.h,
      fit: fit,
      placeholder: (context, url) => _Placeholder(width: width, height: height),
      errorWidget: (context, url, error) =>
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
