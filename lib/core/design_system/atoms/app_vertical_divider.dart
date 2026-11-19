import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

class AppVerticalDivider extends StatelessWidget {
  const AppVerticalDivider({super.key, this.height, this.thickness = 1});

  final double? height;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: thickness,
      height: height,
      child: ColoredBox(color: context.colors.surfaceLine),
    );
  }
}
