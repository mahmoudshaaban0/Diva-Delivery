import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    required this.onPressed,
    required this.child,
    this.expanded = true,
    super.key,
  });
  final VoidCallback? onPressed;
  final Widget child;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final buttonColors = context.colors.buttonRed;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        textStyle: context.typography.subtitleS,
        minimumSize: Size(expanded ? double.infinity : 0, 46.h),
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return buttonColors.soft;
          }
          return Colors.transparent;
        }),
        foregroundColor: buttonColors.outline,
        disabledForegroundColor: context.colors.buttonDisabledLabel,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.r34),
        side: BorderSide(
          color: onPressed == null
              ? context.colors.buttonDisabledStroke
              : buttonColors.outline,
        ),
      ),
      child: child,
    );
  }
}
