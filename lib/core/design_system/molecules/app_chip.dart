import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Pill filter / quick-reply chip (Figma `Courier/Chip`: Default ·
/// Selected), e.g. the notification filters "الكل · الطلبات · …".
///
/// Visually 38 high; the touch area is padded to 44, as the design note
/// asks.
class AppChip extends StatelessWidget {
  const AppChip({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          // 38 visual + 3 + 3 = 44 touch target.
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: AppInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: selected
                  ? context.colors.brandPrimary
                  : context.colors.surfaceCard,
              borderRadius: AppRadius.rfull,
              border: Border.all(
                color: selected
                    ? context.colors.brandPrimary
                    : context.colors.surfaceStroke,
              ),
            ),
            child: AppText(
              label,
              style: context.typography.subtitleS,
              color: selected
                  ? context.colors.buttonPrimary.label
                  : context.colors.textTitle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
