import 'package:flutter/material.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_filled_button.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_icon_badge.dart';
import 'package:limitless_code_template/core/design_system/atoms/app_text.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_insets.dart';
import 'package:limitless_code_template/core/design_system/tokens/app_spacing.dart';
import 'package:limitless_code_template/core/utility/extensions.dart';

/// Bottom sheet content (Figma `Courier/Bottom Sheet`): status icon, title,
/// description, swappable content (`Sheet Content/*`) and two actions.
/// Show it with `showAppBottomSheet(size: AppSheetSize.wrap, child: ...)`.
class AppStatusSheet extends StatelessWidget {
  const AppStatusSheet({
    required this.iconAsset,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.primaryLabel,
    required this.onPrimary,
    required this.secondaryLabel,
    required this.onSecondary,
    this.content,
    super.key,
  });

  /// A 26-px SVG icon for the status badge.
  final String iconAsset;
  final AppIconBadgeTone tone;
  final String title;
  final String subtitle;
  final Widget? content;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String secondaryLabel;
  final VoidCallback onSecondary;

  @override
  Widget build(BuildContext context) {
    final buttonLabel = context.typography.subtitleM.copyWith(
      fontWeight: FontWeight.w700,
    );

    return Padding(
      // Bottom: the home-indicator safe area (unscaled), like the design.
      padding: AppInsets.symmetric(horizontal: 20)
          .copyWith(bottom: MediaQuery.paddingOf(context).bottom + 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIconBadge(
            assetPath: iconAsset,
            tone: tone,
            size: AppIconBadgeSize.sheet,
          ),
          gapH20,
          AppText(
            title,
            style: context.typography.titleM,
            textAlign: TextAlign.center,
          ),
          gapH8,
          AppText(
            subtitle,
            color: context.colors.textSubTitle,
            textAlign: TextAlign.center,
          ),
          if (content != null) ...[gapH20, content!],
          gapH24,
          AppFilledButton(
            onPressed: onPrimary,
            child: AppText(
              primaryLabel,
              style: buttonLabel,
              color: context.colors.buttonPrimary.label,
            ),
          ),
          gapH12,
          AppFilledButton(
            variant: AppFilledVariant.primarySoft,
            onPressed: onSecondary,
            child: AppText(
              secondaryLabel,
              style: buttonLabel,
              color: context.colors.buttonPrimary.onSoft,
            ),
          ),
        ],
      ),
    );
  }
}
