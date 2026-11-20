import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';

/// Small filled status circle (order status, range pill, date chip).
class AppDot extends StatelessWidget {
  const AppDot({required this.color, this.size = 8, super.key});

  final Color color;

  /// Design size (scaled with `.r`). Figma uses 6 and 8.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
