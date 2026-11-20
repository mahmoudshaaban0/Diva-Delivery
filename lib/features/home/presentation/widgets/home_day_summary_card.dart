import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_horizontal_divider.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/formatters/date_formatter.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';
import 'package:limitless_code_template/features/home/presentation/widgets/home_day_summary_row.dart';

/// Warehouse · start time · orders (Figma `Sheet Content/Day Summary`).
class HomeDaySummaryCard extends StatelessWidget {
  const HomeDaySummaryCard({
    required this.warehouseName,
    required this.startedAt,
    required this.ordersCount,
    super.key,
  });

  final String warehouseName;
  final DateTime startedAt;
  final int ordersCount;

  @override
  Widget build(BuildContext context) {
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
          HomeDaySummaryRow(
            label: context.localizations.summaryWarehouse,
            value: warehouseName,
          ),
          const AppHorizontalDivider(),
          HomeDaySummaryRow(
            label: context.localizations.summaryStartTime,
            value: DateFormatter.formatTime(startedAt),
          ),
          const AppHorizontalDivider(),
          HomeDaySummaryRow(
            label: context.localizations.summaryOrders,
            value: context.localizations.ordersWithCaptain(ordersCount),
          ),
        ],
      ),
    );
  }
}
