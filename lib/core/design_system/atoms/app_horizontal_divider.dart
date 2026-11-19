import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

class AppHorizontalDivider extends StatelessWidget {
  const AppHorizontalDivider({super.key, this.thickness = 1});

  final double thickness;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: thickness,
      child: ColoredBox(color: context.colors.surfaceLine),
    );
  }
}
