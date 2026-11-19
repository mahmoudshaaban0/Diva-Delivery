import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_colors.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

enum AppFilledVariant { primary, neutral, red, yellow }

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    required this.onPressed,
    required this.child,
    this.variant = AppFilledVariant.primary,
    this.expanded = true,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final AppFilledVariant variant;

  /// Fills the available width when true; otherwise hugs its content.
  final bool expanded;

  /// Shows a spinner instead of [child] and ignores taps (Figma "Loading").
  final bool isLoading;

  AppButtonColors _colorsFor(AppColors colors) => switch (variant) {
    AppFilledVariant.primary => colors.buttonPrimary,
    AppFilledVariant.neutral => colors.buttonNeutral,
    AppFilledVariant.red => colors.buttonRed,
    AppFilledVariant.yellow => colors.buttonYellow,
  };

  @override
  Widget build(BuildContext context) {
    final buttonColors = _colorsFor(context.colors);

    return FilledButton(
      onPressed: isLoading ? () {} : onPressed,

      style: FilledButton.styleFrom(
        textStyle: context.typography.subtitleS,
        minimumSize: Size(expanded ? double.infinity : 0, 46.h),
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return context.colors.buttonDisabledFill;
          }
          if (states.contains(WidgetState.pressed)) {
            return buttonColors.fillPressed;
          }
          return buttonColors.fill;
        }),
        foregroundColor: buttonColors.label,
        disabledBackgroundColor: context.colors.buttonDisabledFill,
        disabledForegroundColor: context.colors.buttonDisabledLabel,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.r34),
        side: buttonColors.stroke == null
            ? null
            : BorderSide(color: buttonColors.stroke!),
      ),
      child: isLoading
          ? SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: buttonColors.label,
              ),
            )
          : child,
    );
  }
}
