import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Neutral hint with an info icon on a tint background (Figma "Note").
class AppInfoNote extends StatelessWidget {
  const AppInfoNote({required this.message, this.borderRadius, super.key});

  final String message;

  /// Defaults to `AppRadius.r24`: a full pill on one line that still looks
  /// right when the text wraps. Figma uses `AppRadius.r16` on some notes.
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.colors.brandPrimaryTint,
        borderRadius: borderRadius ?? AppRadius.r24,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          AppSvgIcon(
            Assets.vectorsIcInformationCircle18,
            size: 18,
            color: context.colors.textSubTitle,
          ),
          Expanded(
            child: AppText(
              message,
              style: context.typography.bodyXS,
              color: context.colors.textSubTitle,
            ),
          ),
        ],
      ),
    );
  }
}
