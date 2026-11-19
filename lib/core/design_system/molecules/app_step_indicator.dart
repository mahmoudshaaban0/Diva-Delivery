import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// "Step 1 of 2" with one bar per step (Figma "Steps").
///
/// The label sits at the reading start; the bars fill left-to-right in both
/// languages, as in the design.
class AppStepIndicator extends StatelessWidget {
  const AppStepIndicator({
    required this.current,
    required this.total,
    required this.label,
    super.key,
  });

  /// 1-based index of the active step.
  final int current;
  final int total;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppText(
            label,
            style: context.typography.subtitleXS,
            color: context.colors.textSubTitle,
          ),
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            spacing: 8.w,
            children: [
              for (var step = 1; step <= total; step++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 28.w,
                  height: 6,
                  decoration: BoxDecoration(
                    color: step <= current
                        ? context.colors.brandPrimary
                        : context.colors.brandPrimary200,
                    borderRadius: AppRadius.rfull,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
