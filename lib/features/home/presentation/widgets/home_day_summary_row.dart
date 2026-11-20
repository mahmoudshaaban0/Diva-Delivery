import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Label at the reading start, value at the end (row of
/// `HomeDaySummaryCard`).
class HomeDaySummaryRow extends StatelessWidget {
  const HomeDaySummaryRow({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      children: [
        AppText(
          label,
          style: context.typography.bodyS,
          color: context.colors.textSubTitle,
        ),
        Expanded(
          child: AppText(
            value,
            style: context.typography.subtitleS,
            textAlign: TextAlign.end,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
