import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_status_pill.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_swipe_button.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Warehouse with its range pill and the swipe-to-start button (Figma
/// "Start Day Section"). Disabled with a hint when there are no orders.
class HomeStartDayCard extends StatelessWidget {
  const HomeStartDayCard({
    required this.warehouseName,
    required this.isInRange,
    required this.hasOrders,
    required this.isChecking,
    required this.onSwiped,
    super.key,
  });

  final String warehouseName;

  /// Range pill; hidden while unknown (null).
  final bool? isInRange;
  final bool hasOrders;
  final bool isChecking;
  final VoidCallback onSwiped;

  @override
  Widget build(BuildContext context) {
    final inRange = isInRange;

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
            spacing: 8.w,
            children: [
              AppSvgIcon(
                Assets.vectorsIcWarehouse22,
                size: 22,
                color: context.colors.textTitle,
              ),
              Expanded(
                child: AppText(
                  warehouseName,
                  style: context.typography.subtitleS,
                  maxLines: 1,
                ),
              ),
              if (inRange != null)
                AppStatusPill(
                  label: inRange
                      ? context.localizations.inRange
                      : context.localizations.outOfRange,
                  tone: inRange
                      ? AppStatusPillTone.success
                      : AppStatusPillTone.error,
                ),
            ],
          ),
          AppSwipeButton(
            label: !hasOrders
                ? context.localizations.noOrdersToStartDay
                : isChecking
                ? context.localizations.checkingLocation
                : context.localizations.swipeToStartDay,
            state: !hasOrders
                ? AppSwipeButtonState.disabled
                : isChecking
                ? AppSwipeButtonState.checking
                : AppSwipeButtonState.idle,
            onSwiped: onSwiped,
          ),
          if (!hasOrders)
            AppText(
              context.localizations.noOrdersHint,
              style: context.typography.bodyXS,
              color: context.colors.textCaption,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
