import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_tone_icon.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// A card of `AppInfoRow`s (Figma "البيانات الأساسية", and the order-details
/// sections "معلومات الطلب" / "الدفع" …).
///
/// - [title] is optional (the order summary card has none).
/// - [icon] puts an `AppToneIcon` before the title; the title is then
///   15-px semibold, like the order-details sections.
class AppInfoCard extends StatelessWidget {
  const AppInfoCard({required this.rows, this.title, this.icon, super.key});

  final String? title;
  final AppToneIcon? icon;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    final heading = title;

    return Container(
      width: double.infinity,
      padding: AppInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: AppRadius.r20,
        border: Border.all(color: context.colors.surfaceStroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          if (heading != null)
            Row(
              spacing: 8.w,
              children: [
                ?icon,
                Flexible(
                  child: AppText(
                    heading,
                    style: icon == null
                        ? context.typography.subtitleS
                        : context.typography.subtitleM,
                    color: context.colors.textTitle,
                  ),
                ),
              ],
            ),
          ...rows,
        ],
      ),
    );
  }
}
