import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_horizontal_divider.dart';
import 'package:limitless_code_template/core/design_system/molecules/app_benefit_row.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Card listing [AppBenefitRow]s separated by dividers (Figma "Benefits").
class AppBenefitsCard extends StatelessWidget {
  const AppBenefitsCard({required this.rows, super.key});

  final List<AppBenefitRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: AppRadius.r24,
        border: Border.all(color: context.colors.surfaceStroke),
      ),
      child: Column(
        spacing: 12,
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const AppHorizontalDivider(),
            rows[i],
          ],
        ],
      ),
    );
  }
}
