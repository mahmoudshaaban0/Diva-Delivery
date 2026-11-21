import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Single-choice pill (Figma `Courier/Radio Row`, Selected · Default): the
/// label at the start, the radio at the end. The border and the radio
/// animate between the two states.
class AppRadioRow extends StatelessWidget {
  const AppRadioRow({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  /// Fixed component sizes (not scaled).
  static const double height = 48;
  static const double _radio = 22;

  static const Duration _duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: _duration,
          height: height,
          padding: AppInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: context.colors.surfaceCard,
            borderRadius: AppRadius.rfull,
            border: Border.all(
              color: selected
                  ? context.colors.brandPrimary
                  : context.colors.surfaceStroke,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppText(
                  label,
                  style: context.typography.subtitleS,
                  maxLines: 1,
                ),
              ),
              // Selected: a 6-px ring around a card-colored center (Figma
              // `circle r=8, stroke 6`). Default: a thin caption ring.
              AnimatedContainer(
                duration: _duration,
                width: _radio,
                height: _radio,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.surfaceCard,
                  border: Border.all(
                    color: selected
                        ? context.colors.brandPrimary
                        : context.colors.textCaption,
                    width: selected ? 6 : 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
