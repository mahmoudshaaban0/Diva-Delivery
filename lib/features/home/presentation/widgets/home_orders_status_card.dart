import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_vertical_divider.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_order_stat.dart';

/// Pending · completed · cancelled counts (Figma "Status Card"). Pending is
/// "New" before the day starts and "With captain" after it.
class HomeOrdersStatusCard extends StatelessWidget {
  const HomeOrdersStatusCard({
    required this.pending,
    required this.completed,
    required this.cancelled,
    required this.isDayStarted,
    super.key,
  });

  final int pending;
  final int completed;
  final int cancelled;
  final bool isDayStarted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: AppRadius.r20,
        border: Border.all(color: context.colors.surfaceStroke),
      ),
      child: Row(
        children: [
          Expanded(
            child: HomeOrderStat(
              label: isDayStarted
                  ? context.localizations.orderStatusWithCaptain
                  : context.localizations.orderStatusNew,
              dotColor: isDayStarted
                  ? context.colors.systemYellow
                  : context.colors.systemBlue,
              count: pending,
              // New orders waiting before the day starts: draw attention.
              pulse: !isDayStarted && pending > 0,
            ),
          ),
          const AppVerticalDivider(height: 36),
          Expanded(
            child: HomeOrderStat(
              label: context.localizations.orderStatusCompleted,
              dotColor: context.colors.systemGreen,
              count: completed,
            ),
          ),
          const AppVerticalDivider(height: 36),
          Expanded(
            child: HomeOrderStat(
              label: context.localizations.orderStatusCancelled,
              dotColor: context.colors.systemRed,
              count: cancelled,
            ),
          ),
        ],
      ),
    );
  }
}
