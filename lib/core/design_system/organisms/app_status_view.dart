import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon_badge.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Centered empty / no-results state (Figma Flow 03 "لا توجد نتائج" and
/// "أنهيت طلبات اليوم"): `Courier/Status Icon`, title, text and an optional
/// soft 200-wide action.
class AppStatusView extends StatelessWidget {
  const AppStatusView({
    required this.iconAsset,
    required this.title,
    required this.message,
    this.tone = AppIconBadgeTone.brand,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  /// A 26-px SVG icon.
  final String iconAsset;
  final AppIconBadgeTone tone;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final label = actionLabel;

    return Center(
      child: SingleChildScrollView(
        padding: AppInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16.h,
          children: [
            AppIconBadge(
              assetPath: iconAsset,
              tone: tone,
              size: AppIconBadgeSize.sheet,
            ),
            Column(
              spacing: 8.h,
              children: [
                AppText(
                  title,
                  style: context.typography.titleM,
                  textAlign: TextAlign.center,
                ),
                AppText(
                  message,
                  color: context.colors.textSubTitle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            if (label != null && onAction != null)
              SizedBox(
                width: 200,
                child: AppFilledButton(
                  variant: AppFilledVariant.primarySoft,
                  onPressed: onAction,
                  child: AppText(
                    label,
                    style: context.typography.subtitleM.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    color: context.colors.buttonPrimary.onSoft,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
