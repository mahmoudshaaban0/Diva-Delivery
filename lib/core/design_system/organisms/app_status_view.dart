import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon_badge.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/responsive.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

enum AppStatusViewSize {
  /// 24-px title, 16 gaps, one soft 200-wide action (Flow 03 "لا توجد
  /// نتائج" / "أنهيت طلبات اليوم").
  large,

  /// 16-px title, 12 gaps, full-width filled action plus an optional soft
  /// one (Flow 08 "لا يوجد اتصال" / "تعذّر تحميل البيانات" / "لا توجد
  /// إشعارات").
  compact,
}

/// Centered empty / error state: `Courier/Status Icon`, title, text and
/// optional actions. See [AppStatusViewSize] for the two layouts.
class AppStatusView extends StatelessWidget {
  const AppStatusView({
    required this.iconAsset,
    required this.title,
    required this.message,
    this.tone = AppIconBadgeTone.brand,
    this.size = AppStatusViewSize.large,
    this.actionLabel,
    this.onAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    super.key,
  });

  /// A 26-px SVG icon.
  final String iconAsset;
  final AppIconBadgeTone tone;
  final AppStatusViewSize size;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  /// Compact only: a soft second action under the first.
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;

  @override
  Widget build(BuildContext context) {
    final isCompact = size == AppStatusViewSize.compact;
    final label = actionLabel;
    final secondaryLabel = secondaryActionLabel;
    final buttonStyle = context.typography.subtitleM.copyWith(
      fontWeight: FontWeight.w700,
    );

    return Center(
      child: SingleChildScrollView(
        padding: AppInsets.only(start: 20, end: 20, top: 16, bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: (isCompact ? 12 : 16).h,
          children: [
            AppIconBadge(
              assetPath: iconAsset,
              tone: tone,
              size: AppIconBadgeSize.sheet,
            ),
            Column(
              spacing: (isCompact ? 12 : 8).h,
              children: [
                AppText(
                  title,
                  style: isCompact
                      ? context.typography.title3XS
                      : context.typography.titleM,
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
              if (isCompact)
                Column(
                  spacing: 12.h,
                  children: [
                    AppFilledButton(
                      onPressed: onAction,
                      child: AppText(
                        label,
                        style: buttonStyle,
                        color: context.colors.buttonPrimary.label,
                      ),
                    ),
                    if (secondaryLabel != null && onSecondaryAction != null)
                      AppFilledButton(
                        variant: AppFilledVariant.primarySoft,
                        onPressed: onSecondaryAction,
                        child: AppText(
                          secondaryLabel,
                          style: buttonStyle,
                          color: context.colors.buttonPrimary.onSoft,
                        ),
                      ),
                  ],
                )
              else
                SizedBox(
                  width: 200,
                  child: AppFilledButton(
                    variant: AppFilledVariant.primarySoft,
                    onPressed: onAction,
                    child: AppText(
                      label,
                      style: buttonStyle,
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
