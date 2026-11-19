import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/constants/assets.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_svg_icon.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_radius.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Inline error banner with an info icon (Figma "Error Alert").
class AppInlineAlert extends StatelessWidget {
  const AppInlineAlert({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: AppInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: context.colors.systemRedBg,
          borderRadius: AppRadius.r16,
          border: Border.all(color: context.colors.systemRedStroke),
        ),
        child: Row(
          spacing: 8.w,
          children: [
            AppSvgIcon(
              Assets.vectorsIcInformationCircle18,
              size: 18,
              color: context.colors.systemRedText,
            ),
            Expanded(
              child: AppText(
                message,
                style: context.typography.bodyS,
                color: context.colors.systemRedText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
