import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// "Delivered today 0 of 18" with a progress bar and "View orders" (Figma
/// "Day Progress"), shown once the day has started.
class HomeDayProgressCard extends StatelessWidget {
  const HomeDayProgressCard({
    required this.delivered,
    required this.assigned,
    required this.onViewOrders,
    super.key,
  });

  final int delivered;
  final int assigned;
  final VoidCallback onViewOrders;

  /// Fixed bar height (not scaled), like a divider.
  static const double _barHeight = 8;

  @override
  Widget build(BuildContext context) {
    final progress = assigned == 0 ? 0.0 : delivered / assigned;

    return Container(
      padding: AppInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: AppRadius.r20,
        border: Border.all(color: context.colors.surfaceStroke),
      ),
      child: Column(
        spacing: 12.h,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  context.localizations.deliveredToday,
                  style: context.typography.bodyS,
                  color: context.colors.textSubTitle,
                ),
              ),
              AppText(
                context.localizations.countOf(delivered, assigned),
                style: context.typography.subtitleS,
              ),
            ],
          ),
          Container(
            height: _barHeight,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: context.colors.brandPrimaryTint,
              borderRadius: AppRadius.rfull,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) => Align(
                alignment: AlignmentDirectional.centerStart,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  // Never thinner than a dot, like the design at 0.
                  width: (constraints.maxWidth * progress).clamp(
                    _barHeight,
                    constraints.maxWidth,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.brandPrimary,
                    borderRadius: AppRadius.rfull,
                  ),
                ),
              ),
            ),
          ),
          AppFilledButton(
            onPressed: onViewOrders,
            child: AppText(
              context.localizations.viewOrders,
              style: context.typography.subtitleM.copyWith(
                fontWeight: FontWeight.w700,
              ),
              color: context.colors.buttonPrimary.label,
            ),
          ),
        ],
      ),
    );
  }
}
